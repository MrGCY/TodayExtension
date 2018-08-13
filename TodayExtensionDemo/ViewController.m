//
//  ViewController.m
//  TodayExtensionDemo
//
//  Created by Mr.GCY on 2018/8/9.
//  Copyright © 2018年 Mr.GCY. All rights reserved.
//

#import "ViewController.h"
#import "CYSubViewController.h"
#import "TodayItemModel.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
     [super viewDidLoad];
     [self setupData];
     [self setupSubviews];
}
#pragma mark- 初始化
-(void)setupData{
     self.title = @"首页";
}
-(void)setupSubviews{
     self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
     self.tableView.delegate = self;
     self.tableView.dataSource = self;
     self.tableView.tableFooterView = [UIView new];
     [self.view addSubview:self.tableView];
     UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithTitle:@"切换标题" style:UIBarButtonItemStylePlain target:self action:@selector(clickSwitchTitleEvent)];
     self.navigationItem.rightBarButtonItem = rightItem;
}
//切换通知栏标题
-(void)clickSwitchTitleEvent{
     NSArray * arr = @[@"生活有度，人生添寿。 —— 书摘",@"理想是人生的太阳。 —— 德莱赛",@"不是老人变坏了，而是坏人变老了",@"人生苦短，必须性感"];
     NSInteger index = arc4random() % 5;
     // 存储数据
     [[[NSUserDefaults alloc] initWithSuiteName:@"group.com.mrgcy.appExtension"] setValue:arr[index] forKey:@"myShareData"];
}
#pragma mark- lazy
-(NSMutableArray *)dataArray{
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
#pragma mark- UITableViewDelegate,UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
     if (cell == nil) {
          cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
     }
     TodayItemModel * model = self.dataArray[indexPath.row];
     cell.textLabel.text = model.title;
     return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     TodayItemModel * model = self.dataArray[indexPath.row];
     CYSubViewController * subVC = [CYSubViewController new];
     subVC.title = model.title;
     [self.navigationController pushViewController:subVC animated:YES];
}
@end
