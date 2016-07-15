//
//  NewsDetailModel.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}

+(instancetype)DetialWithDict:(NSMutableDictionary*)dict{
    NewsDetailModel*model=[[NewsDetailModel alloc]init];
    [model setValuesForKeysWithDictionary:dict];
    
       return model;
 }
@end
