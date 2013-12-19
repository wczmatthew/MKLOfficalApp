//
//  ScrollPageView.m
//  MKLOfficalApp
//
//  Created by matt on 13-12-15.
//  Copyright (c) 2013年 matthew. All rights reserved.
//

#import "ScrollPageView.h"

@implementation ScrollPageView
@synthesize pages = _pages;
@synthesize timerInterval = _timerInterval;
- (void)baseInit
{
    NSLog(@"baseInit");
    NSLog(@"ScrollPageView = %@", NSStringFromCGRect(self.frame));
    self.scrollViewWidth = [self frame].size.width;
    self.scrollViewHeight = [self frame].size.height;
    self.timerInterval = 3.0f;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:_timerInterval target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    
    /* 初始化 scrollview
     * 这里用[self frame]，可能是IB里的大小，或者通过编程指定的大小
     */
    self.scrollView = [[UIScrollView alloc] initWithFrame:[self frame]];
    self.scrollView.bounces = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;    // 暂时不指定需要实现UIScrollViewDelegate协议
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:self.scrollView];
    // 初始化 数组，并添加4张图片
    self.slideImages = [[NSMutableArray alloc] init];
    [self.slideImages addObject:@"1-1.jpg"];
    [self.slideImages addObject:@"1-2.jpg"];
    [self.slideImages addObject:@"1-3.jpg"];
    [self.slideImages addObject:@"1-4.jpg"];
    
    // 初始化 pageControl
    self.pages = 4;                 // 默认 4张图片
    self.pageControlWidth = 100;    // pagecontrol宽度 100
    self.pageControlHeight = 20;
    CGRect pageControlRect = CGRectMake((self.frame.size.width - self.pageControlWidth)/2, self.frame.size.height - self.pageControlHeight, self.pageControlWidth, self.pageControlHeight);
    self.pageControl = [[UIPageControl alloc] initWithFrame:pageControlRect];
    [self.pageControl setCurrentPageIndicatorTintColor:[UIColor redColor]];
    [self.pageControl setPageIndicatorTintColor:[UIColor blackColor]];
    self.pageControl.numberOfPages = self.pages;
    self.pageControl.currentPage = 0;
    
    [self addSubview:self.pageControl];
    
    // 创建4个图片imageview
    for (int i = 0; i < self.pages; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.slideImages objectAtIndex:i]]];
        imageView.frame = CGRectMake((self.scrollViewWidth * i) + self.scrollViewWidth,
                                     0,
                                     self.scrollViewWidth,
                                     self.scrollViewHeight);
        [self.scrollView addSubview:imageView];
    }
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.slideImages objectAtIndex:(self.pages - 1)]]];
    imageView.frame = CGRectMake(0,
                                 0,
                                 self.scrollViewWidth,
                                 self.scrollViewHeight);
    [self.scrollView addSubview:imageView];
    
    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self.slideImages objectAtIndex:0]]];
    imageView.frame = CGRectMake(self.scrollViewWidth * (self.pages + 1),
                                 0,
                                 self.scrollViewWidth, self.scrollViewHeight);
    [self.scrollView addSubview:imageView];
    
    // 设置scrollView的contentSize
    [self.scrollView setContentSize:CGSizeMake(self.scrollViewWidth * (self.pages + 2), self.scrollViewHeight)];
    [self.scrollView setContentOffset:CGPointMake(0, 0)];
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollViewWidth, 0, self.scrollViewWidth, self.scrollViewHeight) animated:NO];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self baseInit];
    }
    return self;
}

- (void)setPages:(int)pages
{
    _pages = pages;
}

- (void)turnPage
{
    int page = self.pageControl.currentPage;
    [self.scrollView scrollRectToVisible:CGRectMake(self.scrollViewWidth * (page + 1), 0, self.scrollViewWidth, self.scrollViewHeight) animated:NO];
}

- (void)runTimePage
{
    int page = self.pageControl.currentPage;
    page++;
    page = page > (self.pages - 1) ? 0 : page;
    
    self.pageControl.currentPage = page;
    [self turnPage];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
    int page = floor((self.scrollView.contentOffset.x - self.scrollViewWidth/(self.pages + 2)) / self.scrollViewWidth) + 1;
    page --;
    self.pageControl.currentPage = page;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    int currentPage = floor((self.scrollView.contentOffset.x - self.scrollViewWidth/(self.pages + 2)) / self.scrollViewWidth) + 1;
    
    if (currentPage == 0) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollViewWidth * self.pages, 0, self.scrollViewWidth, self.scrollViewHeight) animated:NO];
    } else if (currentPage == self.pages + 1) {
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollViewWidth, 0, self.scrollViewWidth, self.scrollViewHeight) animated:NO];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end




















