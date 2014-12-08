//
//  SPSpecialColumnList.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/5.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnListController.h"
#import "SPSpecialColumnListTableViewController.h"
#import "SPSpecialColumnCoreDataManager.h"
@interface SPSpecialColumnListController()
@property (nonatomic,strong) SPSpecialColumnListTableViewController *specialColumnListTableViewController;
@end

@implementation SPSpecialColumnListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _specialColumnListTableViewController = [[SPSpecialColumnListTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.specialColumnListTableViewController.view];
    [self requestSpecialColumn];
}

-(void)requestSpecialColumn
{
    [self addRequest:[SPSpecialColumnDataRequest requestWithDelegate:self parameters:nil isUseCache:YES]];
}
-(void)requestSubScribe
{
    
}

- (void)requestDidStartLoad:(BaseDataRequest*)request
{}
- (void)requestDidFinishLoad:(BaseDataRequest*)request
{
    NSArray *list = [request.resultDataDic objectForKeyNotNull:SPSpecialColumnKey];
    self.specialColumnListTableViewController.subscribeListData = list;
    self.specialColumnListTableViewController.recommendListData = list;
    [self.specialColumnListTableViewController.tableView reloadData];
    
//    [self subscribe:list];
    [self getAll];
}
- (void)request:(BaseDataRequest*)request didFailLoadWithError:(NSError*)error
{}


/**
 *  订阅
 */
-(void)subscribe:(NSArray *)array
{
//    spspecial
    SPSpecialColumnCoreDataManager *specialColumnCoreDataManager = [SPSpecialColumnCoreDataManager shareInstance];
    [specialColumnCoreDataManager addSpecialColumnList:array];
}

/**
 *  退订
 */
-(void)unSubscribe
{}

-(void)getAll
{
    SPSpecialColumnCoreDataManager *specialColumnCoreDataManager = [SPSpecialColumnCoreDataManager shareInstance];
    [specialColumnCoreDataManager getAll];

}

/*
一.专栏
1.专栏无论是登录用户还是非登录用户都可以订阅
2.非登录用户订阅时调用订阅计数接口增加订阅数，但订阅信息存在本地
3.登录用户订阅时调用订阅接口，登录用户的订阅信息存在后台，同时本地也要存一份
4.非登录用户的订阅列表上会有引导用户登录的提示，如果用户登录，则将本地存储的订阅信息同步給后台
5.如果原登录用户退出登录，显示本地存储的订阅信息，如果用户再次登录（包括更换其他账号）时讲本地存储的订阅信息同步给后台
6.如果本地没有订阅信息，且用户已登录，请求后台订阅信息显示并存在本地
7.多账号切换时按照5中的逻辑走
8.用户点击某个专栏后本地记录下时间戳，待下次请求已订阅专栏列表时将专栏对应的时间戳送给后台，后台通过时间戳来计算专栏未读数
9.通过本地存储的订阅信息来判断显示是否订阅该专栏
10.请求推荐专栏时如果有本地订阅信息则把本地订阅信息带上，后台好过滤已经订阅的专栏
 
 专栏列表测试接口：
 http://platform.sina.com.cn/sports_client/z_list?app_key=2586208540
 title 为专栏title
 desc 为专栏描述
 fans_num 订阅数
 pic 专栏头像
 feed_id 取专栏详情列表时用的ID
 */
@end
