//
//  ViewController.m
//  PageVCTest
//
//  Created by LJJ on 9/6/14.
//  Copyright (c) 2014 LJJ. All rights reserved.
//

#import "ViewController.h"
#import "LJJPageView.h"
#define RGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *elementView;

@property (nonatomic) CGFloat distance;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    LJJPageView *pageView = [[LJJPageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    pageView.pageWidth = 220;
    pageView.totalPageNumber = 5;
    pageView.currentPageNumber = 0;
    pageView.pageIndicatorColor = [UIColor grayColor];
    pageView.currentPageIndicatorColor = [UIColor blackColor];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:5];
    for (int n = 0; n<5; n++) {
        UIView *oneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        oneView.backgroundColor = RGB(10*n, 20*n, 30*n);
        [array addObject:oneView];
    }
    [pageView setChildViews:array];
    [self.view addSubview:pageView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
