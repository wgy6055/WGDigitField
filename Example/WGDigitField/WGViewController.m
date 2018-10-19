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

@interface BackgroundWithBottomLine : UIView

@property (nonatomic, strong) UIView *bottomLine;

+ (instancetype)create;

@end

@implementation BackgroundWithBottomLine

+ (instancetype)create {
    BackgroundWithBottomLine *background = [[BackgroundWithBottomLine alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
    background.bottomLine = [[UIView alloc] init];
    background.bottomLine.backgroundColor = [UIColor grayColor];
    [background addSubview:background.bottomLine];
    [background.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.and.bottom.equalTo(@0);
        make.height.equalTo(@1);
    }];
    return background;
}

@end

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
    
    WGDigitField<WGDigitView<UIView *> *> *field = [[WGDigitField<WGDigitView<UIView *> *> alloc] initWithDigitViewInitBlock:^WGDigitView<UIView *> * _Nonnull{
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 45)];
        background.backgroundColor = [UIColor whiteColor];
        background.layer.borderColor = [UIColor grayColor].CGColor;
        background.layer.borderWidth = 1.f;
        background.layer.cornerRadius = 3.f;
        
        return [[WGDigitView<UIView *> alloc] initWithBackgroundView:background digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];
    } numberOfDigits:6 leadSpacing:25 tailSpacing:25 weakenBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
        digitView.backgroundView.layer.borderColor = [UIColor grayColor].CGColor;
        digitView.backgroundView.layer.borderWidth = 1.f;
    } highlightedBlock:^(WGDigitView<UIView *> * _Nonnull digitView) {
        digitView.backgroundView.layer.borderColor = [UIColor redColor].CGColor;
        digitView.backgroundView.layer.borderWidth = 2.f;
    } fillCompleteBlock:^(WGDigitField * _Nonnull digitField, NSString * _Nonnull text) {
        [digitField resignFirstResponder];
    }];
    
    [self.view addSubview:field];
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
//        make.centerY.equalTo(self.view);
        make.top.equalTo(@100);
        make.height.equalTo(@(45 + 2 * 17));
    }];
    
    WGDigitField<WGDigitView<BackgroundWithBottomLine *> *> *field2 = [[WGDigitField<WGDigitView<BackgroundWithBottomLine *> *> alloc] initWithDigitViewInitBlock:^WGDigitView<BackgroundWithBottomLine *> * _Nonnull{
        BackgroundWithBottomLine *background2 = [BackgroundWithBottomLine create];
        
        return [[WGDigitView<BackgroundWithBottomLine *> alloc] initWithBackgroundView:background2 digitFont:[UIFont systemFontOfSize:25.f] digitColor:[UIColor blackColor]];
    } numberOfDigits:6 leadSpacing:25 tailSpacing:25 weakenBlock:^(WGDigitView<BackgroundWithBottomLine *> * _Nonnull digitView) {
        digitView.backgroundView.bottomLine.backgroundColor = [UIColor grayColor];
    } highlightedBlock:^(WGDigitView<BackgroundWithBottomLine *> * _Nonnull digitView) {
        digitView.backgroundView.bottomLine.backgroundColor = [UIColor redColor];
    } fillCompleteBlock:^(WGDigitField * _Nonnull digitField, NSString * _Nonnull text) {
        [digitField resignFirstResponder];
    }];

    [self.view addSubview:field2];
    [field2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.and.trailing.equalTo(@0);
        make.top.equalTo(field.mas_bottom).with.offset(20);
        make.height.equalTo(@(45 + 2 * 17));
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
