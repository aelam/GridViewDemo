//
//  GridTableViewCell.h
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

#import <UIKit/UIKit.h>

extern NSNotificationName const GridTableViewCellDidScrollNotificationName;

@protocol GridColumnScrollable<NSObject>

@property (nonatomic, assign) CGFloat contentOffsetX;

- (void)setContentOffsetX:(CGFloat)contentOffsetX animated:(BOOL)animated;

@end

@protocol GridTableViewCell<GridColumnScrollable>

@property (nonatomic, strong, readonly) UIView *fixedColumnContentView;
@property (nonatomic, strong, readonly) UIScrollView *scrollableContentView;
@property (nonatomic, assign) CGFloat contentOffsetX;


@end

@interface GridTableViewCell : UITableViewCell<GridTableViewCell>

@property (nonatomic, strong, readonly) UIView *fixedColumnContentView;
@property (nonatomic, strong, readonly) UIScrollView *scrollableContentView;
@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign, readwrite) CGFloat fixedColumnContentViewWidth;

@end



@interface GridTableViewHeader : UITableViewHeaderFooterView<GridTableViewCell>

@property (nonatomic, strong, readonly) UIView *fixedColumnContentView;
@property (nonatomic, strong, readonly) UIScrollView *scrollableContentView;
@property (nonatomic, assign) CGFloat contentOffsetX;
@property (nonatomic, assign, readwrite) CGFloat fixedColumnContentViewWidth;

@end

