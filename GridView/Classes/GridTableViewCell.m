//
//  GridTableViewCell.m
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

@import Masonry;
#import "GridTableViewCell.h"

NSNotificationName const GridTableViewCellDidScrollNotificationName = @"GridTableViewCellDidScrollNotificationName";

@interface GridTableViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIView *fixedColumnContentView;
@property (nonatomic, strong, readwrite) UIScrollView *scrollableContentView;

@end

@implementation GridTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize {
    self.fixedColumnContentView = [UIView new];
    self.scrollableContentView = [[UIScrollView alloc] init];
    self.scrollableContentView.showsVerticalScrollIndicator = NO;
    self.scrollableContentView.showsHorizontalScrollIndicator = NO;
    
    self.scrollableContentView.delegate = self;
    
    [self.contentView addSubview:self.fixedColumnContentView];
    [self.contentView addSubview:self.scrollableContentView];
    
    self.scrollableContentView.userInteractionEnabled = NO;
    [self.contentView addGestureRecognizer:self.scrollableContentView.panGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(otherCellDidScroll:) name:GridTableViewCellDidScrollNotificationName object:nil];

}

- (void)setFixedColumnContentViewWidth:(CGFloat)fixedColumnContentViewWidth {
    if (_fixedColumnContentViewWidth == fixedColumnContentViewWidth) {
        return;
    }
    _fixedColumnContentViewWidth = fixedColumnContentViewWidth;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)otherCellDidScroll:(NSNotification *)notification {
    GridTableViewCell *otherCell = notification.object;
    
    if (otherCell == self) {
        return;
    }
    
    if (otherCell.superview != self.superview) {
        // 如果不是同一个TableView不联动
        return;
    }
    
    self.scrollableContentView.contentOffset = otherCell.scrollableContentView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:GridTableViewCellDidScrollNotificationName object:self];
}

- (CGFloat)contentOffsetX {
    return self.scrollableContentView.contentOffset.x;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX {
    CGPoint contentOffset = self.scrollableContentView.contentOffset;
    contentOffset.x = contentOffsetX;
    self.scrollableContentView.contentOffset = contentOffset;
}

- (void)setContentOffsetX:(CGFloat)contentOffsetX animated:(BOOL)animation {
    
    CGPoint contentOffset = self.scrollableContentView.contentOffset;
    contentOffset.x = contentOffsetX;
    [self.scrollableContentView setContentOffset:contentOffset animated:animation];

}

@end


@interface GridTableViewHeader () <UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIView *fixedColumnContentView;
@property (nonatomic, strong, readwrite) UIScrollView *scrollableContentView;

@end

@implementation GridTableViewHeader


- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initialize];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initialize];
}

- (void)initialize {
    self.fixedColumnContentView = [UIView new];
    self.scrollableContentView = [[UIScrollView alloc] init];
    self.scrollableContentView.showsVerticalScrollIndicator = NO;
    self.scrollableContentView.showsHorizontalScrollIndicator = NO;
    
    self.scrollableContentView.delegate = self;
    
    [self.contentView addSubview:self.fixedColumnContentView];
    [self.contentView addSubview:self.scrollableContentView];
    
    self.scrollableContentView.userInteractionEnabled = NO;
//    [self.contentView addGestureRecognizer:self.scrollableContentView.panGestureRecognizer];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(otherCellDidScroll:) name:GridTableViewCellDidScrollNotificationName object:nil];
    
}

- (void)setFixedColumnContentViewWidth:(CGFloat)fixedColumnContentViewWidth {
    if (_fixedColumnContentViewWidth == fixedColumnContentViewWidth) {
        return;
    }
    _fixedColumnContentViewWidth = fixedColumnContentViewWidth;
}

- (void)otherCellDidScroll:(NSNotification *)notification {
    UIView<GridTableViewCell> *otherCell = notification.object;
    
    if (otherCell == self) {
        return;
    }
    
    if (otherCell.superview != self.superview) {
        // 如果不是同一个TableView不联动
        return;
    }
    
    self.scrollableContentView.contentOffset = otherCell.scrollableContentView.contentOffset;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [[NSNotificationCenter defaultCenter] postNotificationName:GridTableViewCellDidScrollNotificationName object:self];
}

- (CGFloat)contentOffsetX {
    return self.scrollableContentView.contentOffset.x;
}


- (void)setContentOffsetX:(CGFloat)contentOffsetX {
    CGPoint contentOffset = self.scrollableContentView.contentOffset;
    contentOffset.x = contentOffsetX;
    self.scrollableContentView.contentOffset = contentOffset;
}

@end
