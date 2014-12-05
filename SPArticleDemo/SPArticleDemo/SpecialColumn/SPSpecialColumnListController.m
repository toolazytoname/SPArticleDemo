//
//  SPSpecialColumnList.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/5.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnListController.h"
#import "SPSpecialColumnListTableViewController.h"
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

- (void)requestDidStartLoad:(BaseDataRequest*)request
{}
- (void)requestDidFinishLoad:(BaseDataRequest*)request
{
    NSArray *list = [request.resultDataDic objectForKeyNotNull:SPSpecialColumnKey];
    self.specialColumnListTableViewController.subscribeListData = list;
    [self.specialColumnListTableViewController.tableView reloadData];
}
- (void)request:(BaseDataRequest*)request didFailLoadWithError:(NSError*)error
{}

@end
