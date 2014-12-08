//
//  SPCoreDataManage.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/8.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPCoreDataManage.h"


@implementation SPCoreDataManage
@synthesize appDataContext = _appDataContext;


+(id)shareInstance
{
    static SPCoreDataManage* _coreDataManage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _coreDataManage = [[SPCoreDataManage alloc]init];
    });
    return _coreDataManage;
}
-(NSManagedObjectContext * ) appDataContext
{
    if(_appDataContext == nil)
    {
        
        NSString * documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        NSFileManager * fileManager =[NSFileManager defaultManager];
        
        _appDataContext = [[NSManagedObjectContext alloc] init];
        
        NSBundle * bundle = [NSBundle mainBundle];
        
        NSManagedObjectModel * model = [[NSManagedObjectModel alloc] initWithContentsOfURL:[NSURL fileURLWithPath: [bundle pathForResource:@"AppDataModel" ofType:@"momd"]]];
        
        NSPersistentStoreCoordinator * coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
//        [model release];
        
        NSURL * sqliteUrl = [NSURL fileURLWithPath:[documents stringByAppendingPathComponent:@"AppData.sqlite"]];
        
        NSError * error = nil;
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                                 [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
        
        if(![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteUrl options:options error:&error]){
            
            [fileManager removeItemAtURL:sqliteUrl error:nil];
            
            if(![coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:sqliteUrl options:options error:&error]){
                
                NSLog(@"%@ %@",error,[error localizedDescription]);
                abort();
            }
        }
        
        [_appDataContext setPersistentStoreCoordinator:coordinator];
        
//        [coordinator release];
        
    }
    
    return _appDataContext;
}


@end
