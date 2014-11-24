//
//  SPAWViewController.m
//  Sports
//
//  Created by sgl on 13-11-1.
//  Copyright (c) 2013年 sina.com. All rights reserved.
//

#import "SPAWViewController.h"
#import "OPArticleObject.h"
#import "OPUtility.h"

@interface SPAWViewController ()
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
}


- (void)loadArticle
{
    if (!self.urlParam) {
        return;
    }
    NSDictionary *paramDic = nil;
    //博客
    if ([self.typeParam isEqualToString:@"blog"]) {
        //        url = [NSString stringWithFormat:@"http://api.dp.sina.cn/interface/f/blog/article_read.php?articleid=%@&c=webnews&s=7f5a3b30",[self obtainBlogIdFromUrl:self.urlParam]];
        NSDictionary *paramDic = @{@"articleid":[self obtainBlogIdFromUrl:self.urlParam],@"c":@"webnews",@"s":@"7f5a3b30"};
        [self addRequest:[SPArticleDataRequest requestWithDelegate:self
                                                        parameters:paramDic
                                                        isUseCache:YES
                                                               URL:@"http://api.dp.sina.cn/interface/f/blog/article_read.php?"
                                                        requestTag:2]];
        
    }
    //新闻
    else
    {
        if ([self.urlParam hasPrefix:@"http://"]) {
            if ([self.urlParam hasPrefix:@"http://t.cn/"]) {
                paramDic = @{@"app_key": PlatFormAppKey,
                             @"short_url":self.urlParam,
                             @"format":@"json",
                             @"reservedtag":@"HDSlide,WeiboList",
                             @"fields":@"title,content,related_news,comment,video,images,short_title,weibo,pages,createdatetime,media"};
            }
            else
            {
                paramDic = @{@"app_key": PlatFormAppKey,
                             @"url":self.urlParam,
                             @"format":@"json",
                             @"reservedtag":@"HDSlide,WeiboList",
                             @"fields":@"title,content,related_news,comment,video,images,short_title,weibo,pages,createdatetime,media"};
            }
            self.liveURL = nil;
            self.isVideoArticle = NO;
        }
        else
        {
            NSString *artUrl = self.urlParam;
            artUrl = [artUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            self.liveURL = self.liveParam;
            if ([artUrl hasPrefix:@"http://t.cn"]) {
                paramDic = @{@"app_key": PlatFormAppKey,
                             @"short_url":self.urlParam,
                             @"format":@"json",
                             @"reservedtag":@"HDSlide,WeiboList",
                             @"fields":@"title,content,related_news,comment,video,images,short_title,weibo,pages,createdatetime,media"};
            }
            else {
                paramDic = @{@"app_key": PlatFormAppKey,
                             @"url":self.urlParam,
                             @"format":@"json",
                             @"reservedtag":@"HDSlide,WeiboList",
                             @"fields":@"title,content,related_news,comment,video,images,short_title,weibo,pages,createdatetime,media"};
            }
        }
        [self addRequest:[SPArticleDataRequest requestWithDelegate:self
                                                        parameters:paramDic
                                                        isUseCache:YES
                                                               URL:@"http://platform.sina.com.cn/news/news?"
                                                        requestTag:0]];
    }
}

- (void)loadSlide
{}
- (void)finished
{}
- (id)parseSilde:(NSString *)url
{
    return nil;
}
- (void)layoutArticle
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Article" ofType:@"html"];
    NSError *error = nil;
    NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    if (error) {
        NSLog(@"there is an error:%@",error);
        return;
    }
    NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    [self.webview loadHTMLString:html baseURL:baseUrl];
}
- (void)readyForData
{
    NSString *loadHandle = [NSString stringWithFormat:@"load(%@)",self.articleData];
    [self runJSFuncion:loadHandle];
}
- (void)layoutArticleFinished
{
//    self.webview.co
//    [self.webview sizeToFit];

    self.webview.scrollView.scrollEnabled = NO;
    self.webview.scrollView.bounces = NO;
    
    CGRect frame = self.webview.frame;
    frame.size.height = 1;
    self.webview.frame = frame;
    // Asks the view to calculate and return the size that best fits its subviews.
    CGSize fittingSize = [self.webview sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    self.webview.frame = frame;

    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.webview.frame), CGRectGetHeight(self.webview.frame));
    if (self.awViewControllerDelegate && [self.awViewControllerDelegate respondsToSelector:@selector(layoutArticleFinished:SPAWViewController:)]) {
        [self.awViewControllerDelegate layoutArticleFinished:self.webview SPAWViewController:self];
    }
}


#pragma mark - 网络请求相关
- (void)requestDidStartLoad:(BaseDataRequest*)request
{
    
}
- (void)requestDidFinishLoad:(BaseDataRequest*)request
{
    id data = request.resultDataDic;
    NSInteger tag = request.requestTag;
    if (tag == 1) {
        [self slideDataReady:data];
        return;
    }
    
    if (tag == 0) {
        
        NSString *code;
        NSDictionary *resultElement = [request.resultDataDic objectForKeyNotNull:@"result"];
        if (resultElement && [resultElement isKindOfClass:[NSDictionary class]]) {
            NSDictionary *statusElement = [resultElement objectForKeyNotNull:@"status"];
            if (statusElement && [statusElement isKindOfClass:[NSDictionary class]]) {
                code = [NSString stringWithFormat:@"%@",[statusElement objectForKeyNotNull:@"code"]] ;
            }
        }
        
        if(![code isEqualToString:@"0"])//没有返回数据
        {
            NSLog(@" 返回的code 不等于0");
//            [self addNodataView];
            return;
        }
        else
        {
//            [self removeNodataView];
        }
        
        
        
//        if ([self.lastReturnArticleData isEqualToString:[self MD5DigestFromString: [data JSONString]]]) {
//            return;
//        }
//        self.lastReturnArticleData = [self MD5DigestFromString: [data JSONString]]  ;
//        
//        self.articleDataLoaded = YES;
        //        OPLog(@"%@", data);
        
        
        id result = [data objectForKey:@"result"];
        if (result == nil) {
            // TODO: data err.
        }
        
        id status = [result objectForKey:@"status"];
        if ([[status objectForKey:@"code"] intValue] != 0) {
            // TODO: data err.
            //            OPLogErr(@"Err: %@", [status objectForKey:@"msg"]);
        }
        
        id artData = [result objectForKey:@"data"];
        //过滤首页图片
//        data = [self filterHeadImage:data];
        
        OPArticleObject *article = [[OPArticleObject alloc] init];
        // 不必考虑异常，block之外有异常处理
        id articleData = [artData safeObjectAtIndex:0];
        if (![articleData isKindOfClass:[NSDictionary class]]) {
            //            [NSException raise:@"OPDataTypeErr"
            //                        format:@"articleData should be a dictionary but it is a %@.", [articleData class]];
            NSLog(@"OPDataTypeErr articleData should be a dictionary but it is a %@",[articleData class]);
            return;
        }
        
        NSDictionary *property = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"title", @"media", @"content", @"related_news", @"createdatetime", @"video", @"images", @"url", @"reservedtag",nil]
                                                             forKeys:[NSArray arrayWithObjects:@"title", @"source", @"content", @"related", @"date", @"video", @"images", @"url", @"reservedtag",nil]];
        
        [OPUtility propertyFromDictionary:articleData forObject:article propertyDict:property];
        
        NSString *shortTitle = [articleData objectForKey:@"short_title"];
        if (shortTitle == nil || shortTitle.length == 0) {
            shortTitle = article.title;
        }
        
        article.shortTitle = shortTitle;
        article.time_length = [[articleData objectForKey:@"video"] objectForKey:@"length"];
        article.ads_flag = [[articleData objectForKey:@"video"] objectForKey:@"ads_flag"];
        article.cid = [[articleData objectForKeyNotNull:@"channel-id"] intValue];
        article.commentInfo = [OPArticleCommentInfo commentInfoWithDict:[articleData objectForKeyNotNull:@"comment"]];
        article.type = [OPArticleObject typeFromString:[articleData objectForKeyNotNull:@"content-type"]];
        article.reservedtag = [articleData objectForKey:@"reservedtag"];
        
        // 获取高清图集字段
        BOOL hasSlide = NO;
        id revTag = [articleData objectForKey:@"reservedtag"];
        if (revTag != nil) {
            id hdslide = [revTag objectForKey:@"HDSlide"];
            if (hdslide != nil && [hdslide count] > 0 ) {
                article.userInfo = @{@"HDSlide": hdslide};
                NSString *url = [hdslide safeObjectAtIndex:0];
                NSDictionary *data = [self parseSilde:url];
                if (data != nil) {
                    article.albumSID = [data objectForKey:@"sid"];
                    article.albumID = [data objectForKey:@"albumId"];
                    hasSlide = YES;
                }
            }
        }
        
//        self.article = article;
//        
//        [self makeVideoInfo];
        
        
        // 如果需要播放视频就增加视频信息
        if (self.isVideoArticle) {
            NSMutableDictionary *td = [NSMutableDictionary dictionaryWithDictionary:data];
//            [td setObject:self.videoInfo forKey:@"video_info"];
            self.articleData = [td JSONString];
        }
        else {
            self.articleData = [data JSONString];
        }
        //        [self.commentInputController updateComment:self.article.commentInfo];
        
        if (hasSlide) {
            [self loadSlide];
        }
        else {
            [self layoutArticle];
        }
//        [self addCommentTabelView];
        
        //        self.commentInputController.appendText = [NSString stringWithFormat:@"…《%@》%@（来自@新浪体育 客户端http://t.cn/zTMN6Hc）", article.title, article.url];
        
    }
    if (tag == 2) {
        //        [self removeHUD];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Blog" ofType:@"html"];
        NSError *error = nil;
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(@"there is an error:%@",error);
            return;
        }
        NSURL *baseUrl = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        [self.webview loadHTMLString:html baseURL:baseUrl];
        
        NSMutableDictionary *td = [NSMutableDictionary dictionaryWithDictionary:data];
        NSString *urlDecode = [self rawurldecode: [[td objectForKey:@"data"] objectForKey:@"blogbody"] ];
        [[td objectForKey:@"data"] setObject:urlDecode forKey:@"blogbody"];
        self.articleData = [td JSONString];
    }
    
    if (tag == 302) {
//        NSString *ids = [data objectForKey:@"id"];
//        NSString *weiboCardUrl = [NSString stringWithFormat:@"http://i.api.weibo.com/2/statuses/show.json?source=%@&id=%@",Login_APPVALUE,ids];
//        NSString *weiboCardHandle = [NSString stringWithFormat:@"AddWeiboCardByInterface(\"%@\",\"%@\")",weiboCardUrl,self.completeWeiboCardUrl];
//        [self runJSFuncion:weiboCardHandle];
    }
}
- (void)request:(BaseDataRequest*)request didFailLoadWithError:(NSError*)error
{
    
}


#pragma mark -博客相关
-(NSString *)obtainBlogIdFromUrl:(NSString*) url
{
    
    //二、博客正文内容请求接口
    //博客链接：http://blog.sina.com.cn/s/blog_541326620102e723.html
    //blog_ 后边 到 . (点） 的就是blogID
    //              请求
    //              http://api.dp.sina.cn/interface/f/blog/article_read.php?articleid={blogID}&c=webnews&s=7f5a3b30
    //              即可。
    
    //        http://blog.sina.com.cn/s/blog_541326620102e723.html
    
    NSRange preRange = [url rangeOfString:@"/blog_"];
    NSRange sufRange = [url rangeOfString:@".html"];
    if (preRange.location == NSNotFound || sufRange.location == NSNotFound) {
        return @"";
    }
    NSRange idRange = NSMakeRange(preRange.location+preRange.length,sufRange.location - preRange.location - preRange.length);
    return [url substringWithRange:idRange];
}

- (void)slideDataReady:(id)data
{
    id status = data[@"status"];
    if ([status[@"code"] intValue] != 0) {
        // TODO: 错误处理
        [self finished];
    }
    else {
        // TODO: 简化流程处理
        id album = data[@"album"];
        NSString *url = album[@"img_url"];
        NSData *data = [self.articleData dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (!error && json) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:json];
            [dict setObject:url forKey:@"slide_url"];
            self.articleData = [dict JSONString];
            [self layoutArticle];
            
        }else
        {
            NSLog(@"error:%@",error);
        }
        
    }
}

-(NSString *) rawurldecode:(NSString *)rawdata
{
    if(rawdata == nil) return @"";
    NSString *output = [rawdata stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return (output == nil)?@"":output;
}


@end
