//
//  NewsSpecial.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsSpecial.h"

@implementation NewsSpecial
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
    
}

+(instancetype)SpecislanalysisDataWithDict:(NSDictionary*)Dict{
    NewsSpecial*special=[[NewsSpecial alloc]init];
    
    [special setValuesForKeysWithDictionary:Dict];
    
    
    return special;
    
    
    
    
}
@end
