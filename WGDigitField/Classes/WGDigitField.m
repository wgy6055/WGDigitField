//
//  WGDigitField.m
//  WGDigitField
//
//  Created by 王冠宇 on 2018/10/19.
//

#import "WGDigitField.h"

@import Masonry;

typedef void(^WGDigitFieldFillCompleteBlock) (WGDigitField * digitFiled, NSArray<id> *digitViewArray, NSString *text);
typedef void(^WGDigitFieldUIChangeBlock) (id digitView);

@interface WGDigitField ()

@property (nonatomic, strong) NSMutableArray<WGDigitView *> *digitViewArray;
/**
 当前输入的位置
 */
@property (nonatomic, assign) NSInteger currentIndex;
/**
 输入框被填满后调用
 */
@property (nonatomic, copy) WGDigitFieldFillCompleteBlock completionBlock;
/**
 取消高亮时调用
 */
@property (nonatomic, copy) WGDigitFieldUIChangeBlock weakenBlock;
/**
 设置高亮时调用
 */
@property (nonatomic, copy) WGDigitFieldUIChangeBlock highlightBlock;
/**
 数字位数
 */
@property (nonatomic, assign) NSUInteger numberOfDigits;

@end

@implementation WGDigitField
@synthesize text = _text;

- (instancetype)initWithDigitViewInitBlock:(NS_NOESCAPE id  _Nonnull (^)(NSInteger))initBlock
                            numberOfDigits:(NSUInteger)count
                               leadSpacing:(CGFloat)leading
                               tailSpacing:(CGFloat)tailing
                               weakenBlock:(void (^)(id _Nonnull))weaken
                          highlightedBlock:(void (^)(id _Nonnull))highlight
                         fillCompleteBlock:(void (^)(WGDigitField * _Nonnull, NSArray<id> * _Nonnull, NSString * _Nonnull))complete {
    NSAssert(count != 0, @"number of digit should not be zero!");
    if (self = [super initWithFrame:CGRectZero]) {
        CGFloat width = 0.f;
        CGFloat height = 0.f;
        for (int i = 0; i < count; i++) {
            WGDigitView *view = initBlock(i);
            view.index = i;
            
            width = view.frame.size.width;
            height = view.frame.size.height;
            
            [self.digitViewArray addObject:view];
            [self addSubview:view];
        }
        
        if (count == 1) {
            [self.digitViewArray.firstObject mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
                make.width.equalTo(@(width));
                make.height.equalTo(@(height));
            }];
        } else {
            [self.digitViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:width leadSpacing:leading tailSpacing:tailing];
            [self.digitViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.width.equalTo(@(width));
                make.height.equalTo(@(height));
            }];
        }
        
        self.completionBlock = [complete copy];
        self.weakenBlock = [weaken copy];
        self.highlightBlock = [highlight copy];
        self.numberOfDigits = count;
    }
    return self;
}

#pragma mark - getter & setter
- (NSString *)text {
    __block NSString *text = @"";
    [self.digitViewArray enumerateObjectsUsingBlock:^(WGDigitView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        text = [text stringByAppendingString:obj.text ?: @""];
    }];
    return text;
}

- (void)setText:(NSString *)text {
    NSAssert(text.length <= self.numberOfDigits, @"text should not longer than numberOfDigits you set");
    if (![[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[0-9]*$"] evaluateWithObject:text]) {
        return;
    }
    _text = text;
    for (int i = 0; i < text.length; i++) {
        if (i >= self.digitViewArray.count) {
            break;
        }
        NSString *digit = [text substringWithRange:NSMakeRange(i, 1)];
        [self setText:digit atIndex:i];
    }
}

- (NSMutableArray<WGDigitView *> *)digitViewArray {
    if (!_digitViewArray) {
        _digitViewArray = [[NSMutableArray alloc] init];
    }
    return _digitViewArray;
}

- (NSInteger)currentIndex {
    // find first view without text
    __block WGDigitView *view = nil;
    [self.digitViewArray enumerateObjectsUsingBlock:^(WGDigitView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.hasText) {
            view = obj;
            *stop = YES;
        }
    }];
    if (view) {
        return view.index;
    }
    return self.numberOfDigits;
}

#pragma mark - override UIResponder method
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self becomeFirstResponder];
}

- (BOOL)canBecomeFirstResponder {
    [self refreshHighlightedDigitView];
    self.highlighted = YES;
    [self sendActionsForControlEvents:UIControlEventEditingDidBegin];
    return YES;
}

- (BOOL)resignFirstResponder {
    [self weakenAllDigitView];
    if (self.highlighted) {
        [self sendActionsForControlEvents:UIControlEventEditingDidEnd];
    }
    self.highlighted = NO;
    return [super resignFirstResponder];
}

#pragma mark - UITextInputTraits
- (UIKeyboardType)keyboardType {
    // https://github.com/wgy6055/WGDigitField/issues/1
    // 因为 UIKeyboardTypeASCIICapableNumberPad 不支持本地化自动填充提示
    // 所以改为使用 UIKeyboardTypeNumberPad
    return UIKeyboardTypeNumberPad;
//    if (@available(iOS 10.0, *)) {
//        return UIKeyboardTypeASCIICapableNumberPad;
//    } else {
//        return UIKeyboardTypeNumberPad;
//    }
}

- (UITextContentType)textContentType {
    if (@available(iOS 12.0, *)) {
        return UITextContentTypeOneTimeCode;
    } else {
        return nil;
    }
}

#pragma mark - UIKeyInput
- (void)insertText:(NSString *)text {
    [self setText:text atIndex:self.currentIndex];
}

- (void)deleteBackward {
    [self setText:@"" atIndex:self.currentIndex - 1];
}

- (BOOL)hasText {
    return self.text.length != 0;
}

#pragma mark - private method
- (void)setText:(NSString *)text atIndex:(NSInteger)index {
    if (index >= self.numberOfDigits || index < 0) {
        return;
    }
    if (self.digitViewArray.count >= index + 1) {
        self.digitViewArray[index].text = text;
        
        [self sendActionsForControlEvents:UIControlEventEditingChanged];
        [self sendActionsForControlEvents:UIControlEventValueChanged];
        
        if (self.highlighted) {
            [self refreshHighlightedDigitView];
        }
    }
    if (self.currentIndex == self.numberOfDigits) {
        !self.completionBlock ?: self.completionBlock(self, self.digitViewArray, self.text);
    }
}

- (void)refreshHighlightedDigitView {
    NSInteger currentIndex = MIN(self.currentIndex, self.numberOfDigits - 1);
    for (WGDigitView *view in self.digitViewArray) {
        if (view.index == currentIndex) {
            !self.highlightBlock ?: self.highlightBlock(view);
        } else {
            !self.weakenBlock ?: self.weakenBlock(view);
        }
    }
}

- (void)weakenAllDigitView {
    for (WGDigitView *view in self.digitViewArray) {
        !self.weakenBlock ?: self.weakenBlock(view);
    }
}







// 以下为 UITextInput 的空实现
#pragma mark - UITextInput
- (nullable NSString *)textInRange:(UITextRange *)range {
    return nil;
}

- (void)replaceRange:(UITextRange *)range withText:(NSString *)text {
    return;
}

- (UITextRange *)selectedTextRange {
    return nil;
}

- (void)setSelectedTextRange:(UITextRange *)selectedTextRange {
    return;
}

- (UITextRange *)markedTextRange {
    return nil;
}

- (NSDictionary<NSAttributedStringKey,id> *)markedTextStyle {
    return nil;
}

- (void)setMarkedTextStyle:(NSDictionary<NSAttributedStringKey,id> *)markedTextStyle {
    return;
}

- (void)setMarkedText:(nullable NSString *)markedText selectedRange:(NSRange)selectedRange {
    return;
}
- (void)unmarkText {
    return;
}

- (UITextPosition *)beginningOfDocument {
    return nil;
}

- (UITextPosition *)endOfDocument {
    return nil;
}

- (nullable UITextRange *)textRangeFromPosition:(UITextPosition *)fromPosition toPosition:(UITextPosition *)toPosition {
    return nil;
}

- (nullable UITextPosition *)positionFromPosition:(UITextPosition *)position offset:(NSInteger)offset {
    return nil;
}

- (nullable UITextPosition *)positionFromPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction offset:(NSInteger)offset {
    return nil;
}

- (NSComparisonResult)comparePosition:(UITextPosition *)position toPosition:(UITextPosition *)other {
    return NSOrderedSame;
}

- (NSInteger)offsetFromPosition:(UITextPosition *)from toPosition:(UITextPosition *)toPosition {
    return 0;
}

- (id<UITextInputDelegate>)inputDelegate {
    return nil;
}

- (void)setInputDelegate:(id<UITextInputDelegate>)inputDelegate {
    return;
}

- (id<UITextInputTokenizer>)tokenizer {
    return nil;
}

- (nullable UITextPosition *)positionWithinRange:(UITextRange *)range farthestInDirection:(UITextLayoutDirection)direction {
    return nil;
}

- (nullable UITextRange *)characterRangeByExtendingPosition:(UITextPosition *)position inDirection:(UITextLayoutDirection)direction {
    return nil;
}

- (UITextWritingDirection)baseWritingDirectionForPosition:(UITextPosition *)position inDirection:(UITextStorageDirection)direction {
    return UITextWritingDirectionNatural;
}

- (void)setBaseWritingDirection:(UITextWritingDirection)writingDirection forRange:(UITextRange *)range {
    return;
}

- (CGRect)firstRectForRange:(UITextRange *)range {
    return CGRectNull;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position {
    return CGRectNull;
}

- (NSArray<UITextSelectionRect *> *)selectionRectsForRange:(UITextRange *)range {
    return nil;
}

- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point {
    return nil;
}

- (nullable UITextPosition *)closestPositionToPoint:(CGPoint)point withinRange:(UITextRange *)range {
    return nil;
}

- (nullable UITextRange *)characterRangeAtPoint:(CGPoint)point {
    return nil;
}


@end
