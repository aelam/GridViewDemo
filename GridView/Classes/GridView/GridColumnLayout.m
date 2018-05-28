//
//  GridColumnLayout.m
//  GridView
//
//  Created by ryan on 2018/5/28.
//

#import "GridColumnLayout.h"
#import "GridTableViewCell.h"

@implementation GridCellLayout


- (void)updateCellLayout:(UITableViewCell<GridTableViewCell> *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isCellLaidOutMapping[cell] && [self.isCellLaidOutMapping[cell] boolValue]) {
        return;
    }
    
    CGFloat cellHeight = self.cellHeight;
    
    if (self.cellHeightMapping[indexPath]) {
        cellHeight = [self.cellHeightMapping[indexPath] floatValue];
    }
    cell.fixedColumnContentView.frame = CGRectMake(0, 0, self.leftContentViewWidth, cellHeight);
    cell.scrollableContentView.frame = CGRectMake(self.leftContentViewWidth, 0, self.scrollViewContentWidth, cellHeight);
    
    
    
}

@end
