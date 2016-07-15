//
//  NewsHomeModel.h
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsHomeModel : NSObject

//详情页面参数
@property(nonatomic,copy)NSString*postid;
//跟帖人数
@property(nonatomic,assign)NSInteger replyCount;

//标题
@property(nonatomic,copy)NSString*ltitle;

//图片

@property(nonatomic,copy)NSString*imgsrc;

///跳往专题页面的标识符

@property(nonatomic,copy)NSString*skipID;


// 新闻来源

@property(nonatomic,copy)NSString*source;

//新闻专题(special是专题  photoset是头视图)
@property(nonatomic,copy)NSString*skipType;

//
@property(nonatomic,copy)NSString*title;

@property(nonatomic,strong)NSMutableArray*imgextra;


@property(nonatomic,copy)NSNumber*imgType;
@property(nonatomic,strong)NSNumber*hasHead;
@property(nonatomic,strong)NSString*photosetID;


+(instancetype)analysisDataWithDict:(NSDictionary*)Dict;
@end
