//
//  SKPBResponseSerializer.m
//  Pods
//
//  Created by ryan on 21/12/2016.
//
//

#import "SKPBResponseSerializer.h"
#import <StockPB/BaseResponse.pbobjc.h>

NSString * const SKURLResponseSerializationErrorDomain = @"cn.emoney.error.serialization.response";
NSString * const SKNetworkingOperationFailingURLResponseErrorKey = @"cn.emoney.serialization.response.error.response";
NSString * const SKNetworkingOperationFailingURLResponseDataErrorKey = @"cn.emoney.serialization.response.error.data";


static NSError * SKErrorWithUnderlyingError(NSError *error, NSError *underlyingError) {
    if (!error) {
        return underlyingError;
    }
    
    if (!underlyingError || error.userInfo[NSUnderlyingErrorKey]) {
        return error;
    }
    
    NSMutableDictionary *mutableUserInfo = [error.userInfo mutableCopy];
    mutableUserInfo[NSUnderlyingErrorKey] = underlyingError;
    
    return [[NSError alloc] initWithDomain:error.domain code:error.code userInfo:mutableUserInfo];
}


@implementation SKPBResponseSerializer

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.acceptableContentTypes = [NSSet setWithObjects:@"application/x-protobuf-v3", nil];
    
    return self;
}

- (id)responseObjectForResponse:(NSURLResponse *)response
                           data:(NSData *)data
                          error:(NSError *__autoreleasing *)error
{
    if (![self validateResponse:(NSHTTPURLResponse *)response data:data error:error]) {
        if (!error) {
            return nil;
        }
    }
    
    id responseObject = nil;
    NSError *serializationError = nil;
    
    if (data.length > 0) {
        responseObject = [Base_Response parseFromData:data error:&serializationError];
        Base_Response *baseResponse = responseObject;
        if (serializationError == nil && baseResponse.hasResult && baseResponse.result.code == 0) {
            if (baseResponse.hasDetail) {
                NSString *class = [baseResponse.detail.typeURL lastPathComponent];
                responseObject = [NSClassFromString(class) parseFromData:baseResponse.detail.value error:&serializationError];
                if (serializationError) {
                    NSMutableDictionary *mutableUserInfo = [@{
                                                              NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Parse failed: %@", class],
                                                              NSURLErrorFailingURLErrorKey:[response URL],
                                                              SKNetworkingOperationFailingURLResponseErrorKey: response,
                                                              } mutableCopy];
                    *error = [NSError errorWithDomain:SKURLResponseSerializationErrorDomain code:-1 userInfo:mutableUserInfo];
                }
            } else {
                
            }
        } else if (baseResponse.hasResult && error) {
            NSMutableDictionary *mutableUserInfo = [@{
                                                      NSLocalizedDescriptionKey: [NSString stringWithFormat:@"Request failed: %@", baseResponse.result.msg],
                                                      NSURLErrorFailingURLErrorKey:[response URL],
                                                      SKNetworkingOperationFailingURLResponseErrorKey: response,
                                                      } mutableCopy];
            *error = [NSError errorWithDomain:SKURLResponseSerializationErrorDomain code:baseResponse.result.code userInfo:mutableUserInfo];
        }
    } else {
        
    }
    
    if (error) {
        *error = SKErrorWithUnderlyingError(serializationError, *error);
    }

    return responseObject;
}


@end
