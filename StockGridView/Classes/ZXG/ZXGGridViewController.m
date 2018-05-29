//
//  ZXGGridViewController.m
//  ymStock
//
//  Created by ryan on 2018/5/28.
//

@import SKStockStone;
@import SKDynamicStock;
@import StockPB;
@import ReactiveCocoa;

#import "ZXGGridViewController.h"
#import "GridTableView.h"
#import "GridTableViewCell.h"
#import "RankViewModel.h"
#import "RankFieldNameMapping.h"
#import "YMGridNameView.h"

@interface ZXGGridViewController () <UITableViewDelegate, UITableViewDataSource, GridDataSource, GridDelegate>


//static let defaultFields: [SKStockRequireField] = [.clo_prc, .cpx_dur_days , .change_ratio, .change_prc, .turnover_ratio, .pe_ratio, .volume, .amount, .quantity_relative_ratio, .amplitude, .speed_ratio, .change_ratio_of5, .turnover_ratio_of5, .static_earnings_per_shares, .tradable_market_value, .GOODS_DOCTOR_FLAG]
//
//static let baseFields: [SKStockRequireField] = [.stock_name, .code_name, .MARGIN_TRADING_FLAG]

@property (nonatomic, strong) RankViewModel *viewModel;

@end

@implementation ZXGGridViewController


- (instancetype)init {
    if (self = [super init]) {
        self.viewModel = [RankViewModel new];
        self.displayFieldIds = @[@(stock_name), @(clo_prc),@(cpx_dur_days),@(change_prc),@(turnover_ratio),@(pe_ratio),@(volume),@(amount),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(change_ratio_of5),@(turnover_ratio_of5),@(static_earnings_per_shares),@(tradable_market_value),@(GOODS_DOCTOR_FLAG)];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gridTableView = [[GridTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.gridTableView.gridDataSource = self;
    self.gridTableView.gridDelegate = self;
    self.gridTableView.sectionHeaderHeight = 30;
    self.gridTableView.numberOfFixedColumns = 1;
    self.gridTableView.numberOfColumns = 10;
     [self.view addSubview:self.gridTableView];
    
    [self.gridTableView registerClass:[GridTableViewCell class] forCellReuseIdentifier:NSStringFromClass(GridTableViewCell.class)];
//    [self.gridTableView registerClass:[GridTableViewHeader class] forHeaderFooterViewReuseIdentifier:NSStringFromClass(GridTableViewHeader.class)];

    [self setupViewModel];
    
    [self.viewModel.requestCommand execute:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupViewModel {
    self.viewModel.requestFields = @[@(stock_name),@(code_name),@(MARGIN_TRADING_FLAG),@(clo_prc),@(cpx_dur_days),@(change_prc),@(turnover_ratio),@(pe_ratio),@(volume),@(amount),@(quantity_relative_ratio),@(amplitude),@(speed_ratio),@(change_ratio_of5),@(turnover_ratio_of5),@(static_earnings_per_shares),@(tradable_market_value),@(GOODS_DOCTOR_FLAG)];
    self.viewModel.goodsIdArray = @[@600600, @1, @600018,@600019];
    
    @weakify(self);
    [RACObserve(self.viewModel, stocks) subscribeNext:^(NSArray *stocks) {
        @strongify(self);
        [self.gridTableView reloadData];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.stocks.count;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    GridTableViewCell *cell = [[GridTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"header"];
    cell.contentView.backgroundColor = [UIColor blackColor];
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GridTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(GridTableViewCell.class) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    return cell;
}

// MARK: - - 更新
- (void)tableView:(UITableView *)tableView willDisplayColumnView:(UIView *)convertView forIndexPath:(NSIndexPath *)indexPath column:(NSInteger)column {
    NSLog(@"更新[%zd, %zd, %zd]", indexPath.section, indexPath.row, column);
    SKStockRequireField fieldId = [self.displayFieldIds[column] intValue];
    
    id<SKStock> stock = self.viewModel.stocks[indexPath.row];
    SKStockStringFormatter *strings = [SKStockStringFormatter formatterWithStock:stock];
    SKStockColorFormatter *colors = [SKStockColorFormatter formatterWithStock:stock];

    if (column == 0) {
        YMGridNameView *nameView = (YMGridNameView *)convertView;
        NSString *fieldName = [RankFieldNameMapping fieldsIdNameMapping][self.displayFieldIds[column]];
        
        nameView.nameLabel.text = stock.stockName;
        nameView.codeLabel.text = stock.codeName;
        nameView.rongImageView.hidden = [stock[GOODS_DOCTOR_FLAG] boolValue];
    } else {
        UILabel *textLabel = (UILabel *)convertView;
        textLabel.text = strings[fieldId];
//        textLabel.textColor = colors[fieldId];
        textLabel.textColor = [UIColor whiteColor];

    }
}


- (void)tableView:(UITableView *)tableView willDisplayColumnView:(UIView *)convertView inSection:(NSInteger)section column:(NSInteger)column {
    NSString *fieldName = [RankFieldNameMapping fieldsIdNameMapping][self.displayFieldIds[column]];
    UILabel *textLabel = (UILabel *)convertView;
    textLabel.text = fieldName;

}


- (NSInteger)numberOfColumnInTableView:(UITableView *)tableView {
    return self.displayFieldIds.count;
}


- (CGFloat)tableView:(UITableView *)tableView widthForColumn:(NSInteger)column {
    if (column % 2 != 0) {
        return 60;
    }
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectHeaderAtSection:(NSInteger)section column:(NSInteger)column {
    SKStockRequireField fieldId = self.displayFieldIds[column].intValue;
    [self.viewModel updateSortField:fieldId];

    [self.viewModel.requestCommand execute:nil];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath column:(NSInteger)column {
    NSLog(@"section = %zd, row = %zd, column: %zd",indexPath.section ,indexPath.row , column);
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderColumn:(NSInteger)column {
    UILabel *view = [UILabel new];
    view.text = [NSString stringWithFormat:@"%zd", column];
    view.textAlignment = NSTextAlignmentCenter;
    view.textColor = [UIColor whiteColor];
    view.layer.borderWidth = 1;
    
    if (column == 0) {
        view.textAlignment = NSTextAlignmentLeft;
    }
    
    return view;
}


// MARK: - 需要的地方只创建一次只有就不会在调用
- (UIView *)tableView:(UITableView *)tableView viewForCellColumn:(NSInteger)column {
    if (column == 0) {
        YMGridNameView *view = [YMGridNameView new];
        return view;
    } else {
        UILabel *view = [UILabel new];
        view.text = [NSString stringWithFormat:@"%zd", column];
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = [UIColor whiteColor];
        view.layer.borderWidth = 1;
        return view;
    }
    
}


@end
