//
//  NewsMoreDetialTableViewCell.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsMoreDetialTableViewCell.h"
#import "NewsHomeModel.h"

@implementation NewsMoreDetialTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(NewsHomeModel *)model{
    
    _model=model;
    
    NSMutableArray*array=[NSMutableArray array];
    for (NSDictionary*dic in model.imgextra) {
        NSString*modelStr=dic[@"imgsrc"];
        [array addObject:modelStr];
    }
    
    
    self.lefImagev.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgsrc]]];
    
    self.midlImagev.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:array[0]]]];
    
    self.rightImagev.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:array[1]]]];
    
    
    if ([model.source containsString:@"网易"]) {
        self.souceLable.text=@"TMO";
    }else{
        
        self.souceLable.text=model.source;

        
    }
   
    self.replyCountLabel.text=[NSString stringWithFormat:@"跟帖:%.2f", 1.0*model.replyCount/10000];
    
    
}
@end
