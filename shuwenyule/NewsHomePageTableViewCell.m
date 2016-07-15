//
//  NewsHomePageTableViewCell.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsHomePageTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "NewsHomeModel.h"

@implementation NewsHomePageTableViewCell

- (void)awakeFromNib {
    self.replyCount.layer.masksToBounds=YES;
    self.replyCount.layer.cornerRadius=5;
//    self.replyCount.font=[UIFont systemFontOfSize:12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NewsHomeModel *)model{
    
    _model=model;
    
    
    
    
    [self.NewsHomeLefImagev sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    self.title.text=model.ltitle;

   
   //判断数据来源是不是“网易相关”
    if ([model.source containsString:@"网易"]||[model.source isEqualToString:@"网易娱乐"]) {
        self.source.text=@"TMO";
    }else{
        
        
        self.source.text=model.source;
        
    }
    
    
    
    if (model.skipID) {
        
        
        
        self.replyCount.text=@"专 题";
        self.replyCount.backgroundColor=[UIColor redColor];
        
        
        return;
        
    }else if(!model.skipID){
        
        
    CGFloat m=1.0*model.replyCount/10000;
        
    self.replyCount.text=[NSString stringWithFormat:@"跟帖:%.2f万",m];
        
    self.replyCount.backgroundColor=[UIColor darkGrayColor];
    }
   
    
}
@end
