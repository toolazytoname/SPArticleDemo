//
//  SPAWViewController+ThemeStyle.m
//  SPArticleDemo
//
//  Created by SINA on 14/11/26.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPAWViewController+ThemeStyle.h"
#import "UIView+ITTAdditions.h"
NSInteger browserViewTag = 10010;
NSInteger themeImageViewTag = 10009;
CGFloat themeImageHeight = 300.0;
#define screenWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
CGFloat statusHeight = 20;
@interface SPAWViewController()<UIScrollViewDelegate>

@end

@implementation SPAWViewController (ThemeStyle)
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"offsetY:%f",offsetY);
    [self willChangeHeightFromOffset:offsetY];
    
}

-(void)addTheme
{
    //把webView内的UIWebBrowserView 往下移动
    self.webview.scrollView.delegate = self;
    for (UIView *browserView in self.webview.scrollView.subviews) {
        if ([NSStringFromClass([browserView class]) isEqualToString:@"UIWebBrowserView"] ) {
            browserView.tag = browserViewTag;
        }
    }
    UIView *browserView = [self.webview viewWithTag:browserViewTag];
    browserView.top = themeImageHeight -statusHeight ;
    //把webView内的增加图片UIImageView
    UIImage *themeImage = [UIImage imageNamed:@"themeImage.jpg"];
    UIImageView *themeImageView = [[UIImageView alloc] initWithImage:themeImage];
    themeImageView.clipsToBounds = YES;
    themeImageView.frame = CGRectMake(0.0, 0.0,screenWidth, themeImageHeight);
    themeImageView.tag = themeImageViewTag;
    themeImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.webview addSubview:themeImageView];
}
/**
 *  调整位移
 *
 *  @param offset 偏移量
 */
- (void)willChangeHeightFromOffset:(CGFloat)offset{
    UIImageView *themeImageView = (UIImageView *)[self.webview viewWithTag:themeImageViewTag];
    
    CGFloat standardOffset =  - statusHeight;//如果现实navigationBar则数值为 -64否则   -20
    CGFloat hideImageOffset = themeImageHeight  - statusHeight;//236
    
    if (offset < standardOffset)//正常状态，往下拖
    {
        themeImageView.height =  -offset + themeImageHeight + standardOffset ;
        themeImageView.top = 0.0 ;
    }
    else //正常状态，往上脱，拖到图片完全不可见
    {
        float r = 1- offset / hideImageOffset;
        [themeImageView setAlpha:r];
        themeImageView.top = -offset  + standardOffset ;
    }
    
    
    if (offset <= hideImageOffset - self.navigationController.navigationBar.height ) {
        [self changeNavigationBarTransparent];
    }
    else
    {
        [self returnNavigationBarDefault];
    }
}

/**
 *  把NavigationBar变透明
 */
-(void)changeNavigationBarTransparent
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
}

/**
 *  恢复默认状态的NavigationBar
 */
-(void)returnNavigationBarDefault
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
@end
