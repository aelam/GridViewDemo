//
//  GridColumnLayout.m
//  GridView
//
//  Created by ryan on 2018/5/28.
//

#import "GridCellLayout.h"
#import "GridTableViewCell.h"

@implementation GridCellLayout


- (instancetype)init {
    if (self = [super init]) {
        self.preparedCells = [NSMutableSet set];
        self.preparedHeaders = [NSMutableSet set];
    }
    
    return self;
}

@end
