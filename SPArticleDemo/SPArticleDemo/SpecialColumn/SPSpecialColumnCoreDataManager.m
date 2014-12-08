//
//  SPSpecialColumnCoreDataManager.m
//  SPArticleDemo
//
//  Created by SINA on 14/12/8.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import "SPSpecialColumnCoreDataManager.h"
#import "SPSpecialColumnModule.h"
#import <CoreData/CoreData.h>
#import "SPCoreDataManage.h"

@implementation SPSpecialColumnCoreDataManager
+(id)shareInstance
{
    static SPSpecialColumnCoreDataManager *specialColumnCoreDataManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        specialColumnCoreDataManager = [[SPSpecialColumnCoreDataManager alloc] init];
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
        if ([item isKindOfClass:[SPSpecialColumnModule class]]) {
            SPSpecialColumnModule *specialColumn = (SPSpecialColumnModule *)item;
            NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"SpecialColumn" inManagedObjectContext:context];
            [managedObject setValue:specialColumn.title forKey:@"title"];
            [managedObject setValue:specialColumn.pic forKey:@"pic"];
            [managedObject setValue:specialColumn.desc forKey:@"desc"];
        }
    }
    [context save:nil];
}
/**
 *  编辑update,如果通过feedId找不到，新增一条记录
 *
 *  @param specialColumn <#specialColumn description#>
 */
-(void)updateSpecialColumn:(SPSpecialColumnModule *)specialColumn
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


-(void)deleteSpecialColumn:(SPSpecialColumnModule *)specialColumn
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

-(NSArray *)getAll
{
    NSManagedObjectContext *context = [[SPCoreDataManage shareInstance] appDataContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescr = [NSEntityDescription entityForName:@"SpecialColumn" inManagedObjectContext:context];
    [request setEntity:entityDescr];
    
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request error:&error];
    if (objects == nil) {
        //handle error
    }
    NSLog(@"pic:%@", [[objects objectAtIndex:0] valueForKey:@"pic"]);
   ;
    return objects;
    

}


@end
