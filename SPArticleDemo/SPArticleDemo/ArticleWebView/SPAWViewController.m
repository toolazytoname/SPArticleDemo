//
//  SPAWViewController.m
//  Sports
//
//  Created by sgl on 13-11-1.
//  Copyright (c) 2013年 sina.com. All rights reserved.
//

#import "SPAWViewController.h"
#import "SPAWViewController+ArticleData.h"
#import "UIView+ITTAdditions.h"
NSInteger browserViewTag = 10010;
NSInteger themeImageViewTag = 10009;
CGFloat themeImageHeight = 300.0;
CGFloat width = 320;
CGFloat statusHeight = 20;

@interface SPAWViewController ()<UIScrollViewDelegate>

@end

@implementation SPAWViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadArticle];
    
    [self changeNavigationBarTransparent];
    [self addTheme];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY:%f",offsetY);
    [self willChangeHeightFromOffset:offsetY];
    
}

-(void)addTheme
{
    self.webview.scrollView.delegate = self;
    for (UIView *browserView in self.webview.scrollView.subviews) {
        if ([NSStringFromClass([browserView class]) isEqualToString:@"UIWebBrowserView"] ) {
            browserView.tag = browserViewTag;
        }
    }
    UIView *browserView = [self.webview viewWithTag:browserViewTag];
    browserView.top = themeImageHeight;
    
    UIImage *themeImage = [UIImage imageNamed:@"themeImage.jpg"];
    UIImageView *themeImageView = [[UIImageView alloc] initWithImage:themeImage];
    themeImageView.clipsToBounds = YES;
    themeImageView.frame = CGRectMake(0.0, 0.0, width, themeImageHeight);
    themeImageView.tag = themeImageViewTag;
    themeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.webview addSubview:themeImageView];
}

- (void)willChangeHeightFromOffset:(CGFloat)offset{
    UIImageView *themeImageView = (UIImageView *)[self.webview viewWithTag:themeImageViewTag];
    
    CGFloat standardOffset = - self.navigationController.navigationBar.height - statusHeight;//-64
    CGFloat hideImageOffset = themeImageHeight - self.navigationController.navigationBar.height - statusHeight;//236
    
    if (offset < standardOffset)//正常状态，往下拖
    {
        themeImageView.height =  -offset + themeImageHeight + standardOffset;
        themeImageView.top = 0.0;
    }
    else  if(standardOffset <= offset && offset <= hideImageOffset)//往上脱
    {
        float r = 1- offset / hideImageOffset;
        [themeImageView setAlpha:r];
        themeImageView.top = -offset  + standardOffset;
    }
    else
    {
        themeImageView.alpha = 0;
        themeImageView.top = -offset  + standardOffset;
    }
}

-(void)changeNavigationBarTransparent
{
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                             forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;

    self.navigationController.navigationBar.hidden = YES;

}


@end
