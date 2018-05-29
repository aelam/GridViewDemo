//
//  RankViewModel.m
//  StockGridView
//
//  Created by ryan on 2018/5/29.
//

@import StockPB;

#import "RankViewModel.h"

@interface RankViewModel ()

@property (nonatomic, strong, readwrite) NSArray<SKDynamicStockModel *>*stocks;
@property (nonatomic, strong) SortedList_Request *currentRequest;
@property (nonatomic, strong, readwrite) RACCommand *requestCommand;
@property (nonatomic, strong, readwrite) RACCommand *refreshCommand;

@end

@implementation RankViewModel


- (instancetype)init {
    if (self = [super init]) {
        [self initialize];
    }
    
    return self;
}

- (void)initialize {
    
    self.sortOption = [[SortedList_Request_SortOptions alloc] init];
    
    @weakify(self);
    self.requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self requestSignal];
    }];
    
    self.refreshCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        @strongify(self)
        return [self refreshSignal];
    }];

}

- (RACSignal *)requestSignal {
    SortedList_Request *request = [[SortedList_Request alloc] init];
    [request.fieldsIdArray addValuesFromNSArray:self.requestFields];
    [request.custom.goodsIdArray addValuesFromNSArray:self.goodsIdArray];
    request.sortOption = self.sortOption;
    request.beginPosition = 0;
    request.limitSize = (uint32_t)request.custom.goodsIdArray.count;
    
    return [[[SKSessionManager sharedManager] POSTSignalWithParameters:request] doNext:^(SortedList_Response *response) {
        [self handleResponse:response];
    }];
}

- (RACSignal *)refreshSignal {
    SortedList_Request *request = [[SortedList_Request alloc] init];
    [request.fieldsIdArray addValuesFromNSArray:self.requestFields];
    [request.custom.goodsIdArray addValuesFromNSArray:self.goodsIdArray];
    request.sortOption = self.sortOption;
    request.beginPosition = (uint32_t)self.refreshRange.location;
    request.limitSize = (uint32_t)self.refreshRange.length;
    
    return [[[SKSessionManager sharedManager] POSTSignalWithParameters:request] doNext:^(SortedList_Response *response) {
        [self handleRefreshResponse:response];
    }];
}

- (void)handleResponse:(SortedList_Response *)response {
    self.stocks = [response stocksWithStockClass:[SKDynamicStockModel class]];
}

- (void)handleRefreshResponse:(SortedList_Response *)response {
    NSArray *refreshStocks = [response stocksWithStockClass:[SKDynamicStockModel class]];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObjectsFromArray:self.stocks];
    [tempArray replaceObjectsInRange:self.refreshRange withObjectsFromArray:refreshStocks];
    self.stocks = tempArray;
}

- (void)updateSortField:(SKStockRequireField)field {
    if (self.sortOption.sortField == field) {
        self.sortOption.sortAsce = !self.sortOption.sortAsce;
    } else {
        self.sortOption.sortField = field;
        self.sortOption.sortAsce = YES;
    }
}


@end
