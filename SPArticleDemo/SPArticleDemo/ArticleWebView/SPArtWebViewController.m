//
//  SPArtWebViewController.m
//  ArticleShow
//
//  Created by sgl on 13-11-1.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import "SPArtWebViewController.h"

@interface SPArtWebViewController ()

@end

@implementation SPArtWebViewController

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
	// Do any additional setup after loading the view.
    [_webview setBackgroundColor:[UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0]];
    [_webview setOpaque:NO];
    for (UIView* subView in [_webview subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            for (UIView* shadowView in [subView subviews])
            {
                if ([shadowView isKindOfClass:[UIImageView class]]) {
                    [shadowView setHidden:YES];
                }
            }
        }
    }
    _webview.delegate = self;
    
    NSString *html = [NSString stringWithContentsOfFile:_templateFile encoding:NSUTF8StringEncoding error:nil];
    [_webview loadHTMLString:html baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#if __has_feature(objc_arc)
#else
- (void)viewDidUnload
{
    self.webview = nil;
    [super viewDidUnload];
}

- (void)dealloc
{
    [_webview release];
    [_templateFile release];
    [super dealloc];
}
#endif

#pragma mark -
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    NSArray *requestArray = [requestString componentsSeparatedByString:@":##sendToApp##"];
    
    if ([requestArray count] > 1){
        NSString *requestPrefix = [[requestArray objectAtIndex:0] lowercaseString];
        NSString *requestMssg = ([requestArray count] > 0) ? [requestArray objectAtIndex:1] : @"";
        [self webviewMessageKey:requestPrefix value:requestMssg];
        return NO;
    }

    return [self shouldStartLoadWithRequest:request navigationType:navigationType];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self didFinishLoad];
}

- (void)webviewMessageKey:(NSString *)key value:(NSString *)val
{
    NSLog(@"%@: %@", key, val);
    NSString *lkey = [key lowercaseString];
    
    if ([lkey isEqualToString:kSPWebActionPlayVideo]) {
        [self playVideo:val];
    }
    else if ([lkey isEqualToString:kSPWebActionShowAlbum]) {
        [self showAlbum:val];
    }
    else if ([lkey isEqualToString:kSPWebActionShowImage]) {
        [self showImage:val];
    }
    else if ([lkey isEqualToString:kSPWebActionCustom]) {
        [self customAction:val];
    }
    else if ([lkey isEqualToString:kSPWebActionReady]) {
        [self readyForData];
    }
    else if ([lkey isEqualToString:kSPWebActionLayoutFinished]) {
        [self layoutArticleFinished];
    }
    else if ([lkey isEqualToString:kSPWebActionLayoutPlayer]) {
        [self layoutPlayer:val];
    }
    else if ([lkey isEqualToString:kSPWebActionLayoutHeadImage]) {
        [self layoutHeadImage:val];
    }
    else if([lkey isEqualToString:kSPWebActionLayoutArticleImage]) {
        [self layoutArticleImage:val];
    }
    else if([lkey isEqualToString:kSPWebActionPopTableImage])
    {
        [self popTableImage:val];
    }
    else if ([lkey isEqualToString:kSPWebActionBottomADImageClick])
    {
        [self bottomADImageClick:val];
    }
    else if([lkey isEqualToString:kSPWebActionHeadADImageClick])
    {
        [self headADImageClick:val];
    }

}

#pragma mark -
- (NSString *)runJSFuncion:(NSString *)func
{
    return [_webview stringByEvaluatingJavaScriptFromString:func];
}

#pragma mark - Template Methods
- (BOOL)shouldStartLoadWithRequest:(NSURLRequest *)req navigationType:(UIWebViewNavigationType)navigationType
{
    return YES;
}

- (void)readyForData
{
    
}

- (void)layoutArticleFinished
{
    
}

- (void)playVideo:(id)video
{
    
}

- (void)showAlbum:(id)album
{
    
}

- (void)showImage:(id)image
{
    
}

- (void)customAction:(id)action
{
    
}

- (void)layoutPlayer:(id)frame
{
    
}

- (void)layoutHeadImage:(id)frames
{
    
}
-(void)layoutArticleImage:(id)frame
{
    
}
-(void)popTableImage:(id)frameAndImageData
{
    
}

- (void)didFinishLoad
{
    
}

- (void)bottomADImageClick:(id)val
{
    
}

- (void)headADImageClick:(id)val
{
    
}
@end
