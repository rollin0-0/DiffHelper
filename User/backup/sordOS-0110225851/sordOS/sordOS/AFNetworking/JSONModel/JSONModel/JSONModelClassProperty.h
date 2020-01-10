




#import <Foundation/Foundation.h>


@interface JSONModelClassProperty : NSObject


@property (assign, nonatomic) BOOL isIndex DEPRECATED_ATTRIBUTE;


@property (copy, nonatomic) NSString *name;


@property (assign, nonatomic) Class type;


@property (strong, nonatomic) NSString *structName;


@property (copy, nonatomic) NSString *protocol;


@property (assign, nonatomic) BOOL isOptional;


@property (assign, nonatomic) BOOL isStandardJSONType;


@property (assign, nonatomic) BOOL isMutable;


@property (assign, nonatomic) SEL customGetter;


@property (strong, nonatomic) NSMutableDictionary *customSetters;

@end
