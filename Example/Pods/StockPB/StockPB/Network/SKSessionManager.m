//
//  SKSessionManager.m
//  Pods
//
//  Created by ryan on 21/12/2016.
//
//

#import "SKSessionManager.h"
#import "SKPBRequestSerializer.h"
#import "SKPBResponseSerializer.h"
#import "SKAutoRequestSerializer.h"
#import "SKServerProvider.h"
#import "SKRequestMiddleWare.h"

NSString const* SKXProtocolIdKey = @"X-Protocol-Id";
NSInteger const SKPBProtocolAutomatic = -1;

@interface SKSessionManager () {
    NSMutableSet<id<SKRequestMiddleWare>> *_requestMiddleWares;
}

@end

@implementation SKSessionManager

static SKSessionManager *sharedManager = nil;

+ (void)setSharedManager:(SKSessionManager *)manager {
    sharedManager = manager;
}


+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[SKSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[self defaultSessionConfiguration]];
    });

    return sharedManager;
}

+ (NSURLSessionConfiguration *)defaultSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;

    if (@available(iOS 11.0, *)) {
        configuration.waitsForConnectivity = YES;
    } else {
    }

    return configuration;
}

- (instancetype)initWithBaseURL:(NSURL *)url sessionConfiguration:(NSURLSessionConfiguration *)configuration {
    if (self = [super initWithBaseURL:url sessionConfiguration:configuration]) {
        self.requestSerializer = [SKAutoRequestSerializer serializer];
        self.responseSerializer = [AFCompoundResponseSerializer compoundSerializerWithResponseSerializers:
                                   @[[AFJSONResponseSerializer serializer],
                                     [SKPBResponseSerializer serializer]
                                    ]];
        
        _requestMiddleWares = [NSMutableSet set];
    }
    
    return self;
}

- (nullable NSURLSessionDataTask *)POSTParameters:(nullable id)parameters
                                         progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                          success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                          failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    return [self POST:[self.serverProvider baseURL] parameters:parameters progress:uploadProgress success:success failure:failure];
}

- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    __weak typeof(self)weakSelf = self;
    
    if ([URLString rangeOfString:@"http://"].location == NSNotFound
        && [URLString rangeOfString:@"https://"].location == NSNotFound) {
        URLString = [NSString stringWithFormat:@"%@%@", [self.serverProvider baseURL], URLString];
    }

    return [super POST:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
        [weakSelf handleSuccess:task responseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
        [weakSelf handleFail:task error:error];
    }];

}
    
- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString
                             parameters:(nullable id)parameters
                               progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {
    __weak typeof(self)weakSelf = self;
    if ([URLString rangeOfString:@"http://"].location == NSNotFound
        && [URLString rangeOfString:@"https://"].location == NSNotFound) {
        URLString = [[self.serverProvider baseURL] stringByAppendingPathComponent:URLString];
    }

    return [super GET:URLString parameters:parameters progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task, responseObject);
        [weakSelf handleSuccess:task responseObject:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(task, error);
        [weakSelf handleFail:task error:error];
    }];
    
}
    
    

- (void)addRequestMiddleWare:(id<SKRequestMiddleWare>)object {
    [_requestMiddleWares addObject:object];
}

- (void)removeRequestMiddleWare:(id<SKRequestMiddleWare>)object {
    [_requestMiddleWares removeObject:object];
}

- (void)addRequestMiddleWares:(NSSet *)objects {
    [_requestMiddleWares unionSet:objects];
}

- (void)removeRequestMiddleWares:(NSSet *)objects {
    [_requestMiddleWares minusSet:objects];
}

- (void)handleSuccess:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
    for (id<SKRequestMiddleWare> middleWare in self.requestMiddleWares) {
        if ([middleWare respondsToSelector:@selector(requestDidSuccess:responseObject:)]) {
            [middleWare requestDidSuccess:task responseObject:responseObject];
        }
    }
}

- (void)handleFail:(NSURLSessionDataTask *)task error:(NSError *)error {
    for (id<SKRequestMiddleWare> middleWare in self.requestMiddleWares) {
        if ([middleWare respondsToSelector:@selector(requestDidFail:error:)]) {
            [middleWare requestDidFail:task error:error];
        }
    }
}

@end
