//
//  ImageTableViewCell.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "NewsHomeModel.h"

@implementation ImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NewsHomeModel *)model{
    self.titleLable.text=model.title;
   
    self.bigImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgsrc]]];
    
   
    if ([model.source containsString:@"网易"]) {
         self.sourceLable.text=@"TMO";
    }
  
    self.replayCountLable.text=[NSString stringWithFormat:@"跟帖:%ld",  model.replyCount];
}
@end
