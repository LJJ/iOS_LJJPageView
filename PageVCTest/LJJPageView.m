//
//  LJJPageView.m
//  PageVCTest
//
//  Created by LJJ on 9/10/14.
//  Copyright (c) 2014 LJJ. All rights reserved.
//

#import "LJJPageView.h"
@interface LJJPageView()<UIScrollViewDelegate>
/*
 用以循环
@property (nonatomic, strong) UIView *previousContentView;
@property (nonatomic, strong) UIView *currentContentView;
@property (nonatomic, strong) UIView *nextContentView;
 @property (nonatomic, strong) NSArray *contentViewArray;
 */
@property (nonatomic, strong) UIScrollView *canvasView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic) CGFloat startOffset;
@property (nonatomic) NSInteger pTotalPage;
@property (nonatomic) NSInteger pCurrentPage;

@property (nonatomic) BOOL cycle;//至少3张开始循环
@end

@implementation LJJPageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.canvasView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _canvasView.delegate = self;
        _canvasView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_canvasView];
        self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
        _pageControl.numberOfPages = 3;
        _pageControl.currentPage = 0;
        _pageControl.backgroundColor = [UIColor clearColor];
        [self addSubview:_pageControl];
        self.startOffset = 0;
        self.cycle = YES;
    }
    return self;
}

#pragma mark - property set method

- (void)setTotalPageNumber:(NSInteger)totalPageNumber
{
    self.cycle = totalPageNumber > 2? YES:NO;
    _totalPageNumber = totalPageNumber;
    _pageControl.numberOfPages = _totalPageNumber;
    if (_cycle) _pTotalPage = totalPageNumber+4;
    else _pTotalPage = totalPageNumber;
    [self p_calculateContentSize];
}

- (void)setPageWidth:(CGFloat)pageWidth
{
    //error: pagewidth > pageview.width
    if (pageWidth > _canvasView.frame.size.width) {
        NSLog(@"you cannot make pagewidth %f larger than pageview's width %f",pageWidth,_canvasView.frame.size.width);
        return;
    }
    _pageWidth = pageWidth;
    _startOffset = (_canvasView.frame.size.width-_pageWidth)/2;
    [self p_calculateContentSize];
}

- (void)setPCurrentPage:(NSInteger)pCurrentPage
{
    _pCurrentPage = pCurrentPage;
    _currentPageNumber = (_pCurrentPage+3)%5;
    _pageControl.currentPage = _currentPageNumber;
    [_canvasView setContentOffset:CGPointMake(_pageWidth*_pCurrentPage, _canvasView.contentOffset.y) animated:YES];
}

- (void)setCurrentPageNumber:(NSInteger)currentPageNumber
{
    self.pCurrentPage = currentPageNumber+2;
}

- (void)setChildViews:(NSArray *)childViewArray
{
    NSMutableArray *myChildren = [childViewArray mutableCopy];
    if (_cycle) {
        UIImageView *head1 = [self p_getImageViewFromView:childViewArray[childViewArray.count-2]];
        UIImageView *head2 = [self p_getImageViewFromView:childViewArray[childViewArray.count-1]];
        UIImageView *tail1 = [self p_getImageViewFromView:childViewArray[0]];
        UIImageView *tail2 = [self p_getImageViewFromView:childViewArray[1]];
        
        [myChildren insertObject:head1 atIndex:0];
        [myChildren insertObject:head2 atIndex:1];
        [myChildren addObject:tail1];
        [myChildren addObject:tail2];
    }
        
    [myChildren enumerateObjectsUsingBlock:^(UIView *child, NSUInteger idx, BOOL *stop) {
        child.center = CGPointMake(0.5*_pageWidth+_startOffset+idx*_pageWidth, 0.5*_canvasView.frame.size.height);
        [_canvasView addSubview:child];
    }];
}

- (void)p_calculateContentSize
{
        _canvasView.contentSize = CGSizeMake(_pageWidth*_pTotalPage + _startOffset*2, _canvasView.frame.size.height);
}

- (void)setPageIndicatorColor:(UIColor *)pageIndicatorColor
{
    _pageIndicatorColor = pageIndicatorColor;
    _pageControl.pageIndicatorTintColor = _pageIndicatorColor;
}

- (void)setCurrentPageIndicatorColor:(UIColor *)currentPageIndicatorColor
{
    _currentPageIndicatorColor = currentPageIndicatorColor;
    _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark - private action

-(UIImageView *)p_getImageViewFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [[UIImageView alloc] initWithImage:image];
}

- (void)p_scrollToWhereCanvasShouldBe
{
    CGFloat offset =_canvasView.contentOffset.x;
    if (offset<0) offset = 0;
    else if (offset > (_pTotalPage-1)*_pageWidth) offset = (_pTotalPage-1)*_pageWidth;
    self.pCurrentPage = (NSInteger)((offset+_pageWidth/2)/_pageWidth);

}

#pragma mark - uiscrollview delegate

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self p_scrollToWhereCanvasShouldBe];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self p_scrollToWhereCanvasShouldBe];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (_pCurrentPage<2) {
        
    }
    else if (_pCurrentPage>=_totalPageNumber+2)
    {
        
    }
}

@end
