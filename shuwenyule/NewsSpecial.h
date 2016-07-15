//
//  NewsSpecial.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsSpecial : NSObject
@property(nonatomic,copy)NSString*title;
@property(nonatomic,copy)NSString*digest;



@property(nonatomic,copy)NSString*imgsrc;
+(instancetype)SpecislanalysisDataWithDict:(NSDictionary*)Dict;
@end
