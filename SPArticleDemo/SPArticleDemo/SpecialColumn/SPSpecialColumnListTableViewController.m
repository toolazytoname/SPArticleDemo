//
//  SPSpecialColumnListTableViewController.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/5.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnListTableViewController.h"
#import "SPSpecialColumnBaseCell.h"
#import "SPSpecialColumnCell.h"
#import "SPSpecialColumnActionCell.h"
#import "SPSpecialColumnHeaderView.h"

static NSString  *SPSpecialColumnCellIdeftifier = @"SPSpecialColumnCellIdeftifier";
static NSString  *SPSpecialColumnActionCellIdeftifier = @"SPSpecialColumnActionCellIdeftifier";

@implementation SPSpecialColumnListTableViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[SPSpecialColumnCell class] forCellReuseIdentifier:SPSpecialColumnCellIdeftifier];
    [self.tableView registerClass:[SPSpecialColumnActionCell class] forCellReuseIdentifier:SPSpecialColumnActionCellIdeftifier];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count;
    if (0 == section) {
        count = self.subscribeListData.count;
    }
    else if(1 == section)
    {
        count = self.recommendListData.count;
    }
    return count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    SPSpecialColumnBaseCell *cell;
    id module;
    if (0 == section) {
        cell = [tableView dequeueReusableCellWithIdentifier:SPSpecialColumnCellIdeftifier];
        module = [self.subscribeListData safeObjectAtIndex:indexPath.row];
        
    }
    else if (1 == section)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:SPSpecialColumnActionCellIdeftifier];
        module = [self.recommendListData safeObjectAtIndex:indexPath.row];
    }
    
    [cell updateCellWithModule:module];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (0 == indexPath.section) {
        height = [SPSpecialColumnCell getCellHeight];
    }
    else if(1 == indexPath.section)
    {
        height = [SPSpecialColumnActionCell getCellHeight];
    }
    return height;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    if (0 == section) {
        return nil;
    }
    else if (1 == section) {
        title = @"热门推荐";
    }
    SPSpecialColumnHeaderView *specialColumnHeaderView = [[SPSpecialColumnHeaderView alloc] initWithFrame:CGRectZero];
    [specialColumnHeaderView setHeaderTitle:title];
    return specialColumnHeaderView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height;
    if (0 == section) {
        height = 0.0f;
    }
    else if(1 == section)
    {
        height = [SPSpecialColumnHeaderView getHeaderViewHeight];
    }
    return height;
}
@end
