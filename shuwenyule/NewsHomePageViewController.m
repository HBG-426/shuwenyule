//
//  NewsHomePageViewController.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "NewsHomePageViewController.h"
#import "AFNetworking/AFNetworking.h"
#import "NewsHomeModel.h"
#import "NewsHomePageTableViewCell.h"
#import "NewsSecondViewController.h"
#import "NewsSpecial.h"
#import "NewsSpecialTableViewCell.h"
#import "NewsMoreDetialTableViewCell.h"
#import "MJRefresh.h"
#import "ImageTableViewCell.h"
#import "NewsHeadDetialViewController.h"




@interface NewsHomePageViewController ()<
UITableViewDataSource,
UITableViewDelegate
>
@property (strong, nonatomic) IBOutlet UITableView *NewsHomePageTableView;
@property(nonatomic,strong)NSMutableArray*newsHomePageArray;
@property(nonatomic ,assign)CGFloat RowHeight;
@property(nonatomic,assign)NSInteger totals;
@property(nonatomic,assign)NSInteger total;

@end

@implementation NewsHomePageViewController


//懒加载数据数组
-(NSMutableArray *)newsHomePageArray{
    if (!_newsHomePageArray) {
        _newsHomePageArray=[NSMutableArray array];
    }
    
    return _newsHomePageArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self   setUpViews];
    
    [self SetUpRefresh];
    
 
  
}



#pragma mark-----------添加tableview视图并添加代理-------------
//tableView基本数值（代理  数据源代理的添加）
-(void)setUpViews{
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.NewsHomePageTableView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    self.NewsHomePageTableView.delegate=self;
    self.NewsHomePageTableView.dataSource=self;
    
    [self.NewsHomePageTableView registerNib:[UINib nibWithNibName:@"NewsHomePageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cell"];
    
    [self.NewsHomePageTableView registerNib:[UINib nibWithNibName:@"NewsSpecialTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"cellID"];
    
    [self.NewsHomePageTableView registerNib:[UINib nibWithNibName:@"NewsMoreDetialTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellMore"];
    
    [self.NewsHomePageTableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:nil] forCellReuseIdentifier:@"imageCell"];
    
    
    [self.NewsHomePageTableView.mj_header beginRefreshing];
    NSInteger  urlPragma=0;
    [self  setUpData:urlPragma];
    self.totals=0;
    self.total=0;
}


#pragma mark-----------配置刷新控件-----------
//刷新控件
- (void)SetUpRefresh {

   self.NewsHomePageTableView.mj_header=[MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(DownRefesh)];
    
//   self.NewsHomePageTableView.mj_header.
    
    self.NewsHomePageTableView.mj_footer=[MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(TopRefesh) ];
}




#pragma mark-------------下拉刷新更新数据-------------

//下拉刷新

-(void)DownRefesh{
    
    [self.newsHomePageArray removeAllObjects];
    
     NSInteger  urlPragma=0;
    
    [self  setUpData:urlPragma];
    
    NSLog(@"下拉刷新");
}


#pragma mark--------------上拉刷新加载更多数据------------
//上啦刷新

-(void)TopRefesh{

       if (self.total==0){
        
        [self.newsHomePageArray removeAllObjects];
        
      }else if(self.total!=0){
        
        
        NSLog(@"继续加载数据");
        
      }
    
     NSString*strUrl=[NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/T1348648037603/%ld-20.html",self.totals*20];
    
     [[AFHTTPSessionManager manager]GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //      NSLog(@"%@",responseObject);
        //数据解析
         NSArray*tempArray = responseObject[@"T1348648037603"];
         
          for (NSMutableDictionary*tempDict in tempArray) {
              
            NewsHomeModel*model=[NewsHomeModel analysisDataWithDict:tempDict];
              
          [self.newsHomePageArray addObject:model];
        
            
        }
         dispatch_async(dispatch_get_main_queue(),^{
                        [self.NewsHomePageTableView reloadData];
             
                        [self.NewsHomePageTableView.mj_footer  endRefreshing];
             
                    });
       
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
     self.totals=self.totals+1;
    
     self.total=self.total+1;

}


#pragma mark------请求数据-------------
//请求数据
 - (void)setUpData:(NSInteger)urlPragma{
     
     
    NSString*strUrl = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/T1348648037603/%ld-20.html",urlPragma];
     
   [[AFHTTPSessionManager manager]GET:strUrl parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
      //数据解析
    [self SetUpanalysisData:responseObject];
       dispatch_async(dispatch_get_main_queue(), ^{
           
           [self.NewsHomePageTableView reloadData];
           
           [self.NewsHomePageTableView.mj_header  endRefreshing];
       });
       

       
      
  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
  }];
    
    
}



#pragma mark--------数据解析-------------
//数据解析
- (void)SetUpanalysisData:(NSDictionary*)dict{
    
     NSArray*tempArray = dict[@"T1348648037603"];
    
    for (NSMutableDictionary*tempDict in tempArray) {
        
        NewsHomeModel*model = [NewsHomeModel analysisDataWithDict:tempDict];
        
        [self.newsHomePageArray addObject:model];
        
        
          }
    
    
    
}

#pragma mark---------tableview的代理方法-------------



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.newsHomePageArray.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsHomeModel *model = self.newsHomePageArray[indexPath.row];
    
        if(model.hasHead && model.photosetID){
        
        NewsSpecialTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        
         cell.model=model;
        
         self.RowHeight=130;
        
         return cell;

  }
    else if (model.imgType)
        
    {
        
    NewsSpecialTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
        
        
   
  
        cell.model=model;
      
        
        self.RowHeight=cell.HeardView.frame.size.height;
      
        
        return cell;

    }
    
    else if (model.imgextra)
        
    {
        NewsMoreDetialTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cellMore" forIndexPath:indexPath];
        
        
        self.RowHeight= cell.lefImagev.frame.size.height+cell.souceLable.frame.size.height;
        
        
        
        cell.model=model;
        
        
        return cell;

    }
    
    else
        
    {
         NewsHomePageTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        
        cell.model=model;
        
        self.RowHeight=cell.NewsHomeLefImagev.frame.size.height;
        
        return cell;
    }
    

}


-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 250;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   return  self.RowHeight+30;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NewsHomeModel *model = self.newsHomePageArray[indexPath.row];
    
    if (model.hasHead && model.photosetID){
        
        NewsHeadDetialViewController*headDetial=[[NewsHeadDetialViewController alloc]init];
        
        
        headDetial.pragma=model.photosetID;
        
       
        [self.navigationController pushViewController:headDetial animated:YES];
        
        
    }else if(model.imgextra){
        
        
        
        NewsHeadDetialViewController*headDetial=[[NewsHeadDetialViewController alloc]init];
        
        
        headDetial.pragma=model.photosetID;
        
        
        [self.navigationController pushViewController:headDetial animated:YES];

    }else if(model.skipID){
        
        UIStoryboard*story=[UIStoryboard storyboardWithName:@"News" bundle:nil];
        
        NewsSecondViewController*NomelController=[story instantiateViewControllerWithIdentifier:@"NewsSecondViewController"];
     
        
        
//        NewsSecondViewController*NomelController=[[NewsSecondViewController alloc]init];
         NomelController.postID=model.skipID;
        
        
        
        
        [self.navigationController  pushViewController:NomelController animated:NO];
       
        
    }
    
  
    
    
    
}



@end
