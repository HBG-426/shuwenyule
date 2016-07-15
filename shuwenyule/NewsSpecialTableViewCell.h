//
//  NewsSpecialTableViewCell.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsHomeModel.h"

@interface NewsSpecialTableViewCell : UITableViewCell
@property(nonatomic,strong)NewsHomeModel*model;
@property (strong, nonatomic) IBOutlet UIImageView *HeardView;

@property (strong, nonatomic) IBOutlet UILabel *headerTitle;

-(void)setModel:(NewsHomeModel *)model;
@end
