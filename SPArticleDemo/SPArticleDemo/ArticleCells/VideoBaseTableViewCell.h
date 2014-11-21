//
//  VideoBaseTableViewCell.h
//  SPArticleDemo
//
//  Created by SINA on 14/11/19.
//  Copyright (c) 2014年 Sport. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoBaseTableViewCell : UITableViewCell
-(void)updateCellWithModel:(id)model;
-(id)initWithFrame:(CGRect)frame;
-(CGFloat)cellHeight;
@end
