//
//  SKPBRequestSerializer.m
//  Pods
//
//  Created by ryan on 21/12/2016.
//
//

#import "SKPBRequestSerializer.h"
#import <Protobuf/GPBMessage.h>
#import "GPBMessage+Protocol.h"
#import "SKSessionManager.h"

@implementation SKPBRequestSerializer

+ (instancetype)serializer {
    return [[self alloc] init];
}

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    NSParameterAssert(request);
    GPBMessage *message = (GPBMessage *)parameters;
    
    if (message == nil || ![message isKindOfClass:[GPBMessage class]]) {
        return nil;
    }
    
    if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]]) {
        return [super requestBySerializingRequest:request withParameters:parameters error:error];
    }
    
    NSMutableURLRequest *mutableRequest = [request mutableCopy];
    
    [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
        if (![request valueForHTTPHeaderField:field]) {
            [mutableRequest setValue:value forHTTPHeaderField:field];
        }
    }];
    
    if (![mutableRequest valueForHTTPHeaderField:@"Content-Type"]) {
        [mutableRequest setValue:@"application/x-protobuf-v3" forHTTPHeaderField:@"Content-Type"];
    }

    if ([message respondsToSelector:@selector(protocolName)]) {
        NSString *protocolName = [message protocolName];
        if (protocolName) {
            NSString *tempURL = mutableRequest.URL.absoluteString;
            mutableRequest.URL = [[NSURL alloc]initWithString:[tempURL stringByAppendingString:protocolName]];
        }
    }

    if ([message respondsToSelector:@selector(protocolId)]) {
        NSInteger protocolId = [message protocolId];
        if (protocolId != -1) {
            if (![mutableRequest valueForHTTPHeaderField:@"X-Protocol-Id"]) {
                [mutableRequest setValue:@(protocolId).stringValue forHTTPHeaderField:@"X-Protocol-Id"];
            }
        }
    }
    
    if (![mutableRequest valueForHTTPHeaderField:@"Authorization"]) {
        [mutableRequest setValue:[SKSessionManager sharedManager].token forHTTPHeaderField:@"Authorization"];
    }
    
    [mutableRequest setHTTPBody:[message data]];
    
    return mutableRequest;
}

@end
