//
//  SKAutoRequestSerializer.m
//  Pods
//
//  Created by ryan on 21/12/2016.
//
//

#import "SKAutoRequestSerializer.h"
#import "SKPBRequestSerializer.h"
#import "SKJSONRequestSerializer.h"
#import <Protobuf/GPBMessage.h>

@interface SKAutoRequestSerializer ()

@property (nonatomic, strong) SKJSONRequestSerializer *JSONRequestSerializer;
@property (nonatomic, strong) SKPBRequestSerializer *PBRequestSerializer;

@end

@implementation SKAutoRequestSerializer

+ (instancetype)serializer {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.JSONRequestSerializer = [SKJSONRequestSerializer serializer];
        self.PBRequestSerializer = [SKPBRequestSerializer serializer];
    }
    return self;
}


- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request
                               withParameters:(id)parameters
                                        error:(NSError *__autoreleasing *)error
{
    
    if ([parameters isKindOfClass:[GPBMessage class]]) {
        return [self.PBRequestSerializer requestBySerializingRequest:request withParameters:parameters error:error];
    } else {
        return [self.JSONRequestSerializer requestBySerializingRequest:request withParameters:parameters error:error];
    }
}

- (void)setValue:(NSString *)value forHTTPHeaderField:(NSString *)field {
    [self.JSONRequestSerializer setValue:value forHTTPHeaderField:field];
    [self.PBRequestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)clearAuthorizationHeader {
    [super clearAuthorizationHeader];
    [self.JSONRequestSerializer clearAuthorizationHeader];
    [self.PBRequestSerializer clearAuthorizationHeader];
}

@end
