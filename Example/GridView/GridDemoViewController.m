//
//  GridDemoViewController.m
//  GridView_Example
//
//  Created by Ryan Wang on 2018/5/28.
//  Copyright © 2018 aelam. All rights reserved.
//


//
//  ZXGGridViewController.m
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

@import GridView;
@import StockPB;

#import "GridDemoViewController.h"

@interface GridDemoViewController () <UITableViewDelegate, UITableViewDataSource, GridDataSource, GridDelegate>

@end

@implementation GridDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gridTableView = [[GridTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.gridTableView.gridDataSource = self;
    self.gridTableView.gridDelegate = self;
    //    self.gridTableView.gridDataSource = self;
    
    self.gridTableView.sectionHeaderHeight = 44;
    self.gridTableView.numberOfColumns = 10;
    self.gridTableView.numberOfFixedColumns = 1;
    
    [self.view addSubview:self.gridTableView];
    
    [self.gridTableView registerClass:[GridTableViewCell class] forCellReuseIdentifier:NSStringFromClass(GridTableViewCell.class)];
    
}


- (void)requestData {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GridTableViewCell *cell = [[GridTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GridTableViewCell.class) forIndexPath:indexPath];
    
    return cell;
}

//- (NSInteger)numberOfColumnInTableView:(UITableView *)tableView {
//    return 10;
//}
//

- (CGFloat)tableView:(UITableView *)tableView widthForColumn:(NSInteger)column {
    if (column % 2 == 0) {
        return 60;
    }
    return 100;
    
}

- (void)tableView:(UITableView *)tableView didSelectHeaderAtSection:(NSInteger)section column:(NSInteger)column {
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath column:(NSInteger)column {
    
}


- (UIView *)tableView:(UITableView *)tableView viewForColumn:(NSInteger)column {
    UILabel *view = [UILabel new];
    view.text = [NSString stringWithFormat:@"%zd", column];
    view.textAlignment = NSTextAlignmentCenter;
    view.layer.borderWidth = 1;
    
    return view;
}

- (NSInteger)numberOfFixedColumnInTableView:(UITableView *)tableView {
    return 2;
}


@end
