//
//  agreeFirstNav.m
//  agreePay
//
//  Created by fby on 2017/4/19.
//  Copyright © 2017年 agreePay. All rights reserved.
//

#import "agreeFirstNav.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation agreeFirstNav

- (instancetype)initWithLeftBtn:(NSString *)leftBtn andWithTitleLab:(NSString *)titleLab andWithRightBtn:(NSString *)rightBtn andWithBgImg:(UIImageView *)bgImg andWithLab1Btn:(NSString *)lab1Btn andWithLab2Btn:(NSString *)lab2Btn{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    
    if (self) {
        
        self.bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        self.bgImg.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bgImg];
        
        self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 20, SCREEN_WIDTH/2, 44)];
        self.titleLab.backgroundColor = [UIColor clearColor];
        self.titleLab.textColor = [UIColor blackColor];
        self.titleLab.font = [UIFont systemFontOfSize:17.0];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        self.titleLab.text = titleLab;
        
        [self addSubview:_titleLab];
        
        self.lab1Btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 54, 44, 10)];
        self.lab1Btn.backgroundColor = [UIColor clearColor];
        [self.lab1Btn setTitle:lab1Btn forState:0];
        self.lab1Btn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:_lab1Btn];
        
        self.leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 44, 44)];
        self.leftBtn.backgroundColor = [UIColor clearColor];
        [self.leftBtn setBackgroundImage:[UIImage imageNamed:leftBtn] forState:UIControlStateNormal];
        [self addSubview:_leftBtn];
        
        self.lab2Btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44, 54, 44, 10)];
        self.lab2Btn.backgroundColor = [UIColor clearColor];
        [self.lab2Btn setTitle:lab2Btn forState:0];
        self.lab2Btn.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [self addSubview:_lab2Btn];
        
        self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-44, 20, 44, 44)];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:rightBtn] forState:UIControlStateNormal];
        [self addSubview:_rightBtn];
        
        UILabel *myLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 63, SCREEN_WIDTH, 1)];
        myLab.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self addSubview:myLab];
        
    }
    return self;
}

@end
