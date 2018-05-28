//
//  SKJSONRequestSerializer.m
//  Pods
//
//  Created by ryan on 22/12/2016.
//
//

#import "SKJSONRequestSerializer.h"
#import "SKSessionManager.h"

static NSString *SKJSONProtocolIdKey = @"protocolId";
//static NSString *SKXProtocolIdKey = @"X-Protocol-Id";

@implementation SKJSONRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(nullable id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSMutableDictionary *mutableParameters = [parameters mutableCopy];
    
    NSString *protocolId = mutableParameters[@"X-Protocol-Id"];
    if (protocolId && protocolId.length > 0) {
        [mutableParameters removeObjectForKey:@"X-Protocol-Id"];
    } else {
        protocolId = mutableParameters[SKJSONProtocolIdKey];
        if (protocolId && protocolId.length > 0) {
            [mutableParameters removeObjectForKey:SKJSONProtocolIdKey];
        }
    }

    NSMutableURLRequest *mutableRequest = (NSMutableURLRequest *)[super requestBySerializingRequest:request withParameters:mutableParameters error:error];

    NSString *moduleName = mutableParameters[@"ModuleName"];
    if (moduleName && moduleName.length > 0) {
        [mutableParameters removeObjectForKey:@"ModuleName"];
        NSString *tempURL = mutableRequest.URL.absoluteString;
        mutableRequest.URL = [[NSURL alloc]initWithString:[tempURL stringByAppendingString:moduleName]];
    }

    if (![mutableRequest valueForHTTPHeaderField:@"X-Protocol-Id"]) {
        [mutableRequest setValue:protocolId forHTTPHeaderField:@"X-Protocol-Id"];
    }
    
    return mutableRequest;
}

@end
