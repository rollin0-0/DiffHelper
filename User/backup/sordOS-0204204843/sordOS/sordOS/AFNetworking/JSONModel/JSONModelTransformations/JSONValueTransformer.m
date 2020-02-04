




#import "JSONValueTransformer.h"

extern BOOL isNull(id value)
{
    if (!value) return YES;
    if ([value isKindOfClass:[NSNull class]]) return YES;

    return NO;
}

@implementation JSONValueTransformer

-(id)init
{
    self = [super init];
    if (self) {
        _primitivesNames = @{@"f":@"float", @"i":@"int", @"d":@"double", @"l":@"long", @"B":@"BOOL", @"s":@"short",
                             @"I":@"unsigned int", @"L":@"usigned long", @"q":@"long long", @"Q":@"unsigned long long", @"S":@"unsigned short", @"c":@"char", @"C":@"unsigned char",
                             
                             
                             @"I":@"NSInteger", @"Q":@"NSUInteger", @"B":@"BOOL",

                             @"@?":@"Block"};
    }
    return self;
}

+(Class)classByResolvingClusterClasses:(Class)sourceClass
{
    
    if ([sourceClass isSubclassOfClass:[NSString class]]) {
        return [NSString class];
    }

    
    if ([sourceClass isSubclassOfClass:[NSNumber class]]) {
        return [NSNumber class];
    }

    
    if ([sourceClass isSubclassOfClass:[NSArray class]]) {
        return [NSArray class];
    }

    
    if ([sourceClass isSubclassOfClass:[NSDictionary class]]) {
        return [NSDictionary class];
    }

    
    if ([sourceClass isSubclassOfClass:[NSDate class]]) {
        return [NSDate class];
    }

    
    return sourceClass;
}

-(NSMutableString*)NSMutableStringFromNSString:(NSString*)string
{
    return [NSMutableString stringWithString:string];
}

-(NSMutableArray*)NSMutableArrayFromNSArray:(NSArray*)array
{
    return [NSMutableArray arrayWithArray:array];
}

-(NSMutableDictionary*)NSMutableDictionaryFromNSDictionary:(NSDictionary*)dict
{
    return [NSMutableDictionary dictionaryWithDictionary:dict];
}

-(NSSet*)NSSetFromNSArray:(NSArray*)array
{
    return [NSSet setWithArray:array];
}

-(NSMutableSet*)NSMutableSetFromNSArray:(NSArray*)array
{
    return [NSMutableSet setWithArray:array];
}

-(id)JSONObjectFromNSSet:(NSSet*)set
{
    return [set allObjects];
}

-(id)JSONObjectFromNSMutableSet:(NSMutableSet*)set
{
    return [set allObjects];
}





-(NSNumber*)BOOLFromNSNumber:(NSNumber*)number
{
    if (isNull(number)) return [NSNumber numberWithBool:NO];
    return [NSNumber numberWithBool: number.intValue==0?NO:YES];
}

-(NSNumber*)BOOLFromNSString:(NSString*)string
{
    if (string != nil &&
        ([string caseInsensitiveCompare:@"true"] == NSOrderedSame ||
        [string caseInsensitiveCompare:@"yes"] == NSOrderedSame)) {
        return [NSNumber numberWithBool:YES];
    }
    return [NSNumber numberWithBool: ([string intValue]==0)?NO:YES];
}

-(NSNumber*)JSONObjectFromBOOL:(NSNumber*)number
{
    return [NSNumber numberWithBool: number.intValue==0?NO:YES];
}

-(float)floatFromObject:(id)obj
{
    return [obj floatValue];
}

-(float)floatFromNSString:(NSString*)string
{
    return [self floatFromObject:string];
}

-(float)floatFromNSNumber:(NSNumber*)number
{
    return [self floatFromObject:number];
}

-(NSNumber*)NSNumberFromfloat:(float)f
{
    return [NSNumber numberWithFloat:f];
}

-(NSNumber*)NSNumberFromNSString:(NSString*)string
{
    return [NSNumber numberWithDouble:[string doubleValue]];
}

-(NSString*)NSStringFromNSNumber:(NSNumber*)number
{
    return [number stringValue];
}

-(NSDecimalNumber*)NSDecimalNumberFromNSString:(NSString*)string
{
    return [NSDecimalNumber decimalNumberWithString:string];
}

-(NSString*)NSStringFromNSDecimalNumber:(NSDecimalNumber*)number
{
    return [number stringValue];
}

-(NSURL*)NSURLFromNSString:(NSString*)string
{
    
    
    return [NSURL URLWithString:string];
}

-(NSString*)JSONObjectFromNSURL:(NSURL*)url
{
    return [url absoluteString];
}

-(NSDateFormatter*)importDateFormatter
{
    static dispatch_once_t onceInput;
    static NSDateFormatter* inputDateFormatter;
    dispatch_once(&onceInput, ^{
        inputDateFormatter = [[NSDateFormatter alloc] init];
        [inputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [inputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HHmmssZZZ"];
    });
    return inputDateFormatter;
}

-(NSDate*)__NSDateFromNSString:(NSString*)string
{
    string = [string stringByReplacingOccurrencesOfString:@":" withString:@""]; 
    return [self.importDateFormatter dateFromString: string];
}

-(NSString*)__JSONObjectFromNSDate:(NSDate*)date
{
    static dispatch_once_t onceOutput;
    static NSDateFormatter *outputDateFormatter;
    dispatch_once(&onceOutput, ^{
        outputDateFormatter = [[NSDateFormatter alloc] init];
        [outputDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
        [outputDateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
    });
    return [outputDateFormatter stringFromDate:date];
}

- (NSDate*)NSDateFromNSNumber:(NSNumber*)number
{
    return [NSDate dateWithTimeIntervalSince1970:number.doubleValue];
}


- (NSTimeZone *)NSTimeZoneFromNSString:(NSString *)string {
    return [NSTimeZone timeZoneWithName:string];
}

- (id)JSONObjectFromNSTimeZone:(NSTimeZone *)timeZone {
    return [timeZone name];
}


-(NSDictionary*)__NSDictionaryFromNSArray:(NSArray*)array
{
    if (array.count==0) return @{};
    return (id)array;
}

-(NSMutableDictionary*)__NSMutableDictionaryFromNSArray:(NSArray*)array
{
    if (array.count==0) return [[self __NSDictionaryFromNSArray:array] mutableCopy];
    return (id)array;
}

@end
