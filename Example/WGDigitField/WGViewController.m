//
//  WGViewController.m
//  WGDigitField
//
//  Created by 王冠宇 on 10/19/2018.
//  Copyright (c) 2018 王冠宇. All rights reserved.
//

#import "WGViewController.h"

@import WGDigitField;
@import Masonry;

@interface WGViewController ()

@end

@implementation WGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
    background.backgroundColor = [UIColor whiteColor];
    background.layer.borderColor = [UIColor grayColor].CGColor;
    background.layer.borderWidth = 1.f;
    background.layer.cornerRadius = 3.f;
    
    WGDigitView *view = [[WGDigitView alloc] initWithBackgroundView:background digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];
    
    WGDigitField *field = [[WGDigitField alloc] initWithSingleDigitView:view numberOfDigits:6 leadSpacing:25.f tailSpacing:25.f weakenBlock:^(WGDigitView * _Nonnull digitView) {
        digitView.backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
        digitView.backgroundView.layer.borderWidth = 1.f;
    } highlightedBlock:^(WGDigitView * _Nonnull digitView) {
        digitView.backgroundView.layer.borderColor = [UIColor redColor].CGColor;
        digitView.backgroundView.layer.borderWidth = 2.f;
    } fillCompleteBlock:^(WGDigitField * _Nonnull digitFiled, NSString * _Nonnull text) {
        [digitFiled resignFirstResponder];
    }];
    
    [self.view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(@0);
        make.centerY.equalTo(self.view);
        make.height.equalTo(@(45 + 2 * 17));
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
