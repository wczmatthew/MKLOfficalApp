//
//  ScrollPageView.h
//  MKLOfficalApp
//
//  Created by matt on 13-12-15.
//  Copyright (c) 2013年 matthew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScrollPageView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *slideImages;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (strong, nonatomic) NSTimer *timer;
@property (assign) float timerInterval;
@property (assign) int pages;   // 有多少张图片

@property (assign) float pageControlWidth;
@property (assign) float pageControlHeight;

@property (assign) float scrollViewWidth;
@property (assign) float scrollViewHeight;

@end
