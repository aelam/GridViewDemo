//
//  ZXGGridViewController.m
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

#import "ZXGGridViewController.h"
#import "GridTableView.h"
#import "GridTableViewCell.h"

@interface ZXGGridViewController () <UITableViewDelegate, UITableViewDataSource, GridDataSource>

@end

@implementation ZXGGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gridTableView = [[GridTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.gridTableView.gridDataSource = self;
    self.gridTableView.gridDelegate = self;
//    self.gridTableView.gridDataSource = self;

    self.gridTableView.sectionHeaderHeight = 44;
    
    [self.view addSubview:self.gridTableView];
    
    
    [self.gridTableView registerClass:[GridTableViewCell class] forCellReuseIdentifier:NSStringFromClass(GridTableViewCell.class)];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GridTableViewCell *cell = [[GridTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GridTableViewCell.class) forIndexPath:indexPath];
    
    return cell;
}

- (NSInteger)numberOfColumnInTableView:(UITableView *)tableView {
    return 10;
}


- (CGFloat)tableView:(UITableView *)tableView widthForColumn:(NSInteger)column {
    if (column % 2 == 0) {
        return 60;
    }
    return 100;

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
