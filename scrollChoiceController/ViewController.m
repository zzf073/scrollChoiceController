//
//  ViewController.m
//  scrollChoiceController
//
//  Created by zzf073 on 15/12/29.
//  Copyright (c) 2015年 zzf073. All rights reserved.
//

#import "ViewController.h"
#import "HKSelScrollView.h"

@interface ViewController ()

@property(nonatomic, strong) HKSelScrollView *selectSCView;

@property(nonatomic, strong) NSArray *monArray;

@property(nonatomic, strong) NSMutableArray *labArray;

@property(nonatomic, assign) NSInteger selectIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.selectSCView = [[HKSelScrollView alloc] initWithFrame:CGRectMake(0, 70, self.view.frame.size.width, 45)];
    
    self.selectSCView.backgroundColor = [UIColor brownColor];
    
    [self.view addSubview:self.selectSCView];
    
    self.monArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",];
    
    self.labArray = [@[] mutableCopy];
    
    self.selectSCView.backgroundColor = [UIColor whiteColor];
    self.selectSCView.showsVerticalScrollIndicator = NO;
    self.selectSCView.showsHorizontalScrollIndicator = NO;
    self.selectSCView.clipsToBounds = YES;
    self.selectSCView.numOfViewInShow = ^NSInteger(void){
        return 5;
    };
    
    [self setScrollViewLabels];
}

- (void)setScrollViewLabels
{
    for (NSInteger index = 0; index < [_monArray count]; index++) {
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.layer.masksToBounds = YES;
        label.textAlignment = NSTextAlignmentCenter;
        NSString *str = self.monArray[index];
        NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [arrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, str.length)];
        [arrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str.length)];
        label.attributedText = arrStr;
        label.tag = [self.monArray[index] integerValue];
        
        [self.labArray addObject:label];
    }
    
    __weak NSArray *tempArray = _labArray;
    self.selectSCView.subviewArray = ^ NSArray * (){
        return tempArray;
    };
    
    __weak NSArray *tempMonArray = self.monArray;
    __weak ViewController *weakSelf = self;
    self.selectSCView.choiceIndex =  ^(NSInteger curIndex, NSInteger preIndex, BOOL endScroll){
        
        // non-selected label
        UILabel *label = tempArray[preIndex];
        NSString *str = tempMonArray[preIndex];
        
        NSMutableAttributedString *arrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [arrStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, str.length)];
        [arrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, str.length)];
        label.attributedText = arrStr;
        label.backgroundColor = [UIColor whiteColor];
        
        
        // selected label
        UILabel *label1 = tempArray[curIndex];
        str = [NSString stringWithFormat:@"%@个月",tempMonArray[curIndex]];
        NSInteger length = [tempMonArray[curIndex] length];
        NSMutableAttributedString *arrStr1 = [[NSMutableAttributedString alloc] initWithString:str];
        [arrStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, str.length)];
        [arrStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(0, length)];
        [arrStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(length, str.length-length)];
        label1.attributedText = arrStr1;
        label1.backgroundColor = [UIColor blueColor];
        
        weakSelf.selectIndex = curIndex;
        
        //[weakSelf setSelectedIndex:weakSelf.selectIndex];
        
//        if(self.numberString.integerValue >= self.lowerLimitAmount){
//            [weakSelf setSelectedIndex:weakSelf.selectIndex];
//        }
        
    };
    
    [self.selectSCView loadSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
