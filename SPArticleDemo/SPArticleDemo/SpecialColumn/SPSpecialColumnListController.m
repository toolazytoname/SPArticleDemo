//
//  SPSpecialColumnList.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/5.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnListController.h"
#import "SPSpecialColumnListTableViewController.h"
#import "SPSpecialColumnUtil.h"
@interface SPSpecialColumnListController()
@property (nonatomic,strong) SPSpecialColumnListTableViewController *specialColumnListTableViewController;
@end

@implementation SPSpecialColumnListController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _specialColumnListTableViewController = [[SPSpecialColumnListTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [self.view addSubview:self.specialColumnListTableViewController.view];
//    [self requestSpecialColumn];
}








@end
