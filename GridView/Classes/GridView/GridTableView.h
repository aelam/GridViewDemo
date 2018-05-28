//
//  GridTableView.h
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

#import <UIKit/UIKit.h>

@protocol GridTableViewCell;
@protocol GridDelegate<UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView widthForColumn:(NSInteger)column;

- (void)tableView:(UITableView *)tableView didSelectHeaderAtSection:(NSInteger)section column:(NSInteger)column;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath column:(NSInteger)column;


@end

@protocol GridDataSource<UITableViewDataSource>

- (NSInteger)numberOfColumnInTableView:(UITableView *)tableView;
- (NSInteger)numberOfFixedColumnInTableView:(UITableView *)tableView;

- (UIView *)tableView:(UITableView *)tableView viewForColumn:(NSInteger)column;

- (UITableViewCell<GridTableViewCell> *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface GridTableView : UITableView

@property (nonatomic, assign) NSInteger fixedColumnCount;
@property (nonatomic, weak) id<GridDataSource> gridDataSource;
@property (nonatomic, weak) id<GridDelegate> gridDelegate;

- (UIView *)viewForIndexPath:(NSIndexPath *)indexPath column:(NSInteger)column;

@end
