//
//  SKSessionManager+WebAPI.m
//  Pods
//
//  Created by ryan on 03/05/2017.
//
//

#import "SKSessionManager+YMStockWebAPI.h"

@implementation SKTServerManager: SKServerManager

- (instancetype)init {
    if (self = [super init]) {
        self.hosts = @[@"http://t.emoney.cn"];
    }
    return self;
}

@end

@implementation SKMServerManager: SKServerManager

- (instancetype)init {
    if (self = [super init]) {
        self.hosts = @[@"http://m.emoney.cn"];
    }
    return self;
}

@end

@implementation SKMTServerManager

- (instancetype)init {
    if (self = [super init]) {
        self.hosts = @[@"http://mt.emoney.cn"];
    }
    return self;
}

@end


@implementation SKSessionManager (M)

static SKSessionManager *sharedMManager = nil;

+ (void)setSharedMManager:(SKSessionManager *)manager {
    sharedMManager = manager;
}

+ (instancetype)sharedMManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMManager = [[SKSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[self webAPISessionConfiguration]];
        sharedMManager.serverProvider = [SKMServerManager new];
    });
    
    return sharedMManager;
}

+ (NSURLSessionConfiguration *)webAPISessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;
    if (@available(iOS 11.0, *)) {
        configuration.waitsForConnectivity = YES;
    } else {
    }
    
    return configuration;
}

@end


@implementation SKSessionManager (T)

static SKSessionManager *sharedTManager = nil;

+ (void)setsharedTManager:(SKSessionManager *)manager {
    sharedTManager = manager;
}

+ (instancetype)sharedTManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedTManager = [[SKSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[self webAPISessionConfiguration]];
        sharedTManager.serverProvider = [SKTServerManager new];
    });
    
    return sharedTManager;
}

+ (NSURLSessionConfiguration *)webAPISessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;
    if (@available(iOS 11.0, *)) {
        configuration.waitsForConnectivity = YES;
    } else {
    }
    
    return configuration;
}

@end


@implementation SKSessionManager (MT)

static SKSessionManager *sharedMTManager = nil;

+ (void)setSharedMTManager:(SKSessionManager *)manager {
    sharedMTManager = manager;
}

+ (instancetype)sharedMTManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMTManager = [[SKSessionManager alloc] initWithBaseURL:nil sessionConfiguration:[self webAPISessionConfiguration]];
        sharedMTManager.serverProvider = [SKMTServerManager new];
    });
    
    return sharedMTManager;
}

+ (NSURLSessionConfiguration *)webAPISessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;
    if (@available(iOS 11.0, *)) {
        configuration.waitsForConnectivity = YES;
    } else {
    }
    
    return configuration;
}

@end
