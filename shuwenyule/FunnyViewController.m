//
//  FunnyViewController.m
//  shuwenyule
//
//  Created by lanou3g on 16/7/13.
//  Copyright © 2016年 yu. All rights reserved.
//

#import "FunnyViewController.h"
//延展
#import "UIView+YTExtension.h"
///控制器
#import "YTAllViewController.h"
#import "YTVideoViewController.h"
#import "YTMusicTableViewController.h"
#import "YTPictureTableViewController.h"
#import "YTWordTableViewController.h"

@interface FunnyViewController ()
<
  UIScrollViewDelegate
>
/**标签栏的红色指示器*/
@property (nonatomic, weak) UIView *indecatorView;
/**当前选中的按钮*/
@property (nonatomic, weak) UIButton * selectedButton;
/**顶部的所有的标签*/
@property (nonatomic,weak) UIView *tirlesview;
/**底部所有的内容*/
@property (nonatomic,weak) UIScrollView *contentView;
@end

@implementation FunnyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//  设置导航栏
    [self setupNav];
//  初始化子控制器
    [self setupChildVces];

//  设置顶部标题栏
    [self setupTitesView];
    
//  底部的 scrollView
    [self setupConrentView];
    

}
//    初始化子控制器
- (void)setupChildVces {
    
    YTAllViewController *all = [[YTAllViewController alloc]init];
    [self addChildViewController:all];
    
    YTVideoViewController *Video = [[YTVideoViewController alloc]init];
    [self addChildViewController:Video];
    
   YTMusicTableViewController *Music = [[YTMusicTableViewController alloc]init];
    [self addChildViewController:Music];
    
    YTPictureTableViewController *Picture = [[YTPictureTableViewController alloc]init];
    [self addChildViewController:Picture];
    
    YTWordTableViewController *Word = [[YTWordTableViewController alloc]init];
    [self addChildViewController:Word];
    
    
}
//    底部的scrollView
- (void)setupConrentView {
//    关闭自动布局
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *scrollView = [[UIScrollView alloc]init];
// 分页
    scrollView.pagingEnabled = YES;
// 让他有穿透效果
    scrollView.frame = self.view.bounds;
//
    scrollView.delegate = self;
    
    [self.view insertSubview:scrollView atIndex:0];
//  设置滚动的范围 左右滚动
    scrollView.contentSize = CGSizeMake(scrollView.width * self.childViewControllers.count, 0);
    
    self.contentView = scrollView;
    
//    添加第一个控制器的 view
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    
}


/**设置顶部标题栏*/
- (void)setupTitesView {
//    标签栏的整体
    UIView *titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 35)];
//    让背影色半透明
    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];

    [self.view addSubview:titlesView];
// 顶部的标签
    self.tirlesview = titlesView;

    //    底部的红色指示器
    UIView *indicatorView = [[UIView alloc]init];
    //    半透明的方法
    indicatorView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:1];
    
    indicatorView.height = 2;
//    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
   
    self.indecatorView = indicatorView;
    
    
//  内部的子标签
    NSArray *titles = @[@"精彩时刻",@"视频",@"声音",@"图片",@"段子"];
//    button 的长
    CGFloat width = titlesView.frame.size.width /titles.count;
//    button 的宽
    CGFloat height = titlesView.frame.size.height;
    
    
    for (NSInteger i = 0; i < titles.count; i ++) {
        
        UIButton *button = [[UIButton alloc]init];
        
        button.tag = i;
        
        button.frame = CGRectMake(i * width, 0, width, height);
//        设置文字
        [button setTitle:titles[i] forState:UIControlStateNormal];
//        强制布局
//        [button layoutIfNeeded];
//        设置颜色
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
//        设置字号
        button.titleLabel.font = [UIFont systemFontOfSize:14];
//       点击方法
        [button addTarget:self action:@selector(titleClick:) forControlEvents:(UIControlEventTouchUpInside)];
        
        [titlesView addSubview:button];
// 默认点击了第一个按钮
        if (i == 0) {
            
          button.enabled = NO;
            
          self.selectedButton = button;
//       让按钮内部的 label 根据文字内容计算尺寸
//  
            [button.titleLabel sizeToFit];
            
        self.indecatorView.width = button.titleLabel.width;
            
        self.indecatorView.centerX = button.centerX;
        }
        
    }

//    保证按钮先加进去的
    [titlesView addSubview:indicatorView];
  
}

// button 的点击方法
- (void)titleClick:(UIButton *)button {

//    修改按钮状态
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    __weak typeof(self)weakSelf = self;
    //  让标签执行动画
    [UIView animateWithDuration:0.15 animations:^{
        
        weakSelf.indecatorView.width = button.titleLabel.width;
        
        weakSelf.indecatorView.centerX = button.centerX;
    }];
//  滚动
    CGPoint offset = self.contentView.contentOffset;
    
    offset.x = button.tag * self.contentView.width;
    
    [self.contentView setContentOffset:offset animated:YES];
    
    
  
}

//设置导航栏
- (void)setupNav {
    
//    设置导航栏的标题
    
//    设置左边的取消按钮
    
//    设置背景颜色
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIScrollViewDelegate 代理方法
// 滚动结束时候调用
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {


//    当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
//    添加自控制器试图
    UITableViewController * vc = self.childViewControllers[index];
    
    vc.view.x = scrollView.contentOffset.x;
    
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.tirlesview.frame);
// 这个属性十分重要 保证我的东西不被其他东西挡住 减掉他们的高度 在关闭自动布局 设置内边距
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
  //添加视图到 scroll 上面
    [scrollView addSubview:vc.view];
}
//停止减速的时候
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
//    点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    [self titleClick:self.tirlesview.subviews[index]];
}

@end
