




#import "JSONModelError.h"

NSString* const JSONModelErrorDomain = @"JSONModelErrorDomain";
NSString* const kJSONModelMissingKeys = @"kJSONModelMissingKeys";
NSString* const kJSONModelTypeMismatch = @"kJSONModelTypeMismatch";
NSString* const kJSONModelKeyPath = @"kJSONModelKeyPath";

@implementation JSONModelError

+(id)errorInvalidDataWithMessage:(NSString*)message
{
    message = [NSString stringWithFormat:@"Invalid JSON data: %@", message];
    return [JSONModelError errorWithDomain:JSONModelErrorDomain
                                      code:kJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:message}];
}

+(id)errorInvalidDataWithMissingKeys:(NSSet *)keys
{
    return [JSONModelError errorWithDomain:JSONModelErrorDomain
                                      code:kJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:@"Invalid JSON data. Required JSON keys are missing from the input. Check the error user information.",kJSONModelMissingKeys:[keys allObjects]}];
}

+(id)errorInvalidDataWithTypeMismatch:(NSString*)mismatchDescription
{
    return [JSONModelError errorWithDomain:JSONModelErrorDomain
                                      code:kJSONModelErrorInvalidData
                                  userInfo:@{NSLocalizedDescriptionKey:@"Invalid JSON data. The JSON type mismatches the expected type. Check the error user information.",kJSONModelTypeMismatch:mismatchDescription}];
}

+(id)errorBadResponse
{
    return [JSONModelError errorWithDomain:JSONModelErrorDomain
                                      code:kJSONModelErrorBadResponse
                                  userInfo:@{NSLocalizedDescriptionKey:@"Bad network response. Probably the JSON URL is unreachable."}];
}

+(id)errorBadJSON
{
    return [JSONModelError errorWithDomain:JSONModelErrorDomain
                                      code:kJSONModelErrorBadJSON
                                  userInfo:@{NSLocalizedDescriptionKey:@"Malformed JSON. Check the JSONModel data input."}];
}

+(id)errorModelIsInvalid
{
    return [JSONModelError errorWithDomain:JSONModelErrorDomain
                                      code:kJSONModelErrorModelIsInvalid
                                  userInfo:@{NSLocalizedDescriptionKey:@"Model does not validate. The custom validation for the input data failed."}];
}

+(id)errorInputIsNil
{
    return [JSONModelError errorWithDomain:JSONModelErrorDomain
                                      code:kJSONModelErrorNilInput
                                  userInfo:@{NSLocalizedDescriptionKey:@"Initializing model with nil input object."}];
}

- (instancetype)errorByPrependingKeyPathComponent:(NSString*)component
{
    
    NSMutableDictionary* userInfo = [self.userInfo mutableCopy];

    
    NSString* existingPath = userInfo[kJSONModelKeyPath];
    NSString* separator = [existingPath hasPrefix:@"["] ? @"" : @".";
    NSString* updatedPath = (existingPath == nil) ? component : [component stringByAppendingFormat:@"%@%@", separator, existingPath];
    userInfo[kJSONModelKeyPath] = updatedPath;

    
    return [JSONModelError errorWithDomain:self.domain
                                      code:self.code
                                  userInfo:[NSDictionary dictionaryWithDictionary:userInfo]];
}

@end
