//
//  NewsHomeModel.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsHomeModel.h"

@implementation NewsHomeModel
+(instancetype)analysisDataWithDict:(NSDictionary*)Dict{
    NewsHomeModel*model=[[NewsHomeModel alloc]init];
    
    [model setValuesForKeysWithDictionary:Dict];
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
  
    
    
}
@end
