//
//  WGDigitView.h
//  WGDigitField
//
//  Created by 王冠宇 on 2018/10/19.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 ┌─────┐
 │     |
 │  9  |
 └─────┘
 */

/**
 ObjectType: Class of backgroundView (should be a kind of UIView)
 */
@interface WGDigitView<__covariant ObjectType> : UIView

/**
 初始化一个显示一位数字的 View，通常会将它传给 WGDigitField 用于初始化
 View 的 frame 大小取决于传入的 backgroundView 的 frame，所以请传入一个有实际大小的 backgroundView
 
 @param view backgroundView (should be a frame-fixed UIView)
 @param font digitFont
 @param color digitColor
 @return WGDigitView
 */
- (instancetype)initWithBackgroundView:(ObjectType)view
                             digitFont:(UIFont *)font
                            digitColor:(UIColor *)color NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 是否有内容
 */
@property (nonatomic, assign, readonly) BOOL hasText;
/**
 数字位索引
 */
@property (nonatomic, assign) NSUInteger index;
/**
 内容
 */
@property (nonatomic, copy) NSString *text;
/**
 背景 view
 */
@property (nonatomic, strong, readonly) ObjectType backgroundView;
/**
 显示内容的 label
 */
@property (nonatomic, strong, readonly) UILabel *digitLabel;

@end

NS_ASSUME_NONNULL_END
