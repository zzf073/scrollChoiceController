//
//  HKSelScrollView.m
//  heika
//
//  Created by QinZhuoran on 15/5/5.
//  Copyright (c) 2015年 renrendai. All rights reserved.
//

#import "HKSelScrollView.h"


@interface HKSelScrollView()

@property(nonatomic, assign)float subViewWidth;

@property(nonatomic, strong)NSArray *mSubViews;

@property(nonatomic, assign)BOOL isLeft;

@property(nonatomic, assign) NSInteger preIndex;

@property(nonatomic, assign) BOOL endScroll;

@end


@implementation HKSelScrollView

-(void)loadSubviews
{
    //self.pagingEnabled = YES;
    self.delegate = self;
    if(self.numOfViewInShow)
    {
        self.subViewWidth =  self.frame.size.width / self.numOfViewInShow();
    }
    if(self.subviewArray)
    {
        self.mSubViews = self.subviewArray();
        
        self.contentSize = CGSizeMake(self.subViewWidth * (self.mSubViews.count - 1) +self.frame.size.width , self.bounds.size.height);
      
        for (int k = 0; k < self.mSubViews.count; k++) {
            UIView *p = [self.mSubViews objectAtIndex:k];
            
            p.frame = CGRectMake(self.frame.size.width/2+ self.subViewWidth*(k - 0.5), 0, self.subViewWidth, self.frame.size.height);
            [self addSubview:[self.mSubViews objectAtIndex:k]];
        }
    }
    
    if(self.choiceIndex)
    {
        self.choiceIndex(0,0, self.endScroll);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat e = (self.contentOffset.x)/self.subViewWidth;
    NSInteger k = (self.contentOffset.x)/self.subViewWidth;
    if(e - k > 0.5)
    {
        k = k + 1;
    }
    if(k<0)
        k = 0;
    else if(k > self.mSubViews.count - 1)
        k = self.mSubViews.count - 1;
    
    if(self.choiceIndex && self.preIndex != k)
    {
        self.choiceIndex(k,self.preIndex, self.endScroll);
    }
    
    self.preIndex = k;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.endScroll = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        self.endScroll = YES;
        
        CGFloat e = (self.contentOffset.x)/self.subViewWidth;
        NSInteger k = (self.contentOffset.x)/self.subViewWidth;
        
        if(e - k > 0.5){
            k = k+1;
        }
        
        if(k < 0){
            k = 0;
        }
        else if(k > self.mSubViews.count - 1){
            k = self.mSubViews.count - 1;
        }
        
        
        
        [UIView animateWithDuration:0.4 animations:^(){
            self.contentOffset = CGPointMake( k * self.subViewWidth, 0);
        }];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!self.pagingEnabled) {
        self.endScroll = YES;
        
        CGFloat e = (self.contentOffset.x)/self.subViewWidth;
        NSInteger k = (self.contentOffset.x)/self.subViewWidth;
        
        
        if(self.isLeft)
        {
            if(e - k > 0.5)
            {
                k = k + 1;
            }
            
        }
        //        else
        //        {
        //            if(e - k < 0.5)
        //            {
        //                NSLog(@"e = %f  k = %i",e,k);
        //                k = k - 1;
        //            }
        //        }
        
        if(k < 0) {
            k = 0;
        }
        else if(k > self.mSubViews.count - 1){
            k = self.mSubViews.count - 1;
        }
        
        [UIView animateWithDuration:0.4 animations:^(){
            self.contentOffset = CGPointMake((k)*self.subViewWidth , 0);
        }];
        
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSLog(@"%@", NSStringFromCGPoint(velocity));
    
    self.isLeft = velocity.x > 0;
}

-(void)scrollToIndex:(int)index
{
    self.contentOffset = CGPointMake((index)*self.subViewWidth , 0);
}




@end
