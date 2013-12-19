//
//  MKLViewController.m
//  MKLOfficalApp
//
//  Created by matt on 13-12-14.
//  Copyright (c) 2013年 matthew. All rights reserved.
//

#import "MKLViewController.h"
#import "ScrollPageView.h"

@interface MKLViewController ()

@end

@implementation MKLViewController
@synthesize scrollPageView = _scrollPageView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[self navigationItem] setTitle:@"Main"];
    
    self.scrollPageView = [[ScrollPageView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    [self.view addSubview:self.scrollPageView];
    NSLog(@"view count = %d", [[self.view subviews] count]);
    NSLog(@"ScrollPageView 有Subview = %d", [[_scrollPageView subviews] count]);
    NSLog(@"ScrollPageView.scrollView，有ImageView = %d",
          [[[_scrollPageView scrollView] subviews] count]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
