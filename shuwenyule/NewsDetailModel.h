//
//  NewsDetailModel.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsDetailModel : NSObject
@property(nonatomic,strong)NSString*imgurl;



@property (nonatomic , copy) NSString *url;
@property(nonatomic,strong)NSString*setname;
@property(nonatomic,strong)NSString*note;

@property (nonatomic , copy) NSString *title;

@property (nonatomic , copy) NSString *imgtitle;

+(instancetype)DetialWithDict:(NSMutableDictionary*)dict;
@end
