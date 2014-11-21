//
//  ArticleViewController.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/20.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "ArticleViewController.h"
#import "ArticleTableViewController.h"

@interface ArticleViewController ()
@property (strong, nonatomic) IBOutlet UITableView *articleTableView;
@property (retain, nonatomic) ArticleTableViewController *articleTableViewController;

@end

@implementation ArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _articleTableViewController = [[ArticleTableViewController alloc] init];
    self.articleTableView.delegate = self.articleTableViewController;
    self.articleTableView.dataSource = self.articleTableViewController;
    [self.articleTableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
