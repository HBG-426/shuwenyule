//
//  NewsSecondViewController.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsSecondViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "GDataXMLNode.h"
#import "Masonry.h"
#import "NewsHomeModel.h"
#import "NewsSpecial.h"
#import "NewsHomePageTableViewCell.h"
#import "NewsMoreDetialTableViewCell.h"
#import "MJRefresh.h"

@interface NewsSecondViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *NewsSecondTableView;

@property(nonatomic,strong)NSMutableArray*SpecialDataArray;

@property(nonatomic,strong)UIView*specialheadView;

@property(nonatomic,strong) UIImageView*topImagev;

@property(nonatomic,strong)UILabel*titleLable;

@property(nonatomic,strong)UILabel*titleSubLable;
@property(nonatomic,strong)NSMutableArray*totalArray;

@property(nonatomic,assign)CGFloat Rowheight;

@end

@implementation NewsSecondViewController







#pragma mark-----懒加载----------


-(NSMutableArray *)SpecialDataArray{
    if (!_SpecialDataArray) {
        _SpecialDataArray=[NSMutableArray array];
    }
    
 return _SpecialDataArray;
    
}


-(NSMutableArray *)totalArray{
    if (!_totalArray) {
        _totalArray=[NSMutableArray array];
    }
    
    return _totalArray;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:YES];
      [self SetUpData];
   
    
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpViews];
//     [self.NewsSecondTableView.mj_header  beginRefreshing];
  
    [self setUpRefsh];

    
}

#pragma mark------添加视图控件--------

-(void)setUpViews{
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.NewsSecondTableView.delegate=self;
    
    self.NewsSecondTableView.dataSource=self;
    
    
    //注册cell
    
    [self.NewsSecondTableView registerNib:[UINib nibWithNibName:@"NewsHomePageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
//    [self.NewsSecondTableView registerNib:[UINib nibWithNibName:@"NewsSpecialTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellID"];
//    
    [self.NewsSecondTableView registerNib:[UINib nibWithNibName:@"NewsMoreDetialTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellMore"];
//
//    [self.NewsSecondTableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"imageCell"];
    
    
    
    
    self.NewsSecondTableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    //创建tableview 头部view
    self.specialheadView=[[UIView alloc]init];
    
    
    self.specialheadView.frame=CGRectMake(0, 0, self.view.frame.size.width, 280);
    self.specialheadView.backgroundColor=[UIColor whiteColor];
    
//    self.specialheadView.backgroundColor=[UIColor clearColor];
    
    self.NewsSecondTableView.tableHeaderView=self.specialheadView;
    
    
    UIImageView*topImagev=[[UIImageView alloc]init];
    [self.specialheadView addSubview:topImagev];
    [topImagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        
        make.right.mas_equalTo(0);
        
        make.top.mas_equalTo(0);
        
        make.height.mas_equalTo(220);
        
        
    }];
    self.topImagev=topImagev;
    
    UILabel*titleLable=[[UILabel alloc]init];
    
    [self.topImagev addSubview:titleLable];
    
    titleLable.numberOfLines=0;
    
    titleLable.backgroundColor=[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.4];
    
    titleLable.textColor=[UIColor whiteColor];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        
        make.right.mas_equalTo(0);
        
        make.bottom.mas_equalTo(self.topImagev.mas_bottom).offset(0);
        
        
    }];
    
    self.titleLable=titleLable;
    
    

  //创建头部子lable
    
    self.titleSubLable=[[UILabel alloc]init];
    
    [self.specialheadView addSubview:self.titleSubLable];
    
    [self.titleSubLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topImagev.mas_bottom).offset(10);
        
        
    }];
    self.titleSubLable.textColor=[UIColor darkGrayColor];
    
    UIView*vi=[[UIView alloc]init];
    vi.backgroundColor=[UIColor lightGrayColor];
    [self.specialheadView addSubview:vi];
    [vi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(self.titleSubLable.mas_height);
        make.top.mas_equalTo(self.topImagev.mas_bottom).offset(10);
        
        make.bottom.mas_equalTo(self.specialheadView.mas_bottom).offset(-5);
        
        
    }];
    
    
    self.titleSubLable.numberOfLines=0;
   
    
}

#pragma mark-------下拉刷新-----------
-(void)setUpRefsh{
    self.NewsSecondTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(DownRefsh)];
    
}


//下拉刷新通知方法


-(void)DownRefsh{
    
    NSLog(@"下拉刷新");
    [self.totalArray removeAllObjects];
    [self SetUpData];
    
}



#pragma mark------数据解析---------


-(void)SetUpData{
    
      [[AFHTTPSessionManager manager]GET:[NSString stringWithFormat:@"http://c.m.163.com/nc/special/%@.html",self.postID] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
//        NSLog(@"%@",responseObject);
          
          [self SetUpanalysisData:responseObject];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}



- (void)SetUpanalysisData:(NSDictionary*)dict{
    
   NSDictionary*di = dict[@"S1468550226935"];
    
    NSArray*titleArray=di[@"headpics"];
    for (NSDictionary*titleDict in titleArray) {
        NewsSpecial*model=[NewsSpecial SpecislanalysisDataWithDict:titleDict];
        [self.SpecialDataArray addObject:model];
           _topImagev.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.imgsrc]]];
        
        self.titleLable.text=model.title;
    }
    
        NSString*str= di[@"digest"];
    
       self.titleSubLable.text=str;
    
    
    NSLog(@"%@",self.postID);

    
    NSMutableArray*total=di[@"topics"];
    
    for (NSDictionary*dict in total) {
        NSArray*tempArray=dict[@"docs"];
        
        for (NSMutableDictionary*tempDict in tempArray) {
            NewsHomeModel*model=[NewsHomeModel analysisDataWithDict:tempDict];
            
            [self.totalArray addObject:model];
            
            NSLog(@"%@",self.totalArray);
        }
    }

    [self.NewsSecondTableView reloadData];
    [self.NewsSecondTableView.mj_header  endRefreshing];
    
}

#pragma mark--------tableview的代理方法-------------

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsHomeModel*model=self.totalArray[indexPath.row];
    
    if (model.imgextra) {
        NewsMoreDetialTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cellMore" forIndexPath:indexPath];
        cell.model=model;
        
        self.Rowheight=cell.lefImagev.frame.size.height+cell.souceLable.frame.size.height;
        
        return cell;
    }else{
    
    NewsHomePageTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
        cell.model=model;
        
  
    self.Rowheight=cell.NewsHomeLefImagev.frame.size.height;
    
        return cell;}
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.totalArray.count;}



-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 250;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
    return self.Rowheight+10;
}
@end
