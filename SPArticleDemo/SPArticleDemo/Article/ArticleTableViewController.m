//
//  ArticleTableViewController.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/21.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "ArticleTableViewController.h"
#import "ArticleWebViewTableViewCell.h"
#import "ArticleTitleTableViewCell.h"
static NSString *ArticleWebViewTableViewCellIdentifier = @"ArticleWebViewTableViewCellIdentifier";
static NSString *ArticleTitleTableViewCellIdentifier = @"ArticleTitleTableViewCellIdentifier";

@interface ArticleTableViewController ()<ArticleWebViewTableViewCellDelegate>
@end

@implementation ArticleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self.dataList safeObjectAtIndex:indexPath.row];
    VideoBaseTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:ArticleWebViewTableViewCellIdentifier];
        ArticleWebViewTableViewCell* webViewCell = (ArticleWebViewTableViewCell*)cell;
        webViewCell.articleWebViewTableViewCellDelegate = self;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:ArticleTitleTableViewCellIdentifier];
    }
    [cell updateCellWithModel:item];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.row == 0) {
        height = [ArticleWebViewTableViewCell cellHeight];
    }
    else
    {
        height = [ArticleTitleTableViewCell cellHeight];
    }
    NSLog(@"row height:%f",height);
    return height;

    
}
- (void)layoutArticleFinished:(UIWebView *)webView SPAWViewController:(SPAWViewController *)AWViewController ArticleWebViewTableViewCell:(ArticleWebViewTableViewCell *)ArticleWebViewTableViewCell
{
    NSArray *indexPaths = [NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
