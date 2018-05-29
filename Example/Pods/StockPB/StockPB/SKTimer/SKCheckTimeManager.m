//
//  SKCheckTimeManager.m
//  StockPB
//
//  Created by RenChao on 2018/3/30.
//

@import ReactiveCocoa;

#import "SKCheckTimeManager.h"
#import "TimeStatus_Request+Protocol.h"
#import "TimeStatusResponse.pbobjc.h"
#import "SKSessionManager+RAC.h"


@interface SKCheckTimeManager()

@property (assign, nonatomic) NSTimeInterval deltaTime;
@property (nonatomic, strong) RACCommand *requestTimeStatusCommand;

@end

@implementation SKCheckTimeManager

+ (instancetype)sharedManager {
    static SKCheckTimeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupData];
        [self setupCommand];
    }
    return self;
}
    
- (void)setupData {
    self.deltaTime = 0;
}

- (void)setupCommand
{
    @weakify(self);
    _requestTimeStatusCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSNumber *useCache) {
        @strongify(self)
        return  [[self requestTimeStatus] takeUntil:self.rac_willDeallocSignal];
    }];
}

- (NSTimeInterval)timeInterval {
    return [[NSDate date] timeIntervalSince1970] + self.deltaTime;
}

- (NSDate *)date {
    return [NSDate dateWithTimeIntervalSince1970:self.timeInterval];
}

- (RACSignal *)requestTimeStatus {
    TimeStatus_Request *parameters = [[TimeStatus_Request alloc] init];
    parameters.goodsId = 0;
    @weakify(self);
    return [[[[SKSessionManager sharedManager] requestSignalWithParameters: parameters] doNext:^(id responseData) {
        @strongify(self);
        if ([responseData isKindOfClass:[TimeStatus_Response class]]) {
            TimeStatus_Response *respone = (TimeStatus_Response *)responseData;
            NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
            self.deltaTime = respone.systemTimestamp/1000.0 - timeInterval;
            NSLog(@"校验时间：与服务器时间差%@s", @([SKCheckTimeManager sharedManager].deltaTime));
        }
    }] doError:^(NSError *error) {
        self.deltaTime = 0;
    }];
}
    
- (void)check {
    [self.requestTimeStatusCommand execute:nil];
}

@end
