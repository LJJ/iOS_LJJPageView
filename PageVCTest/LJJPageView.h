//
//  LJJPageView.h
//  PageVCTest
//
//  Created by LJJ on 9/10/14.
//  Copyright (c) 2014 LJJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LJJPageView;

@protocol LJJPageViewDelegate <NSObject>
- (void)LJJPageView:(LJJPageView *)pageView didScrollToPage:(NSInteger)pageNumber;
@end

@interface LJJPageView : UIView
@property (nonatomic) CGFloat pageWidth;
@property (nonatomic) NSInteger totalPageNumber;
@property (nonatomic) NSInteger currentPageNumber;
@property (nonatomic, strong) UIColor *pageIndicatorColor;
@property (nonatomic, strong) UIColor *currentPageIndicatorColor;

- (void)setChildViews:(NSArray *)childViewArray;

@end
