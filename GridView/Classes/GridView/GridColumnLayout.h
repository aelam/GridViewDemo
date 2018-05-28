//
//  GridColumnLayout.h
//  GridView
//
//  Created by ryan on 2018/5/28.
//

#import <Foundation/Foundation.h>

@protocol GridTableViewCell;

@interface GridCellLayout : NSObject

@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, strong) NSMutableDictionary<NSIndexPath*, NSNumber *> *cellHeightMapping;
@property (nonatomic, strong) NSMutableDictionary<UITableViewCell*, NSNumber *> *isCellLaidOutMapping;
@property (nonatomic, strong) NSArray<NSNumber *> *columnWidths;
@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, assign) NSInteger fixedColumnCount;
@property (nonatomic, assign) CGFloat leftContentViewWidth;
@property (nonatomic, assign) CGFloat scrollViewContentWidth;

@property (nonatomic, strong) NSMutableDictionary<NSNumber *, NSNumber *> *headerHeightMapping;
@property (nonatomic, strong) NSMutableDictionary<UITableViewCell*, NSNumber *> *isHeaderLaidOutMapping;


@property (nonatomic, assign) CGFloat contentOffsetX;


- (void)updateCellLayout:(UITableViewCell<GridTableViewCell> *)cell forIndexPath:(NSIndexPath *)indexPath;

@end
