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

@interface ArticleTableViewController ()
@property (nonatomic,strong) NSArray *dataList;
@end

@implementation ArticleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[ArticleWebViewTableViewCell class] forCellReuseIdentifier:ArticleWebViewTableViewCellIdentifier];
    [self.tableView registerClass:[ArticleTitleTableViewCell class] forCellReuseIdentifier:ArticleTitleTableViewCellIdentifier];
    
    
    self.dataList = [NSArray arrayWithObjects:@"http://sports.sina.com.cn/g/pl/2014-11-21/11577418385.shtml",@"1b",@"2bc",@"3bd",@"4eb",@"5fb",@"6gb",@"7hb",@"8ib",@"9ib", nil];
    
    
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
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id item = [self.dataList safeObjectAtIndex:indexPath.row];
    VideoBaseTableViewCell *cell;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:ArticleWebViewTableViewCellIdentifier];
        if (!cell) {
            cell = [[ArticleWebViewTableViewCell alloc] initWithFrame:CGRectZero];
        }
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:ArticleTitleTableViewCellIdentifier];
        if (!cell) {
            cell = [[ArticleTitleTableViewCell alloc] initWithFrame:CGRectZero];
        }
    }
    [cell updateCellWithModel:item];
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
