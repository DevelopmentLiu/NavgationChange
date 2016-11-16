//
//  ViewController.m
//  渐变Navgation
//
//  Created by jyLiu on 16/7/6.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "ViewController.h"
#import "mainTableViewCell.h"
#import "showTableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationBarDelegate,UITabBarDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UINavigationBar *bar;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    //单独创建navigationBar
    [self initNavigationBar];
}

#pragma mark -- UITableViewdelegate、datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        cell = (mainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"mainTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        self.tableView.rowHeight = cell.frame.size.height;
    }
    else
    {
        cell = (showTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"showcell"];
        NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"showTableViewCell" owner:self options:nil];
        cell = [arr objectAtIndex:0];
        self.tableView.rowHeight = cell.frame.size.height;
    }
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor *color = [UIColor colorWithRed:0.0/255 green:255.0/255 blue:255.0/255 alpha:1.0];
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = 1 - ((64 - offsetY) / 64);
        self.bar.backgroundColor = [color colorWithAlphaComponent:alpha];
    }
    else
    {
        self.bar.backgroundColor = [color colorWithAlphaComponent:0];
    }
}
#pragma mark -- 创建UINavigationBar
- (void)initNavigationBar
{
    self.bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64)];
    for (UIView *view in self.bar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            [view removeFromSuperview];
        }
    }
    self.bar.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.bar];
}

#pragma mark -- getter
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-65) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = NO;
    }
    return _tableView;
}

@end
