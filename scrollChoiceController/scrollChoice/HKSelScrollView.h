//
//  HKSelScrollView.h
//  heika
//
//  Created by QinZhuoran on 15/5/5.
//  Copyright (c) 2015年 renrendai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKSelScrollView : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,copy)NSInteger (^numOfViewInShow)();
@property(nonatomic,copy)NSArray* (^subviewArray)();

@property(nonatomic,copy)void (^choiceIndex)(NSInteger CurIndex, NSInteger PreIndex, BOOL endScroll);

-(void)loadSubviews;

-(void)scrollToIndex:(int)index;



@end
