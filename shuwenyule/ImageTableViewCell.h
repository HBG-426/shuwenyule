//
//  ImageTableViewCell.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NewsHomeModel;

@interface ImageTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (strong, nonatomic) IBOutlet UIImageView *bigImage;
@property (strong, nonatomic) IBOutlet UILabel *sourceLable;
@property (strong, nonatomic) IBOutlet UILabel *replayCountLable;
@property(nonatomic,strong)NewsHomeModel*model;

-(void)setModel:(NewsHomeModel *)model;

@end
