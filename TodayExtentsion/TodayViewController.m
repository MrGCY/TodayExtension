//
//  TodayViewController.m
//  TodayExtentsion
//
//  Created by Mr.GCY on 2018/8/9.
//  Copyright © 2018年 Mr.GCY. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "TodayItemCell.h"
#import "TodayItemModel.h"

#define identifierTodayItemCell @"TodayItemCell"
#define NewHeight 400
@interface TodayViewController () <NCWidgetProviding,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation TodayViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self setupData];
     [self setupSubviews];
}
-(void)setupSubviews{
     self.tableView.rowHeight = 60;
     [self.tableView registerNib:[UINib nibWithNibName:identifierTodayItemCell bundle:nil] forCellReuseIdentifier:identifierTodayItemCell];
}
-(void)setupData{
     // 将小部件展现模型设置为可展开
     if (@available(iOS 10.0, *)) {
          self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
     } else {
          // Fallback on earlier versions
     }
}
#pragma mark- lazy
-(NSArray *)dataArray{
     if (!_dataArray) {
          NSArray * array = @[
                         @{@"icon":@"bangzhu",@"handerUrl":@"TodayExtensionDemo://help",@"title":@"帮助"},
                         @{@"icon":@"fankui",@"handerUrl":@"TodayExtensionDemo://feedback",@"title":@"反馈"},
                         @{@"icon":@"gerenxinxi",@"handerUrl":@"TodayExtensionDemo://userInfo",@"title":@"个人信息"},
                         @{@"icon":@"kefu",@"handerUrl":@"TodayExtensionDemo://customerService",@"title":@"客服"},
                         @{@"icon":@"shezhi",@"handerUrl":@"TodayExtensionDemo://set",@"title":@"设置"},
                         ];
          _dataArray = [NSMutableArray arrayWithCapacity:array.count];
          for (NSDictionary * dic in  array) {
               TodayItemModel * model = [[TodayItemModel alloc] initWithDictionary:dic error:nil];
               if (model) {
                    [_dataArray addObject:model];
               }
          }
     }
     return _dataArray;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
     //点击跳转到APP
     [self.extensionContext openURL:[NSURL URLWithString:@"TodayExtensionDemo://enterApp"] completionHandler:nil];
}
#pragma mark- NCWidgetProviding
- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData
     // 取出数据
     NSString * myData = [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.mrgcy.appExtension"] valueForKey:@"myShareData"];
     self.titleLabel.text = myData ? myData : @"你好世界";
    completionHandler(NCUpdateResultNewData);
}
- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize  API_AVAILABLE(ios(10.0)){
     if (@available(iOS 10.0, *)) {
          if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
               // 设置展开的新高度
               self.preferredContentSize = CGSizeMake(0, NewHeight);
          }else{
               self.preferredContentSize = maxSize;
          }
     } else {
          
     }
}
#pragma mark- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     TodayItemCell * cell = [tableView dequeueReusableCellWithIdentifier:identifierTodayItemCell];
     TodayItemModel * model = self.dataArray[indexPath.row];
     cell.iconImageView.image = [UIImage imageNamed:model.icon];
     cell.titleLabel.text = model.title;
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     TodayItemModel * model = self.dataArray[indexPath.row];
     //点击跳转到APP
     [self.extensionContext openURL:[NSURL URLWithString:model.handerUrl] completionHandler:nil];
}
@end
