//
//  NewsHomePageTableViewCell.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsHomeModel;

@interface NewsHomePageTableViewCell : UITableViewCell
@property(nonatomic,strong)NewsHomeModel*model;
@property (strong, nonatomic) IBOutlet UIImageView *NewsHomeLefImagev;

@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *source;
@property (strong, nonatomic) IBOutlet UILabel *replyCount;

-(void)setModel:(NewsHomeModel *)model;
@end
