//
//  SKTimerManager.m
//  StockPB
//
//  Created by 张峥嵘 on 2018/1/25.
//

#import "SKTimerManager.h"
@import ReactiveCocoa;

@interface SKTimerManager()

@property (strong, nonatomic) GCDTimer *refreshTimer;

@end

@implementation SKTimerManager

+ (instancetype)sharedManager {
    static SKTimerManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _refreshSubject = [RACSubject subject];

        __weak typeof(self) weakSelf = self;
        [[self rac_valuesForKeyPath:@"timer" observer:self] subscribeNext:^(id x) {
            [weakSelf cancelTimer];
            if (weakSelf.timer != 0) {
                __weak typeof(self) weakWeakSelf = weakSelf;
                weakSelf.refreshTimer = [GCDTimer scheduledTimerWithTimeInterval:weakSelf.timer repeats:YES block:^{
                    if (weakWeakSelf.refreshAble) {
                        [weakWeakSelf.refreshSubject sendNext:nil];
                    }
                }];
            }
        }];
    }
    return self;
}

- (void)cancelTimer {
    if (self.refreshTimer) {
        [self.refreshTimer invalidate];
        self.refreshTimer = nil;
    }
}



@end
