//
//  SPArtWebViewController.h
//  ArticleShow
//
//  Created by sgl on 13-11-1.
//  Copyright (c) 2013年 sgl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#define kSPWebActionPlayVideo @"playvideo"
#define kSPWebActionShowAlbum @"showalbum"
#define kSPWebActionShowImage @"showimage"
#define kSPWebActionCustom    @"custom"
#define kSPWebActionReady     @"ready"

#define kSPWebActionLayoutPlayer   @"layoutplayer"
#define kSPWebActionLayoutFinished @"layoutfinished"

#define kSPWebActionLayoutHeadImage  @"layoutheadimage"

#define kSPWebActionLayoutArticleImage @"layoutarticleimage"
#define kSPWebActionPopTableImage  @"poptableimage"
#define kSPWebActionBottomADImageClick  @"bottomadimageclick"
#define kSPWebActionHeadADImageClick @"headadimageclick"





@interface SPArtWebViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, strong) NSString *templateFile;
@property (strong, nonatomic) IBOutlet UIWebView *webview;

- (NSString *)runJSFuncion:(NSString *)func;

- (BOOL)shouldStartLoadWithRequest:(NSURLRequest *)req navigationType:(UIWebViewNavigationType)navigationType;
- (void)readyForData;
- (void)layoutArticleFinished;
- (void)playVideo:(id)video;
- (void)showAlbum:(id)album;
- (void)showImage:(id)image;
- (void)customAction:(id)action;
- (void)layoutPlayer:(id)frame;
- (void)didFinishLoad;

@end
