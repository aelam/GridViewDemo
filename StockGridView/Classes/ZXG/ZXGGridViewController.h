//
//  ZXGGridViewController.h
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

@import SKStockStone;
@import Protobuf;

@class GridTableView;

#import <UIKit/UIKit.h>

@interface ZXGGridViewController : UIViewController

@property (nonatomic, strong) GridTableView *gridTableView;
@property (nonatomic, strong) NSArray<NSNumber *> *watchList;
@property (nonatomic, strong) NSArray<NSNumber *> *displayFieldIds;

@end
