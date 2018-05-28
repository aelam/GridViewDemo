//
//  GridTableViewCell.h
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

#import <UIKit/UIKit.h>

extern NSNotificationName const GridTableViewCellDidScrollNotificationName;


@protocol GridTableViewCell<NSObject>

@property (nonatomic, strong, readonly) UIView *fixedColumnContentView;
@property (nonatomic, strong, readonly) UIScrollView *scrollableContentView;
@property (nonatomic, assign) CGFloat contentOffsetX;

@end

@interface GridTableViewCell : UITableViewCell<GridTableViewCell>

@property (nonatomic, strong, readonly) UIView *fixedColumnContentView;
@property (nonatomic, strong, readonly) UIScrollView *scrollableContentView;
@property (nonatomic, assign) CGFloat contentOffsetX;

@end
