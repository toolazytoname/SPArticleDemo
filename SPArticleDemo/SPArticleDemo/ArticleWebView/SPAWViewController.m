//
//  SPAWViewController.m
//  Sports
//
//  Created by sgl on 13-11-1.
//  Copyright (c) 2013年 sina.com. All rights reserved.
//

#import "SPAWViewController.h"
#import "SPAWViewController+ArticleData.h"

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




@end
