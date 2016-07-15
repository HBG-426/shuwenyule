//
//  NewsMoreDetialTableViewCell.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsHomeModel;

@interface NewsMoreDetialTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *lefImagev;

@property (strong, nonatomic) IBOutlet UIImageView *midlImagev;
@property (strong, nonatomic) IBOutlet UIImageView *rightImagev;
@property (strong, nonatomic) IBOutlet UILabel *souceLable;
@property (strong, nonatomic) IBOutlet UILabel *replyCountLabel;
@property(nonatomic,strong)NewsHomeModel*model;

-(void)setModel:(NewsHomeModel *)model;
@end
