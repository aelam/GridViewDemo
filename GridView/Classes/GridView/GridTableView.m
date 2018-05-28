//
//  GridTableView.m
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

#import "GridTableView.h"
#import "GridCellLayout.h"
#import "GridTableViewCell.h"
#import "GridAdapterProxy.h"

@interface GridTableView () <UITableViewDelegate, UITableViewDataSource> {
    BOOL _needsRecalculate;
    NSInteger _numberOfSection;
    CGFloat _sectionHeaderHeight;
    CGFloat _sectionFooterHeight;

}

@property (nonatomic, strong) GridCellLayout *cellLayout;
@property (nonatomic,   weak) GridAdapterProxy *delegateProxy;

@end


@implementation GridTableView

- (void)setGridDelegate:(id<GridDelegate>)gridDelegate {
    _gridDelegate = gridDelegate;
    
    [self prepareLayoutData];
}

- (void)setGridDataSource:(id<GridDataSource>)gridDataSource {
    _gridDataSource = gridDataSource;
    
    [self prepareLayoutData];
}

//- (void)setDataSource:(id<UITableViewDataSource>)dataSource {
//    super.dataSource = dataSource;
//
//    if (_gridDataSource != dataSource) {
//        _gridDataSource = dataSource;
//    }
//}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    super.delegate = delegate;
    [self prepareLayoutData];
}

- (void)setNumberOfFixedColumns:(NSInteger)fixedColumnCount {
    if (_numberOfFixedColumns == fixedColumnCount) {
        return;
    }
    _numberOfFixedColumns = fixedColumnCount;
    
    [self reloadData];
}

- (void)reloadData {
    _needsRecalculate = YES;
    [self prepareLayoutData];
    [super reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.numberOfFixedColumns = 1;
        
        self.delegate = self;
        self.dataSource = self;
        self.cellLayout = [GridCellLayout new];
        
    }
    return self;
}

// DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.gridDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.gridDataSource numberOfSectionsInTableView:tableView];
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.gridDataSource tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell<GridTableViewCell> *cell = (UITableViewCell<GridTableViewCell> *)[self.gridDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    [self prepareCellLayout:cell forIndexPath:indexPath];
    
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
    
    [self prepareHeaderLayout:cell forSection:section];
    [self addGestureOnHeader:cell];
    
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

- (void)prepareLayoutData {
    if (!(self.delegate && self.dataSource)) {
        return;
    }
    
    NSInteger numberOfColumn = self.numberOfColumns;
    NSInteger numberOfFixedColumn = self.numberOfFixedColumns;

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
    
//    self.cellLayout.fixedColumnCount = numberOfFixedColumn;
//    self.cellLayout.columnCount = numberOfColumn;
    self.cellLayout.leftContentViewWidth = leftContentViewWidth;
    self.cellLayout.scrollViewContentWidth = fullCellWidth - leftContentViewWidth;
    
    self.cellLayout.columnWidths = columnWidths;
    self.cellLayout.cellWidth = fullCellWidth;
}

- (void)prepareHeaderLayout:(UITableViewCell<GridTableViewCell> *)cell forSection:(NSInteger)section {

    if([self.cellLayout.preparedHeaders containsObject:cell]) {
        return;
    }

    CGFloat headerHeight = self.sectionHeaderHeight;
    if ([self.gridDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        headerHeight = [self.gridDelegate tableView:self heightForHeaderInSection:section];
    }
    
    [self updateCellContentFrame:cell rowHeight:headerHeight];
    [self prepareColumnsInCell:cell];
    
    [self.cellLayout.preparedHeaders addObject:cell];
}

- (void)updateCellContentFrame:(UITableViewCell<GridTableViewCell> *)cell rowHeight:(CGFloat)rowHeight {
    cell.fixedColumnContentView.frame = CGRectMake(0, 0, self.cellLayout.leftContentViewWidth, rowHeight);
    
    CGFloat scrollWidth = self.bounds.size.width - self.cellLayout.leftContentViewWidth;
    
    cell.scrollableContentView.frame = CGRectMake(self.cellLayout.leftContentViewWidth, 0, scrollWidth, rowHeight);
    cell.scrollableContentView.contentSize = CGSizeMake(self.cellLayout.scrollViewContentWidth, rowHeight);

}

- (void)prepareColumnsInCell:(UITableViewCell<GridTableViewCell> *)cell {
    CGFloat contentOffsetX = 0;
    CGFloat contentOffsetX2 = 0;
    
    for (NSInteger i = 0; i < self.numberOfColumns; i++) {
        UIView *view = [self.gridDataSource tableView:self viewForColumn:i];
        
        if (i < self.numberOfFixedColumns) {
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



- (void)prepareCellLayout:(UITableViewCell<GridTableViewCell> *)cell forIndexPath:(NSIndexPath *)indexPath {
    
    if([self.cellLayout.preparedCells containsObject:cell]) {
        return;
    }
    
    CGFloat rowHeight = self.rowHeight;
    if ([self.gridDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        rowHeight = [self.gridDelegate tableView:self heightForRowAtIndexPath:indexPath];
    }
    
    [self updateCellContentFrame:cell rowHeight:rowHeight];
    

    CGFloat contentOffsetX = 0;
    CGFloat contentOffsetX2 = 0;

    for (NSInteger i = 0; i < self.numberOfColumns; i++) {
        UIView *view = [self.gridDataSource tableView:self viewForColumn:i];
        
        if (i < self.numberOfFixedColumns) {
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
    
    [self.cellLayout.preparedCells addObject:cell];
}

- (void)createProxyAndUpdateCollectionViewDelegate {
    // there is a known bug with accessibility and using an NSProxy as the delegate that will cause EXC_BAD_ACCESS
    // when voiceover is enabled. it will hold an unsafe ref to the delegate
    self.delegate = nil;
    
//    self.delegateProxy = [[GridAdapterProxy alloc] initWithCollectionViewTarget:_collectionViewDelegate
//                                                                 scrollViewTarget:_scrollViewDelegate
//                                                                      interceptor:self];
    [self updateCollectionViewDelegate];
}

- (void)updateCollectionViewDelegate {
    // set up the delegate to the proxy so the adapter can intercept events
    // default to the adapter simply being the delegate
    self.delegate = (id<UITableViewDelegate>)self.delegateProxy ?: self;
}

//// reset and configure the delegate proxy whenever this property is set
//- (void)setDelegate:(id<UITableViewDelegate>)delegate {
//
//    if (super.delegate != delegate) {
//        _collectionViewDelegate = collectionViewDelegate;
//        [self createProxyAndUpdateCollectionViewDelegate];
//    }
//}
//
//- (void)setScrollViewDelegate:(id<UIScrollViewDelegate>)scrollViewDelegate {
//
//    if (_scrollViewDelegate != scrollViewDelegate) {
//        _scrollViewDelegate = scrollViewDelegate;
//        [self createProxyAndUpdateCollectionViewDelegate];
//    }
//}


- (void)addGestureOnHeader:(UITableViewCell *)cell {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    [cell addGestureRecognizer:tapGestureRecognizer];
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)recognizer {
    
    CGPoint location = [recognizer locationInView:self];
    NSInteger numberOfSections = self.numberOfSections;

    if ([self.gridDataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        numberOfSections = [self.gridDataSource numberOfSectionsInTableView:self];
    }
    
    NSInteger selectedSection = -1;
    for (NSInteger section = 0; section < numberOfSections; section++) {
        
        CGRect headerFrame = [self rectForHeaderInSection:section];
        if (CGRectContainsPoint(headerFrame, location)) {
            if ([recognizer.view conformsToProtocol:@protocol(GridTableViewCell)]) {
                selectedSection = section;
            }
            break;
        }
    }
    
    if (selectedSection == -1) {
        return;
    }
    
    
    [self selectSection:selectedSection location: [recognizer locationInView:recognizer.view] header:recognizer.view];
}

- (void)selectSection:(NSInteger)section location:(CGPoint)location header:(UIView<GridTableViewCell >*)header {

    BOOL touchedInside = NO;
    NSInteger index = 0;
    if (CGRectContainsPoint(header.fixedColumnContentView.frame, location)) {

        CGPoint location2 = [header convertPoint:location toView:header.fixedColumnContentView];
        for (UIView *view in header.fixedColumnContentView.subviews) {
            if (CGRectContainsPoint(view.frame, location2)) {
                touchedInside = YES;
                break;
            } else {
                index += 1;
            }
        }
    } else if (CGRectContainsPoint(header.scrollableContentView.frame, location)) {
        index = self.numberOfFixedColumns;
        CGPoint location2 = [header convertPoint:location toView:header.scrollableContentView];
        for (UIView *view in header.scrollableContentView.subviews) {
            if (CGRectContainsPoint(view.frame, location2)) {
                touchedInside = YES;
                break;
            } else {
                index += 1;
            }
        }
    }
    
    if (touchedInside) {
        NSLog(@"section: %zd, index= %zd", section ,index);
        
        if ([self.gridDelegate respondsToSelector:@selector(tableView:didSelectHeaderAtSection:column:)]) {
            [self.gridDelegate tableView:self didSelectHeaderAtSection:section column:index];
        }
    }

}



@end
