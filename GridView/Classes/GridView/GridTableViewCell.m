//
//  GridTableViewCell.m
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

#import "GridTableViewCell.h"

NSNotificationName const GridTableViewCellDidScrollNotificationName = @"GridTableViewCellDidScrollNotificationName";

@interface GridTableViewCell () <UIScrollViewDelegate>

@property (nonatomic, strong, readwrite) UIView *fixedColumnContentView;
@property (nonatomic, strong, readwrite) UIScrollView *scrollableContentView;

@end

@implementation GridTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
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
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
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

@end