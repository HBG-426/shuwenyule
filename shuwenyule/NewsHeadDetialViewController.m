//
//  NewsHeadDetialViewController.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/14.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsHeadDetialViewController.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "NewsDetailModel.h"
#import "UIImageView+WebCache.h"

@interface NewsHeadDetialViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView*scrollView;
@property(nonatomic,strong)UILabel*replayCount;
@property(nonatomic,strong)UILabel*topLable;
@property(nonatomic,strong)UILabel*DetialLabel;
@property(nonatomic,strong)UILabel*imageCount;
@property(nonatomic,strong)NSMutableArray*DataArray;
@property(nonatomic,assign)NSInteger count;
@property(nonatomic,copy)NSString*setname;
@property(nonatomic,strong)NSMutableArray*PhotoArray;
@property(nonatomic,strong)NSMutableArray*noteArray;
@property(nonatomic,strong)NSMutableArray*titleArray;
@property(nonatomic,strong)UILabel*titleLabel;
@property(nonatomic,strong)UILabel *countLabel ;
@property(nonatomic,strong) UITextView *textview;
@property(nonatomic,strong)UIToolbar*tool;

;
@property(nonatomic,strong)UIImageView*imagev;
@end

@implementation NewsHeadDetialViewController





#pragma mark---------懒加载--------

-(NSMutableArray *)DataArray{
    if (!_DataArray) {
        _DataArray=[NSMutableArray array];
        
    }
    
    return _DataArray;
    
}



#pragma mark-----视图将要出现的时候隐藏topBar-------


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
    
    self.navigationController.navigationBarHidden=YES;
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self SetUpSubViews];
    
    self.scrollView.delegate=self;
    
    [self setUpData];



}

#pragma mark------请求数据------------

-(void)setUpData{
    

        //配置url
    
       NSString*str=[self.pragma substringFromIndex:4];
    
       NSString*urlgam=[str stringByReplacingOccurrencesOfString:@"|" withString:@"/"];
 
       NSString*url=[NSString stringWithFormat:@"http://c.3g.163.com/photo/api/set/%@.json",urlgam];
    
        //网络请求
       [[AFHTTPSessionManager manager]GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.count=[responseObject[@"imgsum"]intValue];
        
        NSArray*Array=responseObject[@"photos"];
        
        self.setname = responseObject[@"setname"];
       
        for (NSMutableDictionary*dict in Array) {
            NewsDetailModel*model=[NewsDetailModel DetialWithDict:dict];
            [self.DataArray addObject:model];
            
            [self.PhotoArray addObject:model.imgurl];
            
            [self.noteArray addObject:model.note];
  }
           

        //刷新界面

        [self setUpImage];
           
        [self SetUpLable];
           
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
}


#pragma mark------配置子视图及控件----------
-(void)SetUpSubViews{
    
    
    
    //蒙版背景配置
    
    UIToolbar*tool=[[UIToolbar alloc]initWithFrame:self.view.bounds];
    
    [self.view addSubview:tool];
    
    self.tool=tool;
    
    
    
    
    //添加scrollView

    self.scrollView=[[UIScrollView alloc]init];
    
    [self.tool  addSubview:self.scrollView];
    
    self.tool.barStyle=UIBarStyleBlackOpaque;
 
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        
        make.top.mas_equalTo(self.view.mas_top).offset(150);
        
        make.bottom.mas_equalTo(self.view.mas_bottom).offset(-200);
      }];
    
    
    
    
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]init];
    
    titleLabel.frame = CGRectMake(5, self.view.frame.size.height - 70 - 49, self.view.frame.size.width - 55, 20);
    
    titleLabel.textColor = [UIColor whiteColor];
    
    titleLabel.font = [UIFont boldSystemFontOfSize:19];
    
    [self.tool addSubview:titleLabel];
    
    self.titleLabel = titleLabel;
    
    
    
    //数量
     UILabel *countLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame)+5, titleLabel.frame.origin.y, 50, 15)];
    
     countLabel.textColor = [UIColor whiteColor];
    
        countLabel.text = @"00/00";
    
     [self.tool addSubview:countLabel];
    
     self.countLabel = countLabel;
    

    
    //添加button
    
    UIButton*button=[UIButton buttonWithType:(UIButtonTypeCustom)];
    
    [self.tool addSubview:button];
    
    button.backgroundColor=[UIColor redColor];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tool.mas_left).offset(10);
        
        make.top.mas_equalTo(self.tool.mas_left).offset(49);
        
        make.width.mas_equalTo(50);
        
        make.height.mas_equalTo(50);
        
    }];
    
    [button addTarget:self action:@selector(ReturnBack:)
          forControlEvents:(UIControlEventTouchUpInside)];
    
    //内容
    UITextView *textview = [[UITextView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(titleLabel.frame), self.view.frame.size.width - 15, 60)];
    
    textview.editable = NO;
    
    textview.font = [UIFont systemFontOfSize:14];
    
    textview.textAlignment = NSTextAlignmentLeft;
    
    textview.textColor = [UIColor whiteColor];
    
    textview.backgroundColor = [UIColor clearColor];
    
    textview.textColor = [UIColor whiteColor];
    
    [self.tool addSubview:textview];
    
    self.textview = textview;
    
}


#pragma mark--------添加内容-----------


/** 添加内容 */
- (void)setContentWithIndex:(int)index
{
    NSString *content = [self.DataArray[index] note];
    
    NSString *contentTitle = [self.DataArray[index] imgtitle];
    
    if (content.length != 0) {
        self.textview.text = content;
        
    }else{
        
        self.textview.text = contentTitle;
        
    }
}

#pragma mark---------往scrollerview上面添加imageview并添加图片------------


 //添加imageview
-(void)setUpImage{
    
         NSUInteger count = self.count;
    
        for (int i = 0; i < count; i++) {
        
        CGFloat imageH = self.scrollView.frame.size.height - 100;
            
        CGFloat imageW = self.scrollView.frame.size.width;
            
        CGFloat imageY = 0;
            
        CGFloat imageX = i * imageW;
            
        self.imagev = [[UIImageView alloc]initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
            
        [self.imagev sd_setImageWithURL:[NSURL URLWithString:[self.DataArray[i] imgurl]]];
             
        // 图片的显示格式为合适大小
            
        self.imagev.contentMode= UIViewContentModeScaleToFill;
            
//        self.imagev.contentMode= UIViewContentModeScaleAspectFit;
            
        [self.scrollView addSubview:self.imagev];
            
            
    }
       self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * count, 0);
    
       self.scrollView.showsHorizontalScrollIndicator = NO;
    
       self.scrollView.showsVerticalScrollIndicator = NO;
    
       self.scrollView.pagingEnabled = YES;
}



#pragma mark-----设置标题lable------------
-(void)SetUpLable{
    
    
    
    //标题
    self.titleLabel.text = self.setname;
    //数量
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",self.count];
    self.countLabel.text = countNum;
    //内容
    [self setContentWithIndex:0];
}



#pragma mark--------调用scrollerview的代理方法进行消息通知-------------


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    
    
    int index = self.scrollView.contentOffset.x / self.scrollView.frame.size.width;
    
    NSLog(@"%d",index);
  
    NSString *countNum = [NSString stringWithFormat:@"%d/%ld",index+1,self.count];
    
    
       self.countLabel.text = countNum;
    
    
    
   [ self.countLabel setFont:[UIFont systemFontOfSize:14]];
  
    // 添加内容
    [self setContentWithIndex:index];
    

    
}




#pragma mark------设置返回button------------
-(void)ReturnBack:(UIButton*)sender{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
}



#pragma mark-------页面即将消失的时候调用方法让topBar展现出来---------


-(void)viewWillDisappear:(BOOL)animated{
    
    
    
    [super viewWillDisappear:YES];
    
    self.navigationController.navigationBarHidden=NO;
    
    
    
}
@end
