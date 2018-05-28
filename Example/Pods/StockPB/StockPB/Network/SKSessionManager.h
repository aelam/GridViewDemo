//
//  SKSessionManager.h
//  Pods
//
//  Created by ryan on 21/12/2016.
//
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>


@protocol SKServerProvider;
@protocol SKRequestMiddleWare;

NS_ASSUME_NONNULL_BEGIN

extern NSString const* SKXProtocolIdKey;

@interface SKSessionManager : AFHTTPSessionManager

+ (void)setSharedManager:(nonnull SKSessionManager *)manager;
+ (instancetype)sharedManager;

@property (nonatomic, strong) id<SKServerProvider> serverProvider;
@property (nonatomic, strong, readonly) NSSet<id<SKRequestMiddleWare>> *requestMiddleWares;
//@property (nonatomic, strong) NSString *token;

- (void)addRequestMiddleWare:(id<SKRequestMiddleWare>)object;
- (void)removeRequestMiddleWare:(id<SKRequestMiddleWare>)object;

- (void)addRequestMiddleWares:(NSSet *)objects;
- (void)removeRequestMiddleWares:(NSSet *)objects;


- (nullable NSURLSessionDataTask *)POSTParameters:(nullable id)parameters
                                         progress:(nullable void (^)(NSProgress *uploadProgress))uploadProgress
                                          success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
                                          failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure;


@end

NS_ASSUME_NONNULL_END
