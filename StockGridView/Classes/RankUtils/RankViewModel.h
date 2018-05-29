//
//  RankViewModel.h
//  StockGridView
//
//  Created by ryan on 2018/5/29.
//

@import Foundation;
@import ReactiveCocoa;
@import SKDynamicStock;
@import Protobuf;

@interface RankViewModel : NSObject

@property (nonatomic, strong) NSArray<NSNumber *> *requestFields;
@property (nonatomic, strong) NSArray<NSNumber *> *goodsIdArray;
@property (nonatomic, strong) SortedList_Request_SortOptions *sortOption;
@property (nonatomic, assign) NSRange refreshRange;

@property (nonatomic, strong) NSArray<NSNumber *>*displayFields;

@property (nonatomic, strong, readonly) RACCommand *requestCommand;
@property (nonatomic, strong, readonly) RACCommand *refreshCommand;

@property (nonatomic, assign, readonly) BOOL isLoading;
@property (nonatomic, assign, readonly) BOOL isLoadingMore;
@property (nonatomic, strong, readonly) SortedList_Request *request;
@property (nonatomic, assign, readonly) BOOL hasNoMoreData;

@property (nonatomic, strong, readonly) NSArray<SKDynamicStockModel *>*stocks;

- (void)updateSortField:(SKStockRequireField)field;

@end
