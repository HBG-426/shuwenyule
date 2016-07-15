//
//  NewsSpecialTableViewCell.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsSpecialTableViewCell.h"
#import "NewsSpecial.h"


@implementation NewsSpecialTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NewsHomeModel *)model{
    _model=model;
  
    self.HeardView.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgsrc]]];
    
    self.headerTitle.text=model.title;
    self.headerTitle.textColor=[UIColor whiteColor];
    NSLog(@"%@",self.headerTitle.text);
    
    
    
}
@end
