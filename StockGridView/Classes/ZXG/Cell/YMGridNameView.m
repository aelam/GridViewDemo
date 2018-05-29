//
//  YMGridNameView.m
//  StockGridView
//
//  Created by ryan on 2018/5/29.
//

@import Masonry;
@import UIColor_HexString;

#import "YMGridNameView.h"

@implementation YMGridNameView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor whiteColor];
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        
        self.codeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.codeLabel.textColor = [UIColor whiteColor];
        
        self.nameLabel.font = [UIFont systemFontOfSize:16];
        self.rongImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        UIImage *rongIcon = [UIImage imageNamed:@"rongIcon" inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
        self.rongImageView.image = rongIcon;
        
        [self addSubview:self.nameLabel];
        [self addSubview:self.codeLabel];
        [self addSubview:self.rongImageView];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.top.left.right.mas_equalTo(1);
            maker.height.mas_equalTo(20);
        }];
        
        [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.bottom.left.mas_equalTo(0);
            maker.height.mas_equalTo(20);
        }];

        [self.rongImageView mas_makeConstraints:^(MASConstraintMaker *maker) {
            maker.top.mas_equalTo(self.codeLabel.mas_top);
            maker.left.mas_equalTo(self.codeLabel.mas_right).offset(3);
            maker.height.mas_equalTo(20);
        }];
        

        self.codeLabel.textColor = [UIColor colorWithHexString:@"00ffff"];
        
        
    }
    return self;
}


@end
