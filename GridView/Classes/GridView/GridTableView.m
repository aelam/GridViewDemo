//
//  GridTableView.m
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

#import "GridTableView.h"
#import "GridColumnLayout.h"
#import "GridTableViewCell.h"

@interface GridTableView () <UITableViewDelegate, UITableViewDataSource> {
    BOOL _needsRecalculate;
}

@property (nonatomic, strong) GridCellLayout *cellLayout;

@end


@implementation GridTableView

- (void)setGridDelegate:(id<GridDataSource>)gridDelegate {
    _gridDelegate = gridDelegate;
    
    [self updateCellLayout];
}

- (void)setGridDataSource:(id<GridDataSource>)gridDataSource {
    _gridDataSource = gridDataSource;
    
    [self updateCellLayout];
}

- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
    super.dataSource = dataSource;
    
    _gridDataSource = dataSource;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    super.delegate = delegate;
    
    [self updateCellLayout];

}

- (void)reloadData {
    _needsRecalculate = YES;
    [self updateCellLayout];
    
    [super reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.fixedColumnCount = 1;
        
        self.delegate = self;
        self.dataSource = self;
        self.cellLayout = [GridCellLayout new];
        
    }
    return self;
}

- (UIView *)viewForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)column {
    return nil;
}
// DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gridDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<GridTableViewCell> *cell = (UITableViewCell<GridTableViewCell> *)[self.gridDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    [self updateCellLayout:cell forIndexPath:indexPath];
    
    return cell;
}

// Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self.gridDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.gridDelegate tableView:tableView heightForHeaderInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if ([self.gridDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.gridDelegate tableView:tableView heightForFooterInSection:section];
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.gridDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewCell<GridTableViewCell> *cell = (UITableViewCell<GridTableViewCell> *) [self.gridDelegate tableView:tableView viewForHeaderInSection:section];
    CGRect rect =  cell.frame;
    rect.size.width = tableView.bounds.size.width;
    cell.layer.borderWidth = 1;
    cell.layer.borderColor = [UIColor yellowColor].CGColor;
    cell.clipsToBounds = YES;
    
    [self updateHeaderLayout:cell forSection:section];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [self.gridDelegate tableView:tableView viewForHeaderInSection:section];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([self.gridDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [self.gridDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)updateCellLayout {
    if (!(self.delegate && self.dataSource)) {
        return;
    }
    
    NSInteger numberOfColumn = [self.gridDataSource numberOfColumnInTableView:self];
    NSInteger numberOfFixedColumn = [self.gridDataSource numberOfFixedColumnInTableView:self];

    CGFloat leftContentViewWidth = 0;
    CGFloat fullCellWidth = 0;

    NSMutableArray *columnWidths = [NSMutableArray arrayWithCapacity:numberOfColumn];

    for (NSInteger i = 0; i < numberOfColumn; i++) {
        CGFloat cellWidth = [_gridDelegate tableView:self widthForColumn:i];
        if (i < numberOfFixedColumn) {
            leftContentViewWidth += cellWidth;
        }
        
        [columnWidths addObject:@(cellWidth)];
        
        fullCellWidth += cellWidth;
    }
    
    self.cellLayout.fixedColumnCount = numberOfFixedColumn;
    self.cellLayout.columnCount = numberOfColumn;
    self.cellLayout.leftContentViewWidth = leftContentViewWidth;
    self.cellLayout.scrollViewContentWidth = fullCellWidth - leftContentViewWidth;
    
    self.cellLayout.columnWidths = columnWidths;
    self.cellLayout.cellWidth = fullCellWidth;
}

- (void)updateHeaderLayout:(UITableViewCell<GridTableViewCell> *)cell forSection:(NSInteger)section {
    if (self.cellLayout.isHeaderLaidOutMapping[cell] && [self.cellLayout.isHeaderLaidOutMapping[cell] boolValue]) {
        return;
    }
    
    CGFloat headerHeight = self.sectionHeaderHeight;
    if ([self.gridDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        headerHeight = [self.gridDelegate tableView:self heightForHeaderInSection:section];
    }
    
    [self updateCellContentFrame:cell rowHeight:headerHeight];
    [self updateCellContent:cell];
    
    
    self.cellLayout.isHeaderLaidOutMapping[cell] = @YES;
}

- (void)updateCellContentFrame:(UITableViewCell<GridTableViewCell> *)cell rowHeight:(CGFloat)rowHeight {
    cell.fixedColumnContentView.frame = CGRectMake(0, 0, self.cellLayout.leftContentViewWidth, rowHeight);
    
    CGFloat scrollWidth = self.bounds.size.width - self.cellLayout.leftContentViewWidth;
    
    cell.scrollableContentView.frame = CGRectMake(self.cellLayout.leftContentViewWidth, 0, scrollWidth, rowHeight);
    cell.scrollableContentView.contentSize = CGSizeMake(self.cellLayout.scrollViewContentWidth, rowHeight);

}

- (void)updateCellContent:(UITableViewCell<GridTableViewCell> *)cell {
    CGFloat contentOffsetX = 0;
    CGFloat contentOffsetX2 = 0;
    
    for (NSInteger i = 0; i < self.cellLayout.columnCount; i++) {
        UIView *view = [self.gridDataSource tableView:self viewForColumn:i];
        
        if (i < self.cellLayout.fixedColumnCount) {
            CGFloat width = [self.cellLayout.columnWidths[i] floatValue];
            view.frame = CGRectMake(contentOffsetX, 0, width , cell.bounds.size.height);
            contentOffsetX += width;
            [cell.fixedColumnContentView addSubview:view];
        } else {
            CGFloat width = [self.cellLayout.columnWidths[i] floatValue];
            view.frame = CGRectMake(contentOffsetX2, 0, width , cell.bounds.size.height);
            contentOffsetX2 += width;
            [cell.scrollableContentView addSubview:view];
        }
    }
}



- (void)updateCellLayout:(UITableViewCell<GridTableViewCell> *)cell forIndexPath:(NSIndexPath *)indexPath {
    if (self.cellLayout.isCellLaidOutMapping[cell] && [self.cellLayout.isCellLaidOutMapping[cell] boolValue]) {
        return;
    }
    
    CGFloat rowHeight = self.rowHeight;
    if ([self.gridDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        rowHeight = [self.gridDelegate tableView:self heightForRowAtIndexPath:indexPath];
    }
    
    if (self.cellLayout.cellHeightMapping[indexPath]) {
        rowHeight = [self.cellLayout.cellHeightMapping[indexPath] floatValue];
    }
    
    [self updateCellContentFrame:cell rowHeight:rowHeight];
    

    CGFloat contentOffsetX = 0;
    CGFloat contentOffsetX2 = 0;

    for (NSInteger i = 0; i < self.cellLayout.columnCount; i++) {
        UIView *view = [self.gridDataSource tableView:self viewForColumn:i];
        
        if (i < self.cellLayout.fixedColumnCount) {
            CGFloat width = [self.cellLayout.columnWidths[i] floatValue];
            view.frame = CGRectMake(contentOffsetX, 0, width , cell.bounds.size.height);
            contentOffsetX += width;
            [cell.fixedColumnContentView addSubview:view];
        } else {
            CGFloat width = [self.cellLayout.columnWidths[i] floatValue];
            view.frame = CGRectMake(contentOffsetX2, 0, width , cell.bounds.size.height);
            contentOffsetX2 += width;
            [cell.scrollableContentView addSubview:view];
        }
    }
    
    self.cellLayout.isCellLaidOutMapping[cell] = @YES;
    
}

@end
