//
//  SPSpecialColumnCoreDataManager.m
//  SPArticleDemo
//
/*
一.专栏
1.专栏无论是登录用户还是非登录用户都可以订阅
2.非登录用户订阅时调用订阅计数接口增加订阅数，但订阅信息存在本地
3.登录用户订阅时调用订阅接口，登录用户的订阅信息存在后台，同时本地也要存一份
4.非登录用户的订阅列表上会有引导用户登录的提示，如果用户登录，则将本地存储的订阅信息同步給后台
5.如果原登录用户退出登录，显示本地存储的订阅信息，如果用户再次登录（包括更换其他账号）时讲本地存储的订阅信息同步给后台
6.如果本地没有订阅信息，且用户已登录，请求后台订阅信息显示并存在本地
7.多账号切换时按照5中的逻辑走
8.用户点击某个专栏后本地记录下时间戳，待下次请求已订阅专栏列表时将专栏对应的时间戳送给后台，后台通过时间戳来计算专栏未读数
9.通过本地存储的订阅信息来判断显示是否订阅该专栏
10.请求推荐专栏时如果有本地订阅信息则把本地订阅信息带上，后台好过滤已经订阅的专栏

专栏列表测试接口：
http://platform.sina.com.cn/sports_client/z_list?app_key=2586208540
title 为专栏title
desc 为专栏描述
fans_num 订阅数
pic 专栏头像
feed_id 取专栏详情列表时用的ID



一.专栏接口
优先级：P1
1.徐焱提供专栏订阅/取消订阅接口，客户端送微博token供鉴权使用；
2.用户订阅专栏列表接口由亮亮提供，如果是登录用户，从徐焱处取用户订阅信息，如果是非登录用户，客户端送用户订阅信息；
3.徐焱提供指定专栏feed接口
4.热门推荐专栏列表接口由亮亮提供，过滤掉用户已订阅专栏，如果是登录用户从徐焱处取，非登录用户客户端送；
5.所有专栏列表接口由亮亮提供，根据CMS 吴强健提供的专栏配置接口来渲染；
6.徐焱提供订阅计数接口供非登录用户订阅/取消订阅时调用
7.如果用户没有登录，订阅栏目存在本地，如果登录，存在徐焱处，用户如果刚开始未登录，订阅完后再登录，则客户端将已订阅信息同步给徐焱
8.客户端送时间戳，亮亮根据时间戳从徐焱处取得专栏自时间戳之后的新增文章数
*/
//  Created by SINA on 14/12/8.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnUtil.h"
#import "SPSpecialColumnModel.h"
#import <CoreData/CoreData.h>
#import "SPCoreDataManage.h"
#import "SpecialColumn.h"
#import "SPBaseDataRequest.h"
#import "SPDataRequest.h"


@interface SPSpecialColumnUtil()<DataRequestDelegate>
/**
 *  请求队列
 */
@property (nonatomic, retain) NSMutableArray *requestQueue;

@end
@implementation SPSpecialColumnUtil
+(id)shareInstance
{
    static SPSpecialColumnUtil *specialColumnCoreDataManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        specialColumnCoreDataManager = [[SPSpecialColumnUtil alloc] init];
    });
    return specialColumnCoreDataManager;
}




/**
 *  增加add
 *
 *  @param SpecialColumnArray <#SpecialColumnArray description#>
 */
-(void)addSpecialColumnList:(NSArray *)specialColumnArray
{
    if (!specialColumnArray || specialColumnArray.count == 0) {
        return;
    }
    NSManagedObjectContext *context = [[SPCoreDataManage shareInstance] appDataContext];
    for(id item in specialColumnArray)
    {
        if ([item isKindOfClass:[SPSpecialColumnModel class]]) {
            SPSpecialColumnModel *specialColumn = (SPSpecialColumnModel *)item;
            NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"SpecialColumn" inManagedObjectContext:context];
            [managedObject setValue:specialColumn.title forKey:@"title"];
            [managedObject setValue:specialColumn.pic forKey:@"pic"];
            [managedObject setValue:specialColumn.desc forKey:@"desc"];
            [managedObject setValue:specialColumn.feedId forKey:@"feedId"];
            [managedObject setValue:specialColumn.stitle forKey:@"stitle"];
        }
    }
    [context save:nil];
}
/**
 *  编辑update,如果通过feedId找不到，新增一条记录
 *
 *  @param specialColumn <#specialColumn description#>
 */
-(void)updateSpecialColumn:(SPSpecialColumnModel *)specialColumn
{
    NSManagedObjectContext *context = [[SPCoreDataManage shareInstance] appDataContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescr = [NSEntityDescription entityForName:@"SpecialColumn" inManagedObjectContext:context];
    [request setEntity:entityDescr];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(feedId = %@)",specialColumn.feedId];
    [request setPredicate:pred];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        //handle error
    }
    
    NSManagedObject *managedObject = nil;
    if ([objects count] > 0) {
        managedObject = [objects objectAtIndex:0];
    }
    else{
        managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"SpecialColumn" inManagedObjectContext:context];
    }
    [managedObject setValue:specialColumn.title forKey:@"title"];
    [managedObject setValue:specialColumn.pic forKey:@"pic"];
    [managedObject setValue:specialColumn.desc forKey:@"desc"];
    
    [context save:nil];
}


-(void)deleteSpecialColumn:(SPSpecialColumnModel *)specialColumn
{
    NSManagedObjectContext *context = [[SPCoreDataManage shareInstance] appDataContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescr = [NSEntityDescription entityForName:@"SpecialColumn" inManagedObjectContext:context];
    [request setEntity:entityDescr];
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"(feedId = %@)",specialColumn.feedId];
    [request setPredicate:pred];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        //handle error
    }
    
    NSManagedObject *managedObject = nil;
    if ([objects count] > 0) {
        managedObject = [objects objectAtIndex:0];
        [context deleteObject:managedObject];
    }
    [context save:nil];
}






-(void)viewDidLoad
{
    //显示本地数据
    
    if(self.isLoggedIn)
    {
//       请求
    
    }
    else
    {
        
    }

}
/**
 *  订阅
 */
-(void)subscribe:(SPSpecialColumnModel *)specialColumnModel
{
    if(self.isLoggedIn)
    {
        //调用订阅接口
        //本地也要存一份
        [self requestSubScribe:specialColumnModel];
    }
    else
    {
        //非登录用户
        //调用订阅计数接口
        [self requestSubScribeCount:specialColumnModel];
    }
    //订阅信息存在本地
    [self saveSpecialColumnLocal:specialColumnModel];
}
/**
 *  登录成功后
 if (本地没有订阅信息) {
 请求后台订阅信息显示并存在本地
 }
 else
 {
 则将本地存储的订阅信息同步給后台
 }
 */
-(void)logIn
{
    NSArray *specialColumnArray = [self SpecialColumnLocal];
    //本地没有订阅信息
    if (!specialColumnArray || 0 == specialColumnArray.count) {
        [self requestSubscribeAndSaveLocal];
    }
    else
    {
        [self syncLocalToServer];
    }
    
}

-(void)SpecialColumnClick:(SPSpecialColumnModel *)specialColumnModel
{
    //用户点击某个专栏后本地记录下时间戳，待下次请求已订阅专栏列表时将专栏对应的时间戳送给后台，后台通过时间戳来计算专栏未读数
    
    //存储，每个专栏 对应的一个时间戳
    //获取系统当前的时间戳
    NSDate* date = [NSDate date];
//    NSTimeInterval interval=[date timeIntervalSince1970]*1000;
//    NSString *timeStamp = [NSString stringWithFormat:@"%f", interval];//转为字符型
    [self saveSpecialColumnTimeStamp:specialColumnModel currentDate:date];
}

/**
 *  请求推荐专栏
 */
-(void)requestrecommendList
{
    
    if (self.isLoggedIn && ![self isSyncLocalToServerSuccess]) {
        [self syncLocalToServer];
    }
    else
    {
//      requtst
        NSString *weiboToken = self.weiboToken;
        NSArray *specialColumnArray = [self SpecialColumnLocal];
        //请求推荐专栏:(本地订阅信息 ，专栏列表+时间戳) 方便后台过滤
        NSArray *specialColumnLocal = [self SpecialColumnLocal];
        for (SpecialColumn *element in specialColumnLocal) {
            //        element.clickTime
            element.feedId;
            //TODO:请求推荐专栏
        }

    }
    
    
}
/**
 *  该专栏是否是已订阅的专栏
 *
 *  @param specialColumn 带判断专栏
 *
 *  @return YES：已订阅专栏 ;NO: 未订阅的专栏
 */
-(BOOL)isSubscribed:(SPSpecialColumnModel *)specialColumn
{
    //9.通过本地存储的订阅信息来判断显示是否订阅该专栏
    BOOL isSubscribed = NO;
    NSArray *feedsArray = [self specialColumnfeedIdArray];
    if (specialColumn && specialColumn.feedId ) {
       isSubscribed = [feedsArray containsObject:specialColumn];
    }
    return isSubscribed;
}

/**
 *  同步本地数据到服务器
 */
-(void)syncLocalToServer
{
    //token
    //列表
    NSString *tokenString = self.token;
    NSArray *feedsArray = [self specialColumnfeedIdArray];
    NSString *feedsString = [feedsArray componentsJoinedByString:@","];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:tokenString, @"token",feedsString,@"feedsArray",nil];
    [self addRequest:[SPSpecialColumnSyncLocalToServerDataRequest  requestWithDelegate:self parameters:param isUseCache:YES]];
}
#pragma mark - helper
/**
 *  获取本地存储的订阅列表的feedId数组
 *
 *  @return 获取本地存储的订阅列表的feedId数组
 */
-(NSArray *)specialColumnfeedIdArray
{
    NSArray *specialColumnArray = [self SpecialColumnLocal];
    NSArray *feedIdArray = [specialColumnArray valueForKey:@"feedId"];
    return feedIdArray;
}

#pragma mark - CoreData
/**
 *  返回本地存储的订阅列表，里面的元素为SpecialColumn
 *
 *  @return SpecialColumn Array
 */
-(NSArray *)SpecialColumnLocal
{
    NSManagedObjectContext *context = [[SPCoreDataManage shareInstance] appDataContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescr = [NSEntityDescription entityForName:@"SpecialColumn" inManagedObjectContext:context];
    [request setEntity:entityDescr];
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"error:%@",error);
    }
    return objects;
}

-(void)SyncServerToLocal:(NSArray *)SpecialColumnLocalArray
{
    //TODO:删除本地数据，然后逐行插入 SpecialColumnLocalArray
}
-(void)saveSpecialColumnLocal:(SPSpecialColumnModel *)specialColumnModel
{
    //TODO:保存这条记录到本地
}
/**
 *  订阅列表同步到服务器是否成功
 *
 *  @return 订阅列表同步到服务器是否成功
 */
-(BOOL)isSyncLocalToServerSuccess
{//is
    //TODO:订阅列表同步到服务器是否成功,
    //如果已登录，  根据当前微博id查询记录，如果true 则为成功，否则均为失败
    return YES;
}
/**
 *  保存专栏时间戳到对应的订阅记录
 *
 *  @param specialColumn 该专栏model
 *  @param date          时间戳
 *
 *  @return 是否保存成功
 */
-(BOOL)saveSpecialColumnTimeStamp:(SPSpecialColumnModel *)specialColumn currentDate:(NSDate *)date
{
    //TODO:保存时间戳 数据到 对应的订阅专栏记录
    return NO;
}
/**
 *  保存同步到服务器的结果
 *
 *  @param userId    用户id
 *  @param isSuccess 是否同步成功的结果
 *
 *  @return 是否保存成功
 */
-(BOOL)saveSyncLocalToServerResult:(NSString *)userId isSuccess:(NSNumber *)isSuccess
{
    //TODO:保存同步到服务器的结果
    return NO;
}
#pragma mark - 网络请求
/**
 *  获取专栏管理列表
 */
-(void)requestManagerList
{
    [self addRequest:[SPManagerSpecialColumnDataRequest requestWithDelegate:self parameters:nil isUseCache:YES]];
}
-(void)requestSubscribeList
{
    [self addRequest:[SPSubscribeSpecialColumnDataRequest requestWithDelegate:self parameters:nil isUseCache:YES requestTag:1]];
}
-(void)requestSubscribeAndSaveLocal
{
    [self addRequest:[SPSubscribeSpecialColumnDataRequest requestWithDelegate:self parameters:nil isUseCache:YES requestTag:2]];
}
-(void)requestRecommendList
{
    [self addRequest:[SPRecommendSpecialColumnDataRequest requestWithDelegate:self parameters:nil isUseCache:YES]];
}
-(void)requestSubScribe:(SPSpecialColumnModel *)specialColumnModel
{
    [self addRequest:[SPSubscribeSpecialColumnActionRequest requestWithDelegate:self parameters:nil isUseCache:YES]];
}
-(void)requestSubScribeCount:(SPSpecialColumnModel *)specialColumnModel
{
    [self addRequest:[SPSubscribeSpecialColumnActionRequest requestWithDelegate:self parameters:nil isUseCache:YES]];
}
/**
 *  请求网络数据
 *
 *  @param request request
 */
-(void)addRequest:(BaseDataRequest *)request
{
    if (request && [request isKindOfClass:[BaseDataRequest class]])
    {
        if (!self.requestQueue) {
            NSLog(@"self.requestQueue 为 nil");
        }
        [self.requestQueue addObject:request];
    }
}
/**
 *  取消网络请求
 */
- (void) cancelAllRequests
{
    [self.requestQueue makeObjectsPerformSelector:@selector(cancel)];
    [self.requestQueue removeAllObjects];
}
- (void)requestDidStartLoad:(BaseDataRequest*)request
{}
- (void)requestDidFinishLoad:(BaseDataRequest*)request
{
    if ([request isKindOfClass:[SPSpecialColumnSyncLocalToServerDataRequest class]]) {
        NSNumber *isSuccess = (NSNumber *)[request.resultDataDic objectForKeyNotNull:SPSpecialColumnSyncLocalToServerKey];
        if (self.isLoggedIn){
            [self saveSyncLocalToServerResult:self.userId isSuccess:isSuccess];
        }
    }
    if ([request isKindOfClass:[SPManagerSpecialColumnDataRequest class]]) {
        NSArray *list = [request.resultDataDic objectForKeyNotNull:SPManagerSpecialColumnKey];
        
    }
    if ([request isKindOfClass:[SPSubscribeSpecialColumnDataRequest class]]) {
        if (1 == request.requestTag) {
            NSArray *list = [request.resultDataDic objectForKeyNotNull:SPSubscribeSpecialColumnKey];
        }
        else if(2 == request.requestTag){
            NSArray *list = [request.resultDataDic objectForKeyNotNull:SPSubscribeSpecialColumnKey];
            [self SyncServerToLocal:list];
        }
    }


}
- (void)request:(BaseDataRequest*)request didFailLoadWithError:(NSError*)error
{}

@end
