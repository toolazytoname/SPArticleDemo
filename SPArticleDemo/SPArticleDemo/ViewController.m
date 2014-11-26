//
//  ViewController.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/19.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "ViewController.h"
#import "ArticleViewController.h"
#import "SPAWViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ArticleIdentifier"]) {
        ArticleViewController *articleViewController = segue.destinationViewController;
        articleViewController.urlParam = @"http://sports.sina.com.cn/g/2014-11-20/11227417104.shtml";
    }
    
    if ([segue.identifier isEqualToString:@"ArticleWithHotComment"]) {
        ArticleViewController *articleViewController = segue.destinationViewController;
        articleViewController.urlParam = @"http://sports.sina.com.cn/g/pl/2014-11-21/11577418385.shtml";
    }
    
    if ([segue.identifier isEqualToString:@"ArticleWithTheme"]) {
        SPAWViewController *awViewController = segue.destinationViewController;
        awViewController.urlParam = @"http://sports.sina.com.cn/g/pl/2014-11-21/11577418385.shtml";
        awViewController.isThemeParam = YES;
    }
}
@end
