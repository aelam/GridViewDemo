//
//  SKSessionManager+WebAPI.m
//  Pods
//
//  Created by ryan on 03/05/2017.
//
//

#import "SKSessionManager+WebAPI.h"

@implementation SKSessionManager (WebAPI)

static SKSessionManager *sharedWebAPIManager = nil;

+ (void)setSharedWebAPIManager:(SKSessionManager *)manager {
    sharedWebAPIManager = manager;
}

+ (instancetype)sharedWebAPIManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedWebAPIManager = [[SKSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[self webAPISessionConfiguration]];
    });
    
    return sharedWebAPIManager;
}

+ (NSURLSessionConfiguration *)webAPISessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 15;
    if (@available(iOS 11.0, *)) {
//        configuration.waitsForConnectivity = YES;
    } else {
    }

    return configuration;
}

@end

@implementation SKSessionManager (SecureWebAPI)

static SKSessionManager *sharedSecureWebAPIManager = nil;

+ (void)setSharedSecureWebAPIManager:(SKSessionManager *)manager {
    sharedSecureWebAPIManager = manager;
}

+ (instancetype)sharedSecureWebAPIManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSecureWebAPIManager = [[SKSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[self webAPISessionConfiguration]];
    });
    
    return sharedSecureWebAPIManager;
}


@end
