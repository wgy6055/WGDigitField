//
//  WGDigitField.h
//  WGDigitField
//
//  Created by 王冠宇 on 2018/10/19.
//

#import <UIKit/UIKit.h>

#import "WGDigitView.h"

/*
 
             ┌─────────────────────────────────────┐
             │   ┌─────┐ ┌─────┐ ┌─────┐ ┌─────┐   |
 leadSpacing ==> │     | │     | │     | │     | <== tailSpacing
             │   │  9  | │  5  | │  2  | │  7 <===== digitView
             │   └─────┘ └─────┘ └─────┘ └─────┘   |
             └─────────────────────────────────────┘
 
 */

NS_ASSUME_NONNULL_BEGIN

@class WGDigitField;

/**
 Note: 实现 UITextInput 只是为了支持 iOS 12 验证码一键填充
 实际上实现 UIKeyInput 已经足够实现所有功能
 
 ObjectType: Class of digitView
 */
@interface WGDigitField<__covariant ObjectType> : UIControl <UIKeyInput, UITextInput>

/**
 初始化一个数字输入框
 
 @param initBlock 传入一个初始化 digit view 的 block
 @param count 数字位数
 @param leading 第一个数字位距离左侧边距
 @param tailing 最后一个数字位距离右侧边距
 @param weaken 取消高亮时的动作
 @param highlight 设置高亮时的动作
 @param complete 输入框被填满时的动作
 @return returns an instance of WGDigitField
 */
- (instancetype)initWithDigitViewInitBlock:(NS_NOESCAPE ObjectType (^)(NSInteger index))initBlock
                            numberOfDigits:(NSUInteger)count
                               leadSpacing:(CGFloat)leading
                               tailSpacing:(CGFloat)tailing
                               weakenBlock:(void (^ _Nullable)(ObjectType digitView))weaken
                          highlightedBlock:(void (^ _Nullable)(ObjectType digitView))highlight
                         fillCompleteBlock:(void (^ _Nullable)(WGDigitField *digitField, NSArray<ObjectType> *digitViewArray, NSString *text))complete NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 当前内容
 */
@property (nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
