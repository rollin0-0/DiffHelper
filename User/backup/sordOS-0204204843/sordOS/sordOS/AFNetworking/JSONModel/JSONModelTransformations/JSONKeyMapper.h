




#import <Foundation/Foundation.h>

typedef NSString *(^JSONModelKeyMapBlock)(NSString *keyName);


@interface JSONKeyMapper : NSObject


@property (readonly, nonatomic) JSONModelKeyMapBlock JSONToModelKeyBlock DEPRECATED_ATTRIBUTE;
- (NSString *)convertValue:(NSString *)value isImportingToModel:(BOOL)importing DEPRECATED_MSG_ATTRIBUTE("use convertValue:");
- (instancetype)initWithDictionary:(NSDictionary *)map DEPRECATED_MSG_ATTRIBUTE("use initWithModelToJSONDictionary:");
- (instancetype)initWithJSONToModelBlock:(JSONModelKeyMapBlock)toModel modelToJSONBlock:(JSONModelKeyMapBlock)toJSON DEPRECATED_MSG_ATTRIBUTE("use initWithModelToJSONBlock:");
+ (instancetype)mapper:(JSONKeyMapper *)baseKeyMapper withExceptions:(NSDictionary *)exceptions DEPRECATED_MSG_ATTRIBUTE("use baseMapper:withModelToJSONExceptions:");
+ (instancetype)mapperFromUnderscoreCaseToCamelCase DEPRECATED_MSG_ATTRIBUTE("use mapperForSnakeCase:");
+ (instancetype)mapperFromUpperCaseToLowerCase DEPRECATED_ATTRIBUTE;



@property (readonly, nonatomic) JSONModelKeyMapBlock modelToJSONKeyBlock;


- (NSString *)convertValue:(NSString *)value;




- (instancetype)initWithModelToJSONBlock:(JSONModelKeyMapBlock)toJSON;


- (instancetype)initWithModelToJSONDictionary:(NSDictionary <NSString *, NSString *> *)toJSON;


+ (instancetype)mapperForSnakeCase;


+ (instancetype)mapperForTitleCase;


+ (instancetype)baseMapper:(JSONKeyMapper *)baseKeyMapper withModelToJSONExceptions:(NSDictionary *)toJSON;

@end
