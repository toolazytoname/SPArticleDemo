//
//  ArticleViewController.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/20.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleTableViewController.h"

#import "ArticleWebViewTableViewCell.h"
#import "ArticleTitleTableViewCell.h"
static NSString *ArticleWebViewTableViewCellIdentifier = @"ArticleWebViewTableViewCellIdentifier";
static NSString *ArticleTitleTableViewCellIdentifier = @"ArticleTitleTableViewCellIdentifier";


@interface ArticleViewController ()
@property (strong, nonatomic) IBOutlet UITableView *articleTableView;
@property (retain, nonatomic) ArticleTableViewController *articleTableViewController;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.articleTableView registerClass:[ArticleWebViewTableViewCell class] forCellReuseIdentifier:ArticleWebViewTableViewCellIdentifier];
    [self.articleTableView registerClass:[ArticleTitleTableViewCell class] forCellReuseIdentifier:ArticleTitleTableViewCellIdentifier];
    
    

    _articleTableViewController = [[ArticleTableViewController alloc] init];
    self.articleTableView.delegate = self.articleTableViewController;
    self.articleTableView.dataSource = self.articleTableViewController;
    self.articleTableViewController.dataList = [NSArray arrayWithObjects:@"http://sports.sina.com.cn/g/pl/2014-11-21/11577418385.shtml",@"1b",@"2bc",@"3bd",@"4eb",@"5fb",@"6gb",@"7hb",@"8ib",@"9ib", nil];

    [self.articleTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
