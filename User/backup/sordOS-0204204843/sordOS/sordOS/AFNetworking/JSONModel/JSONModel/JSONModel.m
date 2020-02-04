




#if !__has_feature(objc_arc)
#error The JSONMOdel framework is ARC only, you can enable ARC on per file basis.
#endif


#import <objc/runtime.h>
#import <objc/message.h>


#import "JSONModel.h"
#import "JSONModelClassProperty.h"

static const char * kMapperObjectKey;
static const char * kClassPropertiesKey;
static const char * kClassRequiredPropertyNamesKey;
static const char * kIndexPropertyNameKey;

static NSArray* allowedJSONTypes = nil;
static NSArray* allowedPrimitiveTypes = nil;
static JSONValueTransformer* valueTransformer = nil;
static Class JSONModelClass = NULL;

static JSONKeyMapper* globalKeyMapper = nil;

@implementation JSONModel
{
    NSString* _description;
}


+(void)load
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        

        @autoreleasepool {
            allowedJSONTypes = @[
                [NSString class], [NSNumber class], [NSDecimalNumber class], [NSArray class], [NSDictionary class], [NSNull class], 
                [NSMutableString class], [NSMutableArray class], [NSMutableDictionary class] 
            ];

            allowedPrimitiveTypes = @[
                @"BOOL", @"float", @"int", @"long", @"double", @"short",
                @"unsigned int", @"usigned long", @"long long", @"unsigned long long", @"unsigned short", @"char", @"unsigned char",
                
                @"NSInteger", @"NSUInteger",
                @"Block"
            ];

            valueTransformer = [[JSONValueTransformer alloc] init];

            
            
            

            
            
            JSONModelClass = NSClassFromString(NSStringFromClass(self));
        }
    });
}

-(void)__setup__
{
    
    if (!objc_getAssociatedObject(self.class, &kClassPropertiesKey)) {
        [self __inspectProperties];
    }

    
    id mapper = [[self class] keyMapper];
    if ( mapper && !objc_getAssociatedObject(self.class, &kMapperObjectKey) ) {
        objc_setAssociatedObject(
                                 self.class,
                                 &kMapperObjectKey,
                                 mapper,
                                 OBJC_ASSOCIATION_RETAIN 
                                 );
    }
}

-(id)init
{
    self = [super init];
    if (self) {
        
        [self __setup__];
    }
    return self;
}

-(instancetype)initWithData:(NSData *)data error:(NSError *__autoreleasing *)err
{
    
    if (!data) {
        if (err) *err = [JSONModelError errorInputIsNil];
        return nil;
    }
    
    JSONModelError* initError = nil;
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:kNilOptions
                                               error:&initError];

    if (initError) {
        if (err) *err = [JSONModelError errorBadJSON];
        return nil;
    }

    
    id objModel = [self initWithDictionary:obj error:&initError];
    if (initError && err) *err = initError;
    return objModel;
}

-(id)initWithString:(NSString*)string error:(JSONModelError**)err
{
    JSONModelError* initError = nil;
    id objModel = [self initWithString:string usingEncoding:NSUTF8StringEncoding error:&initError];
    if (initError && err) *err = initError;
    return objModel;
}

-(id)initWithString:(NSString *)string usingEncoding:(NSStringEncoding)encoding error:(JSONModelError**)err
{
    
    if (!string) {
        if (err) *err = [JSONModelError errorInputIsNil];
        return nil;
    }

    JSONModelError* initError = nil;
    id objModel = [self initWithData:[string dataUsingEncoding:encoding] error:&initError];
    if (initError && err) *err = initError;
    return objModel;

}

-(id)initWithDictionary:(NSDictionary*)dict error:(NSError**)err
{
    
    if (!dict) {
        if (err) *err = [JSONModelError errorInputIsNil];
        return nil;
    }

    
    if (![dict isKindOfClass:[NSDictionary class]]) {
        if (err) *err = [JSONModelError errorInvalidDataWithMessage:@"Attempt to initialize JSONModel object using initWithDictionary:error: but the dictionary parameter was not an 'NSDictionary'."];
        return nil;
    }

    
    self = [self init];
    if (!self) {

        
        if (err) *err = [JSONModelError errorModelIsInvalid];
        return nil;
    }

    
    if (![self __doesDictionary:dict matchModelWithKeyMapper:self.__keyMapper error:err]) {
        return nil;
    }

    
    if (![self __importDictionary:dict withKeyMapper:self.__keyMapper validation:YES error:err]) {
        return nil;
    }

    
    if (![self validate:err]) {
        return nil;
    }

    
    return self;
}

-(JSONKeyMapper*)__keyMapper
{
    
    return objc_getAssociatedObject(self.class, &kMapperObjectKey);
}

-(BOOL)__doesDictionary:(NSDictionary*)dict matchModelWithKeyMapper:(JSONKeyMapper*)keyMapper error:(NSError**)err
{
    
    NSArray* incomingKeysArray = [dict allKeys];
    NSMutableSet* requiredProperties = [self __requiredPropertyNames].mutableCopy;
    NSSet* incomingKeys = [NSSet setWithArray: incomingKeysArray];

    
    if (keyMapper || globalKeyMapper) {

        NSMutableSet* transformedIncomingKeys = [NSMutableSet setWithCapacity: requiredProperties.count];
        NSString* transformedName = nil;

        
        for (JSONModelClassProperty* property in [self __properties__]) {

            transformedName = (keyMapper||globalKeyMapper) ? [self __mapString:property.name withKeyMapper:keyMapper] : property.name;

            
            id value;
            @try {
                value = [dict valueForKeyPath:transformedName];
            }
            @catch (NSException *exception) {
                value = dict[transformedName];
            }

            if (value) {
                [transformedIncomingKeys addObject: property.name];
            }
        }

        
        incomingKeys = transformedIncomingKeys;
    }

    
    if (![requiredProperties isSubsetOfSet:incomingKeys]) {

        
        [requiredProperties minusSet:incomingKeys];

        
        JMLog(@"Incoming data was invalid [%@ initWithDictionary:]. Keys missing: %@", self.class, requiredProperties);

        if (err) *err = [JSONModelError errorInvalidDataWithMissingKeys:requiredProperties];
        return NO;
    }

    
    incomingKeys= nil;
    requiredProperties= nil;

    return YES;
}

-(NSString*)__mapString:(NSString*)string withKeyMapper:(JSONKeyMapper*)keyMapper
{
    if (keyMapper) {
        
        NSString* mappedName = [keyMapper convertValue:string];
        if (globalKeyMapper && [mappedName isEqualToString: string]) {
            mappedName = [globalKeyMapper convertValue:string];
        }
        string = mappedName;
    } else if (globalKeyMapper) {
        
        string = [globalKeyMapper convertValue:string];
    }

    return string;
}

-(BOOL)__importDictionary:(NSDictionary*)dict withKeyMapper:(JSONKeyMapper*)keyMapper validation:(BOOL)validation error:(NSError**)err
{
    
    for (JSONModelClassProperty* property in [self __properties__]) {

        
        NSString* jsonKeyPath = (keyMapper||globalKeyMapper) ? [self __mapString:property.name withKeyMapper:keyMapper] : property.name;
        

        
        id jsonValue;
        @try {
            jsonValue = [dict valueForKeyPath: jsonKeyPath];
        }
        @catch (NSException *exception) {
            jsonValue = dict[jsonKeyPath];
        }

        
        if (isNull(jsonValue)) {
            
            if (property.isOptional || !validation) continue;

            if (err) {
                
                NSString* msg = [NSString stringWithFormat:@"Value of required model key %@ is null", property.name];
                JSONModelError* dataErr = [JSONModelError errorInvalidDataWithMessage:msg];
                *err = [dataErr errorByPrependingKeyPathComponent:property.name];
            }
            return NO;
        }

        Class jsonValueClass = [jsonValue class];
        BOOL isValueOfAllowedType = NO;

        for (Class allowedType in allowedJSONTypes) {
            if ( [jsonValueClass isSubclassOfClass: allowedType] ) {
                isValueOfAllowedType = YES;
                break;
            }
        }

        if (isValueOfAllowedType==NO) {
            
            JMLog(@"Type %@ is not allowed in JSON.", NSStringFromClass(jsonValueClass));

            if (err) {
                NSString* msg = [NSString stringWithFormat:@"Type %@ is not allowed in JSON.", NSStringFromClass(jsonValueClass)];
                JSONModelError* dataErr = [JSONModelError errorInvalidDataWithMessage:msg];
                *err = [dataErr errorByPrependingKeyPathComponent:property.name];
            }
            return NO;
        }

        
        if (property) {

            
            
            if ([self __customSetValue:jsonValue forProperty:property]) {
                
                continue;
            };

            
            if (property.type == nil && property.structName==nil) {

                
                if (jsonValue != [self valueForKey:property.name]) {
                    [self setValue:jsonValue forKey: property.name];
                }

                
                continue;
            }

            
            if (isNull(jsonValue)) {
                if ([self valueForKey:property.name] != nil) {
                    [self setValue:nil forKey: property.name];
                }
                continue;
            }


            
            if ([self __isJSONModelSubClass:property.type]) {

                
                JSONModelError* initErr = nil;
                id value = [[property.type alloc] initWithDictionary: jsonValue error:&initErr];

                if (!value) {
                    
                    if (property.isOptional || !validation) continue;

                    
                    if((err != nil) && (initErr != nil))
                    {
                        *err = [initErr errorByPrependingKeyPathComponent:property.name];
                    }
                    return NO;
                }
                if (![value isEqual:[self valueForKey:property.name]]) {
                    [self setValue:value forKey: property.name];
                }

                
                continue;

            } else {

                
                
                if (property.protocol) {

                    
                    jsonValue = [self __transform:jsonValue forProperty:property error:err];
                    if (!jsonValue) {
                        if ((err != nil) && (*err == nil)) {
                            NSString* msg = [NSString stringWithFormat:@"Failed to transform value, but no error was set during transformation. (%@)", property];
                            JSONModelError* dataErr = [JSONModelError errorInvalidDataWithMessage:msg];
                            *err = [dataErr errorByPrependingKeyPathComponent:property.name];
                        }
                        return NO;
                    }
                }

                
                if (property.isStandardJSONType && [jsonValue isKindOfClass: property.type]) {

                    
                    if (property.isMutable) {
                        jsonValue = [jsonValue mutableCopy];
                    }

                    
                    if (![jsonValue isEqual:[self valueForKey:property.name]]) {
                        [self setValue:jsonValue forKey: property.name];
                    }
                    continue;
                }

                
                if (
                    (![jsonValue isKindOfClass:property.type] && !isNull(jsonValue))
                    ||
                    
                    property.isMutable
                    ||
                    
                    property.structName
                    ) {

                    
                    
                    Class sourceClass = [JSONValueTransformer classByResolvingClusterClasses:[jsonValue class]];

                    

                    
                    NSString* selectorName = [NSString stringWithFormat:@"%@From%@:",
                                              (property.structName? property.structName : property.type), 
                                              sourceClass]; 
                    SEL selector = NSSelectorFromString(selectorName);

                    
                    BOOL foundCustomTransformer = NO;
                    if ([valueTransformer respondsToSelector:selector]) {
                        foundCustomTransformer = YES;
                    } else {
                        
                        selectorName = [NSString stringWithFormat:@"__%@",selectorName];
                        selector = NSSelectorFromString(selectorName);
                        if ([valueTransformer respondsToSelector:selector]) {
                            foundCustomTransformer = YES;
                        }
                    }

                    
                    if (foundCustomTransformer) {
                        IMP imp = [valueTransformer methodForSelector:selector];
                        id (*func)(id, SEL, id) = (void *)imp;
                        jsonValue = func(valueTransformer, selector, jsonValue);

                        if (![jsonValue isEqual:[self valueForKey:property.name]])
                            [self setValue:jsonValue forKey:property.name];
                    } else {
                        if (err) {
                            NSString* msg = [NSString stringWithFormat:@"%@ type not supported for %@.%@", property.type, [self class], property.name];
                            JSONModelError* dataErr = [JSONModelError errorInvalidDataWithTypeMismatch:msg];
                            *err = [dataErr errorByPrependingKeyPathComponent:property.name];
                        }
                        return NO;
                    }
                } else {
                    
                    if (![jsonValue isEqual:[self valueForKey:property.name]])
                        [self setValue:jsonValue forKey:property.name];
                }
            }
        }
    }

    return YES;
}


-(BOOL)__isJSONModelSubClass:(Class)class
{

#ifdef UNIT_TESTING
    return [@"JSONModel" isEqualToString: NSStringFromClass([class superclass])];
#else
    return [class isSubclassOfClass:JSONModelClass];
#endif
}


-(NSMutableSet*)__requiredPropertyNames
{
    
    NSMutableSet* classRequiredPropertyNames = objc_getAssociatedObject(self.class, &kClassRequiredPropertyNamesKey);

    if (!classRequiredPropertyNames) {
        classRequiredPropertyNames = [NSMutableSet set];
        [[self __properties__] enumerateObjectsUsingBlock:^(JSONModelClassProperty* p, NSUInteger idx, BOOL *stop) {
            if (!p.isOptional) [classRequiredPropertyNames addObject:p.name];
        }];

        
        objc_setAssociatedObject(
                                 self.class,
                                 &kClassRequiredPropertyNamesKey,
                                 classRequiredPropertyNames,
                                 OBJC_ASSOCIATION_RETAIN 
                                 );
    }
    return classRequiredPropertyNames;
}


-(NSArray*)__properties__
{
    
    NSDictionary* classProperties = objc_getAssociatedObject(self.class, &kClassPropertiesKey);
    if (classProperties) return [classProperties allValues];

    
    [self __setup__];

    
    classProperties = objc_getAssociatedObject(self.class, &kClassPropertiesKey);
    return [classProperties allValues];
}


-(void)__inspectProperties
{
    

    NSMutableDictionary* propertyIndex = [NSMutableDictionary dictionary];

    
    Class class = [self class];
    NSScanner* scanner = nil;
    NSString* propertyType = nil;

    
    while (class != [JSONModel class]) {
        

        unsigned int propertyCount;
        objc_property_t *properties = class_copyPropertyList(class, &propertyCount);

        
        for (unsigned int i = 0; i < propertyCount; i++) {

            JSONModelClassProperty* p = [[JSONModelClassProperty alloc] init];

            
            objc_property_t property = properties[i];
            const char *propertyName = property_getName(property);
            p.name = @(propertyName);

            

            
            const char *attrs = property_getAttributes(property);
            NSString* propertyAttributes = @(attrs);
            NSArray* attributeItems = [propertyAttributes componentsSeparatedByString:@","];

            
            if ([attributeItems containsObject:@"R"]) {
                continue; 
            }

            scanner = [NSScanner scannerWithString: propertyAttributes];

            
            [scanner scanUpToString:@"T" intoString: nil];
            [scanner scanString:@"T" intoString:nil];

            
            if ([scanner scanString:@"@\"" intoString: &propertyType]) {

                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"<"]
                                        intoString:&propertyType];

                
                p.type = NSClassFromString(propertyType);
                p.isMutable = ([propertyType rangeOfString:@"Mutable"].location != NSNotFound);
                p.isStandardJSONType = [allowedJSONTypes containsObject:p.type];

                
                while ([scanner scanString:@"<" intoString:NULL]) {

                    NSString* protocolName = nil;

                    [scanner scanUpToString:@">" intoString: &protocolName];

                    if ([protocolName isEqualToString:@"Optional"]) {
                        p.isOptional = YES;
                    } else if([protocolName isEqualToString:@"Index"]) {
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
                        p.isIndex = YES;
#pragma GCC diagnostic pop

                        objc_setAssociatedObject(
                                                 self.class,
                                                 &kIndexPropertyNameKey,
                                                 p.name,
                                                 OBJC_ASSOCIATION_RETAIN 
                                                 );
                    } else if([protocolName isEqualToString:@"Ignore"]) {
                        p = nil;
                    } else {
                        p.protocol = protocolName;
                    }

                    [scanner scanString:@">" intoString:NULL];
                }

            }
            
            else if ([scanner scanString:@"{" intoString: &propertyType]) {
                [scanner scanCharactersFromSet:[NSCharacterSet alphanumericCharacterSet]
                                    intoString:&propertyType];

                p.isStandardJSONType = NO;
                p.structName = propertyType;

            }
            
            else {

                
                [scanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@","]
                                        intoString:&propertyType];

                
                propertyType = valueTransformer.primitivesNames[propertyType];

                if (![allowedPrimitiveTypes containsObject:propertyType]) {

                    
                    @throw [NSException exceptionWithName:@"JSONModelProperty type not allowed"
                                                   reason:[NSString stringWithFormat:@"Property type of %@.%@ is not supported by JSONModel.", self.class, p.name]
                                                 userInfo:nil];
                }

            }

            NSString *nsPropertyName = @(propertyName);
            if([[self class] propertyIsOptional:nsPropertyName]){
                p.isOptional = YES;
            }

            if([[self class] propertyIsIgnored:nsPropertyName]){
                p = nil;
            }

            Class customClass = [[self class] classForCollectionProperty:nsPropertyName];
            if (customClass) {
                p.protocol = NSStringFromClass(customClass);
            }

            
            if ([propertyType isEqualToString:@"Block"]) {
                p = nil;
            }

            
            if (p && ![propertyIndex objectForKey:p.name]) {
                [propertyIndex setValue:p forKey:p.name];
            }

            
            if (p)
            {
                NSString *name = [p.name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[p.name substringToIndex:1].uppercaseString];

                
                SEL getter = NSSelectorFromString([NSString stringWithFormat:@"JSONObjectFor%@", name]);

                if ([self respondsToSelector:getter])
                    p.customGetter = getter;

                
                p.customSetters = [NSMutableDictionary new];

                SEL genericSetter = NSSelectorFromString([NSString stringWithFormat:@"set%@WithJSONObject:", name]);

                if ([self respondsToSelector:genericSetter])
                    p.customSetters[@"generic"] = [NSValue valueWithBytes:&genericSetter objCType:@encode(SEL)];

                for (Class type in allowedJSONTypes)
                {
                    NSString *class = NSStringFromClass([JSONValueTransformer classByResolvingClusterClasses:type]);

                    if (p.customSetters[class])
                        continue;

                    SEL setter = NSSelectorFromString([NSString stringWithFormat:@"set%@With%@:", name, class]);

                    if ([self respondsToSelector:setter])
                        p.customSetters[class] = [NSValue valueWithBytes:&setter objCType:@encode(SEL)];
                }
            }
        }

        free(properties);

        
        
        class = [class superclass];
    }

    
    objc_setAssociatedObject(
                             self.class,
                             &kClassPropertiesKey,
                             [propertyIndex copy],
                             OBJC_ASSOCIATION_RETAIN 
                             );
}


-(id)__transform:(id)value forProperty:(JSONModelClassProperty*)property error:(NSError**)err
{
    Class protocolClass = NSClassFromString(property.protocol);
    if (!protocolClass) {

        
        
        if ([value isKindOfClass:[NSArray class]]) {
            @throw [NSException exceptionWithName:@"Bad property protocol declaration"
                                           reason:[NSString stringWithFormat:@"<%@> is not allowed JSONModel property protocol, and not a JSONModel class.", property.protocol]
                                         userInfo:nil];
        }
        return value;
    }

    
    if ([self __isJSONModelSubClass:protocolClass]) {

        
        if ([property.type isSubclassOfClass:[NSArray class]]) {

            
            if(![[value class] isSubclassOfClass:[NSArray class]])
            {
                if(err != nil)
                {
                    NSString* mismatch = [NSString stringWithFormat:@"Property '%@' is declared as NSArray<%@>* but the corresponding JSON value is not a JSON Array.", property.name, property.protocol];
                    JSONModelError* typeErr = [JSONModelError errorInvalidDataWithTypeMismatch:mismatch];
                    *err = [typeErr errorByPrependingKeyPathComponent:property.name];
                }
                return nil;
            }

            
            JSONModelError* arrayErr = nil;
            value = [[protocolClass class] arrayOfModelsFromDictionaries:value error:&arrayErr];
            if((err != nil) && (arrayErr != nil))
            {
                *err = [arrayErr errorByPrependingKeyPathComponent:property.name];
                return nil;
            }
        }

        
        if ([property.type isSubclassOfClass:[NSDictionary class]]) {

            
            if(![[value class] isSubclassOfClass:[NSDictionary class]])
            {
                if(err != nil)
                {
                    NSString* mismatch = [NSString stringWithFormat:@"Property '%@' is declared as NSDictionary<%@>* but the corresponding JSON value is not a JSON Object.", property.name, property.protocol];
                    JSONModelError* typeErr = [JSONModelError errorInvalidDataWithTypeMismatch:mismatch];
                    *err = [typeErr errorByPrependingKeyPathComponent:property.name];
                }
                return nil;
            }

            NSMutableDictionary* res = [NSMutableDictionary dictionary];

            for (NSString* key in [value allKeys]) {
                JSONModelError* initErr = nil;
                id obj = [[[protocolClass class] alloc] initWithDictionary:value[key] error:&initErr];
                if (obj == nil)
                {
                    
                    if((err != nil) && (initErr != nil))
                    {
                        initErr = [initErr errorByPrependingKeyPathComponent:key];
                        *err = [initErr errorByPrependingKeyPathComponent:property.name];
                    }
                    return nil;
                }
                [res setValue:obj forKey:key];
            }
            value = [NSDictionary dictionaryWithDictionary:res];
        }
    }

    return value;
}


-(id)__reverseTransform:(id)value forProperty:(JSONModelClassProperty*)property
{
    Class protocolClass = NSClassFromString(property.protocol);
    if (!protocolClass) return value;

    
    if ([self __isJSONModelSubClass:protocolClass]) {

        
        if (property.type == [NSArray class] || property.type == [NSMutableArray class]) {
            NSMutableArray* tempArray = [NSMutableArray arrayWithCapacity: [(NSArray*)value count] ];
            for (NSObject<AbstractJSONModelProtocol>* model in (NSArray*)value) {
                if ([model respondsToSelector:@selector(toDictionary)]) {
                    [tempArray addObject: [model toDictionary]];
                } else
                    [tempArray addObject: model];
            }
            return [tempArray copy];
        }

        
        if (property.type == [NSDictionary class] || property.type == [NSMutableDictionary class]) {
            NSMutableDictionary* res = [NSMutableDictionary dictionary];
            for (NSString* key in [(NSDictionary*)value allKeys]) {
                id<AbstractJSONModelProtocol> model = value[key];
                [res setValue: [model toDictionary] forKey: key];
            }
            return [NSDictionary dictionaryWithDictionary:res];
        }
    }

    return value;
}

- (BOOL)__customSetValue:(id <NSObject>)value forProperty:(JSONModelClassProperty *)property
{
    NSString *class = NSStringFromClass([JSONValueTransformer classByResolvingClusterClasses:[value class]]);

    SEL setter = nil;
    [property.customSetters[class] getValue:&setter];

    if (!setter)
        [property.customSetters[@"generic"] getValue:&setter];

    if (!setter)
        return NO;

    IMP imp = [self methodForSelector:setter];
    void (*func)(id, SEL, id <NSObject>) = (void *)imp;
    func(self, setter, value);

    return YES;
}

- (BOOL)__customGetValue:(id *)value forProperty:(JSONModelClassProperty *)property
{
    SEL getter = property.customGetter;

    if (!getter)
        return NO;

    IMP imp = [self methodForSelector:getter];
    id (*func)(id, SEL) = (void *)imp;
    *value = func(self, getter);

    return YES;
}

-(void)__createDictionariesForKeyPath:(NSString*)keyPath inDictionary:(NSMutableDictionary**)dict
{
    
    NSUInteger dotLocation = [keyPath rangeOfString:@"."].location;
    if (dotLocation==NSNotFound) return;

    
    NSString* nextHierarchyLevelKeyName = [keyPath substringToIndex: dotLocation];
    NSDictionary* nextLevelDictionary = (*dict)[nextHierarchyLevelKeyName];

    if (nextLevelDictionary==nil) {
        
        nextLevelDictionary = [NSMutableDictionary dictionary];
    }

    
    [self __createDictionariesForKeyPath:[keyPath substringFromIndex: dotLocation+1]
                            inDictionary:&nextLevelDictionary ];

    
    [*dict setValue:nextLevelDictionary  forKeyPath: nextHierarchyLevelKeyName];
}

-(NSDictionary*)toDictionary
{
    return [self toDictionaryWithKeys:nil];
}

-(NSString*)toJSONString
{
    return [self toJSONStringWithKeys:nil];
}

-(NSData*)toJSONData
{
    return [self toJSONDataWithKeys:nil];
}


- (NSDictionary *)toDictionaryWithKeys:(NSArray <NSString *> *)propertyNames
{
    NSArray* properties = [self __properties__];
    NSMutableDictionary* tempDictionary = [NSMutableDictionary dictionaryWithCapacity:properties.count];

    id value;

    
    for (JSONModelClassProperty* p in properties) {

        
        if (propertyNames != nil && ![propertyNames containsObject:p.name])
            continue;

        
        NSString* keyPath = (self.__keyMapper||globalKeyMapper) ? [self __mapString:p.name withKeyMapper:self.__keyMapper] : p.name;
        value = [self valueForKey: p.name];

        

        if ([keyPath rangeOfString:@"."].location != NSNotFound) {
            
            [self __createDictionariesForKeyPath:keyPath inDictionary:&tempDictionary];
        }

        
        if ([self __customGetValue:&value forProperty:p]) {
            
            [tempDictionary setValue:value forKeyPath:keyPath];
            continue;
        }

        
        
        if (isNull(value)) {

            if (value == nil)
            {
                [tempDictionary removeObjectForKey:keyPath];
            }
            else
            {
                [tempDictionary setValue:[NSNull null] forKeyPath:keyPath];
            }
            continue;
        }

        
        if ([value isKindOfClass:JSONModelClass]) {

            
            value = [(JSONModel*)value toDictionary];
            [tempDictionary setValue:value forKeyPath: keyPath];

            
            continue;

        } else {

            
            if (p.protocol) {
                value = [self __reverseTransform:value forProperty:p];
            }

            
            if (p.structName==nil && (p.isStandardJSONType || p.type==nil)) {

                
                [tempDictionary setValue:value forKeyPath: keyPath];

                continue;
            }

            
            if (YES) {

                
                NSString* selectorName = [NSString stringWithFormat:@"%@From%@:", @"JSONObject", p.type?p.type:p.structName];
                SEL selector = NSSelectorFromString(selectorName);

                BOOL foundCustomTransformer = NO;
                if ([valueTransformer respondsToSelector:selector]) {
                    foundCustomTransformer = YES;
                } else {
                    
                    selectorName = [NSString stringWithFormat:@"__%@",selectorName];
                    selector = NSSelectorFromString(selectorName);
                    if ([valueTransformer respondsToSelector:selector]) {
                        foundCustomTransformer = YES;
                    }
                }

                
                if (foundCustomTransformer) {
                    IMP imp = [valueTransformer methodForSelector:selector];
                    id (*func)(id, SEL, id) = (void *)imp;
                    value = func(valueTransformer, selector, value);

                    [tempDictionary setValue:value forKeyPath:keyPath];
                } else {
                    
                    
                    @throw [NSException exceptionWithName:@"Value transformer not found"
                                                   reason:[NSString stringWithFormat:@"[JSONValueTransformer %@] not found", selectorName]
                                                 userInfo:nil];
                    return nil;
                }
            }
        }
    }

    return [tempDictionary copy];
}


- (NSData *)toJSONDataWithKeys:(NSArray <NSString *> *)propertyNames
{
    NSData* jsonData = nil;
    NSError* jsonError = nil;

    @try {
        NSDictionary* dict = [self toDictionaryWithKeys:propertyNames];
        jsonData = [NSJSONSerialization dataWithJSONObject:dict options:kNilOptions error:&jsonError];
    }
    @catch (NSException *exception) {
        
        
        JMLog(@"EXCEPTION: %@", exception.description);
        return nil;
    }

    return jsonData;
}

- (NSString *)toJSONStringWithKeys:(NSArray <NSString *> *)propertyNames
{
    return [[NSString alloc] initWithData: [self toJSONDataWithKeys: propertyNames]
                                 encoding: NSUTF8StringEncoding];
}


+(NSMutableArray*)arrayOfModelsFromDictionaries:(NSArray*)array
{
    return [self arrayOfModelsFromDictionaries:array error:nil];
}

+ (NSMutableArray *)arrayOfModelsFromData:(NSData *)data error:(NSError **)err
{
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:err];
    if (!json || ![json isKindOfClass:[NSArray class]]) return nil;

    return [self arrayOfModelsFromDictionaries:json error:err];
}

+ (NSMutableArray *)arrayOfModelsFromString:(NSString *)string error:(NSError **)err
{
    return [self arrayOfModelsFromData:[string dataUsingEncoding:NSUTF8StringEncoding] error:err];
}


+(NSMutableArray*)arrayOfModelsFromDictionaries:(NSArray*)array error:(NSError**)err
{
    
    if (isNull(array)) return nil;

    
    NSMutableArray* list = [NSMutableArray arrayWithCapacity: [array count]];

    for (id d in array)
    {
        if ([d isKindOfClass:NSDictionary.class])
        {
            JSONModelError* initErr = nil;
            id obj = [[self alloc] initWithDictionary:d error:&initErr];
            if (obj == nil)
            {
                
                if((err != nil) && (initErr != nil))
                {
                    NSString* path = [NSString stringWithFormat:@"[%lu]", (unsigned long)list.count];
                    *err = [initErr errorByPrependingKeyPathComponent:path];
                }
                return nil;
            }

            [list addObject: obj];
        } else if ([d isKindOfClass:NSArray.class])
        {
            [list addObjectsFromArray:[self arrayOfModelsFromDictionaries:d error:err]];
        } else
        {
            
        }

    }

    return list;
}

+ (NSMutableDictionary *)dictionaryOfModelsFromString:(NSString *)string error:(NSError **)err
{
    return [self dictionaryOfModelsFromData:[string dataUsingEncoding:NSUTF8StringEncoding] error:err];
}

+ (NSMutableDictionary *)dictionaryOfModelsFromData:(NSData *)data error:(NSError **)err
{
    id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:err];
    if (!json || ![json isKindOfClass:[NSDictionary class]]) return nil;

    return [self dictionaryOfModelsFromDictionary:json error:err];
}

+ (NSMutableDictionary *)dictionaryOfModelsFromDictionary:(NSDictionary *)dictionary error:(NSError **)err
{
    NSMutableDictionary *output = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];

    for (NSString *key in dictionary.allKeys)
    {
        id object = dictionary[key];

        if ([object isKindOfClass:NSDictionary.class])
        {
            id obj = [[self alloc] initWithDictionary:object error:err];
            if (obj == nil) return nil;
            output[key] = obj;
        }
        else if ([object isKindOfClass:NSArray.class])
        {
            id obj = [self arrayOfModelsFromDictionaries:object error:err];
            if (obj == nil) return nil;
            output[key] = obj;
        }
        else
        {
            if (err) {
                *err = [JSONModelError errorInvalidDataWithTypeMismatch:@"Only dictionaries and arrays are supported"];
            }
            return nil;
        }
    }

    return output;
}


+(NSMutableArray*)arrayOfDictionariesFromModels:(NSArray*)array
{
    
    if (isNull(array)) return nil;

    
    NSMutableArray* list = [NSMutableArray arrayWithCapacity: [array count]];

    for (id<AbstractJSONModelProtocol> object in array) {

        id obj = [object toDictionary];
        if (!obj) return nil;

        [list addObject: obj];
    }
    return list;
}


+(NSMutableArray*)arrayOfDictionariesFromModels:(NSArray*)array propertyNamesToExport:(NSArray*)propertyNamesToExport;
{
    
    if (isNull(array)) return nil;

    
    NSMutableArray* list = [NSMutableArray arrayWithCapacity: [array count]];

    for (id<AbstractJSONModelProtocol> object in array) {

        id obj = [object toDictionaryWithKeys:propertyNamesToExport];
        if (!obj) return nil;

        [list addObject: obj];
    }
    return list;
}

+(NSMutableDictionary *)dictionaryOfDictionariesFromModels:(NSDictionary *)dictionary
{
    
    if (isNull(dictionary)) return nil;

    NSMutableDictionary *output = [NSMutableDictionary dictionaryWithCapacity:dictionary.count];

    for (NSString *key in dictionary.allKeys) {
        id <AbstractJSONModelProtocol> object = dictionary[key];
        id obj = [object toDictionary];
        if (!obj) return nil;
        output[key] = obj;
    }

    return output;
}


#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
-(NSString*)indexPropertyName
{
    
    return objc_getAssociatedObject(self.class, &kIndexPropertyNameKey);
}

-(BOOL)isEqual:(id)object
{
    
    if (![object isMemberOfClass:[self class]]) return NO;

    if (self.indexPropertyName) {
        
        id objectId = [object valueForKey: self.indexPropertyName];
        return [[self valueForKey: self.indexPropertyName] isEqual:objectId];
    }

    
    return [super isEqual:object];
}

-(NSComparisonResult)compare:(id)object
{
    if (self.indexPropertyName) {
        id objectId = [object valueForKey: self.indexPropertyName];
        if ([objectId respondsToSelector:@selector(compare:)]) {
            return [[self valueForKey:self.indexPropertyName] compare:objectId];
        }
    }

    
    
    NSAssert(self.indexPropertyName, @"Can't compare models with no <Index> property");
    NSAssert1(NO, @"The <Index> property of %@ is not comparable class.", [self class]);
    return kNilOptions;
}

- (NSUInteger)hash
{
    if (self.indexPropertyName) {
        id val = [self valueForKey:self.indexPropertyName];

        if (val) {
            return [val hash];
        }
    }

    return [super hash];
}

#pragma GCC diagnostic pop

-(BOOL)validate:(NSError**)error
{
    return YES;
}


-(NSString*)description
{
    NSMutableString* text = [NSMutableString stringWithFormat:@"<%@> \n", [self class]];

    for (JSONModelClassProperty *p in [self __properties__]) {

        id value = ([p.name isEqualToString:@"description"])?self->_description:[self valueForKey:p.name];
        NSString* valueDescription = (value)?[value description]:@"<nil>";

        if (p.isStandardJSONType && ![value respondsToSelector:@selector(count)] && [valueDescription length]>60) {

            
            valueDescription = [NSString stringWithFormat:@"%@...", [valueDescription substringToIndex:59]];
        }
        valueDescription = [valueDescription stringByReplacingOccurrencesOfString:@"\n" withString:@"\n   "];
        [text appendFormat:@"   [%@]: %@\n", p.name, valueDescription];
    }

    [text appendFormat:@"</%@>", [self class]];
    return text;
}

+(JSONKeyMapper*)keyMapper
{
    return nil;
}

+(void)setGlobalKeyMapper:(JSONKeyMapper*)globalKeyMapperParam
{
    globalKeyMapper = globalKeyMapperParam;
}

+(BOOL)propertyIsOptional:(NSString*)propertyName
{
    return NO;
}

+(BOOL)propertyIsIgnored:(NSString *)propertyName
{
    return NO;
}

+(NSString*)protocolForArrayProperty:(NSString *)propertyName
{
    return nil;
}

+(Class)classForCollectionProperty:(NSString *)propertyName
{
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    NSString *protocolName = [self protocolForArrayProperty:propertyName];
#pragma GCC diagnostic pop

    if (!protocolName)
        return nil;

    return NSClassFromString(protocolName);
}

- (void)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping
{
    [self mergeFromDictionary:dict useKeyMapping:useKeyMapping error:nil];
}

- (BOOL)mergeFromDictionary:(NSDictionary *)dict useKeyMapping:(BOOL)useKeyMapping error:(NSError **)error
{
    return [self __importDictionary:dict withKeyMapper:(useKeyMapping)? self.__keyMapper:nil validation:NO error:error];
}

-(instancetype)copyWithZone:(NSZone *)zone
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:
        [NSKeyedArchiver archivedDataWithRootObject:self]
     ];
}

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    NSString* json;

    if ([decoder respondsToSelector:@selector(decodeObjectOfClass:forKey:)]) {
        json = [decoder decodeObjectOfClass:[NSString class] forKey:@"json"];
    } else {
        json = [decoder decodeObjectForKey:@"json"];
    }

    JSONModelError *error = nil;
    self = [self initWithString:json error:&error];
    if (error) {
        JMLog(@"%@",[error localizedDescription]);
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.toJSONString forKey:@"json"];
}

+ (BOOL)supportsSecureCoding
{
    return YES;
}

@end
