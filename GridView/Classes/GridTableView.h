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

// 只负责创建
- (UIView *)tableView:(UITableView *)tableView viewForHeaderColumn:(NSInteger)column;
- (UIView *)tableView:(UITableView *)tableView viewForCellColumn:(NSInteger)column;

// 负责更新
- (void)tableView:(UITableView *)tableView willDisplayColumnView:(UIView *)convertView forIndexPath:(NSIndexPath *)indexPath column:(NSInteger)column;

- (void)tableView:(UITableView *)tableView willDisplayColumnView:(UIView *)convertView inSection:(NSInteger)section column:(NSInteger)column;


- (UITableViewCell<GridTableViewCell> *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;


@end

@interface GridTableView : UITableView

@property (nonatomic, assign) NSInteger numberOfFixedColumns;
@property (nonatomic, assign) NSInteger numberOfColumns;
@property (nonatomic, weak) id<GridDataSource> gridDataSource;
@property (nonatomic, weak) id<GridDelegate> gridDelegate;

@end
