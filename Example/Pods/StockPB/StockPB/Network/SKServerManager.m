//
//  SKServerManager.m
//  Pods
//
//  Created by ryan on 22/12/2016.
//
//

#import "SKServerManager.h"
#import "SKRequestMiddleWare.h"
#import "SKServerProvider.h"

@interface SKServerManager ()

@property (nonatomic, assign) NSInteger currentHostIndex;
@property (nonatomic, assign) NSInteger failureCount;

@end

@implementation SKServerManager

+ (instancetype)sharedManager {
    static SKServerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        self.hosts = @[@"http://192.168.8.82:2015"];
        self.failureThreshold = 5;
    }
    return self;
}

- (void)setHosts:(NSArray<NSString *> *)hosts {
    if (_hosts != hosts) {
        _hosts = hosts;
        [self _reset];
    }
}

- (void)setSecureHosts:(NSArray<NSString *> *)secureHosts {
    if (_secureHosts != secureHosts) {
        _secureHosts = secureHosts;
        [self _reset];
    }
}

- (NSString *)baseURL {
    if ([self.hosts count] == 0) {
        return nil;
    }
    
    return self.hosts[_currentHostIndex];
}

- (NSString *)secureURL {
    if ([self.secureHosts count] == 0) {
        return nil;
    }
    
    return self.secureHosts[_currentHostIndex];
}

// TODO: 统计成功或失败次数 再决定切换服务器
- (void)requestDidSuccess:(NSURLSessionDataTask *)task responseObject:(id)responseObject {
    
}

- (void)requestDidFail:(NSURLSessionDataTask *)task error:(NSError *)error {
    _failureCount++;
    
    if (_failureCount >= self.failureThreshold) {
        [self loadBalance];
    }
}


- (void)loadBalance {
    NSInteger randomIndex = self.currentHostIndex;
    do {
        randomIndex = (NSInteger)arc4random_uniform((uint32_t)self.hosts.count);
    } while(self.currentHostIndex == randomIndex);
    
    self.currentHostIndex = randomIndex;
    self.failureCount = 0;
}

- (void)_reset {
    _currentHostIndex = 0;
    _failureCount = 0;
}



@end
