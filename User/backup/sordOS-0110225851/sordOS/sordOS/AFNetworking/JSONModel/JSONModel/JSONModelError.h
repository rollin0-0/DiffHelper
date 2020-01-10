




#import <Foundation/Foundation.h>


typedef NS_ENUM(int, kJSONModelErrorTypes)
{
    kJSONModelErrorInvalidData = 1,
    kJSONModelErrorBadResponse = 2,
    kJSONModelErrorBadJSON = 3,
    kJSONModelErrorModelIsInvalid = 4,
    kJSONModelErrorNilInput = 5
};



extern NSString *const JSONModelErrorDomain;


extern NSString *const kJSONModelMissingKeys;


extern NSString *const kJSONModelTypeMismatch;


extern NSString *const kJSONModelKeyPath;



@interface JSONModelError : NSError

@property (strong, nonatomic) NSHTTPURLResponse *httpResponse;

@property (strong, nonatomic) NSData *responseData;


+ (id)errorInvalidDataWithMessage:(NSString *)message;


+ (id)errorInvalidDataWithMissingKeys:(NSSet *)keys;


+ (id)errorInvalidDataWithTypeMismatch:(NSString *)mismatchDescription;


+ (id)errorBadResponse;


+ (id)errorBadJSON;


+ (id)errorModelIsInvalid;


+ (id)errorInputIsNil;


- (instancetype)errorByPrependingKeyPathComponent:(NSString *)component;


@end
