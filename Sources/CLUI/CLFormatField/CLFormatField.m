//
//  CLFormatField.m
//  FormatFieldDemo
//
//  Created by lion on 2020/4/29.
//  Copyright © 2020 lion. All rights reserved.
//

#import "CLFormatField.h"
#import "NSString+Separate.h"
#import "UITextField+ExtentRange.h"
#import "NSString+Helper.h"
#import "EnvConstant.h"
#import "JKSizeFix.h"
#import "UITextField+CL.h"

#define FIELD_TEXT_COLOR ([UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:1/1.0])
#define FIELD_BG_COLOR ([UIColor whiteColor])
@interface CLFormatField()<UITextFieldDelegate>

@end
@implementation CLFormatField

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initViews];
    }
    return self;
}

-(void)initViews{
    _fieldType = CLFormatFieldTypeDef;
    _fieldPaddingX = 0;
    _maxTextLength = 100;
    _placeHolder = @"请输入内容";
    _lengthErrorMsg = @"文本长度";
    _formatErrorMsg = @"格式不正确";
    _clearButtonMode = UITextFieldViewModeWhileEditing;
    
    _textField = [UITextField new];
    _textField.delegate = self;
    _textField.textColor = FIELD_TEXT_COLOR;
    _textField.backgroundColor = FIELD_BG_COLOR;
    [_textField setFont:[UIFont fontWithName:@"PingFangSC-Medium" size:18]];
    _textField.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    _textField.clearButtonMode = _clearButtonMode;
    _textField.returnKeyType = UIReturnKeyDone;
    UIButton *clearButton = [_textField valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"clformatfield_clear_button"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"clformatfield_clear_button"] forState:UIControlStateHighlighted];
    
    [self addSubview:_textField];
    
    self.backgroundColor = FIELD_BG_COLOR;
}

#pragma mark - initWithFrame
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        _textField.frame = CGRectMake(_fieldPaddingX, 0, frame.size.width-_fieldPaddingX, frame.size.height);
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame type:(CLFormatFieldType)type{
    self = [super initWithFrame:frame];
    if (self) {
        [self initViews];
        [self setFieldType:type];
        _textField.frame = CGRectMake(_fieldPaddingX, 0, frame.size.width-_fieldPaddingX, frame.size.height);
    }
    return self;
}

#pragma mark - gets and sets
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    _textField.frame = CGRectMake(_fieldPaddingX, 0, frame.size.width-_fieldPaddingX, frame.size.height);
}

-(void)setPlaceHolder:(NSString *)placeHolder{
    _placeHolder = placeHolder;
    [_textField cl_placeholder:placeHolder color:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0] font:[UIFont fontWithName:@"PingFangSC-Regular" size:18]];
}

-(NSString *)getPlaceHolder{
    return _textField.placeholder;
}

-(void)setText:(NSString *)text{
    _textField.text = text;
    [self formatText];
    [self textFiledValueDidChanged];
}
-(NSString *)text{
    return _textField.text;
}

-(void)setTextColor:(UIColor *)textColor{
    _textField.textColor = textColor;
}
-(UIColor *)textColor{
    return _textField.textColor;
}

-(void)setEnabled:(BOOL)enabled{
    _textField.enabled = enabled;
}

-(BOOL)enabled{
    return _textField.enabled;
}

-(UIToolbar*)createToolbar {
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 35)];
    toolBar.barTintColor = [UIColor colorWithRed:0.980 green:0.980 blue:0.980 alpha:1.000];
    UILabel *kl = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH/2-60, 0, 120, 35)];
    kl.backgroundColor = [UIColor clearColor];
    kl.textAlignment = NSTextAlignmentCenter;
    kl.font = [UIFont systemFontOfSize:14];
    kl.text = @"安全键盘";
    kl.textColor = [UIColor blackColor];
    [toolBar addSubview:kl];
    
    UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(kl.frame.origin.x - 15, (35-15)/2,13, 15)];
    iv.backgroundColor = [UIColor clearColor];
    iv.image = [UIImage imageNamed:@"keyboardIcon_v5"];
    [toolBar addSubview:iv];

    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *doneView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    [doneView setBackgroundColor:[UIColor clearColor]];
    [doneView.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [doneView.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [doneView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [doneView setTitle:@"完成" forState:UIControlStateNormal];
    [doneView setImage:[UIImage imageNamed:@"keyboard_done"] forState:UIControlStateNormal];
    [doneView addTarget:self action:@selector(textFieldDone) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithCustomView:doneView];
    toolBar.items = @[space,done];
    return toolBar;
}

- (void)setFieldType:(CLFormatFieldType)fieldType{
    _fieldType = fieldType;
    switch (fieldType) {
        case CLFormatFieldTypeMobilePhone:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 11;
            _textField.inputAccessoryView = [self createToolbar];
        }
            break;
        case CLFormatFieldTypeBankCard:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 19;
            _textField.inputAccessoryView = [self createToolbar];
        }
            break;
        case CLFormatFieldTypeIDCard:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 18;
            _textField.inputAccessoryView = [self createToolbar];
        }
            break;
        case CLFormatFieldTypeSMS:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 6;
            _textField.inputAccessoryView = [self createToolbar];
        }
            break;
        case CLFormatFieldTypeNumber:{
            _textField.keyboardType = UIKeyboardTypeDecimalPad;
            _maxTextLength = 64;
            _textField.inputAccessoryView = [self createToolbar];
        }
            break;
        default:{
            _textField.keyboardType = UIKeyboardTypeDefault;
            _maxTextLength = 64;
        }
            break;
    }
    _textField.returnKeyType = UIReturnKeyDone;
}

-(void)setSecureTextEntry:(BOOL)secure{
    _secureTextEntry = secure;
    _textField.secureTextEntry = secure;
}
-(void)setEndEditing:(BOOL)endEditing{
    _endEditing = endEditing;
    [_textField endEditing:endEditing];
}

-(void)setInputView:(UIView *)view{
    _inputView = view;
    _textField.inputView = view;
}

-(NSRange)selectedRange{
    return [_textField selectedRange];
}
-(void)setSelectedRange:(NSRange)range{
    [_textField setSelectedRange:range];
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode{
    _clearButtonMode = clearButtonMode;
    _textField.clearButtonMode = clearButtonMode;
}

#pragma mark - 使用系统键盘时触发
-(void)formatText{
    NSString *text = _textField.text;
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    switch (_fieldType) {
        case CLFormatFieldTypeMobilePhone:{
            _textField.text = [text separate:NSSTRING_SEPARATE_PHONE];
        }
            break;
        case CLFormatFieldTypeBankCard:{
            _textField.text = [text separate:NSSTRING_SEPARATE_CARD];
        }
            break;
        case CLFormatFieldTypeIDCard:{
            _textField.text = [text separate:NSSTRING_SEPARATE_ID];
        }
            break;
            
        default:
            break;
    }
}
-(BOOL)checkFormat{
    NSString *text = _textField.text;
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    switch (_fieldType) {
        case CLFormatFieldTypeMobilePhone:{
            return [text cl_isMobile];
        }
            break;
        case CLFormatFieldTypeBankCard:{
            return [text cl_isBankCard];
        }
            break;
        case CLFormatFieldTypeIDCard:{
            return [text cl_isIDCard];
        }
            break;
        case CLFormatFieldTypeSMS:{
            return [text cl_isSMS];
        }
            break;
        default:
            break;
    }
    return true;
}
-(BOOL)checkMaxLength{
    NSString *text = _textField.text;
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (text.length >= _maxTextLength) {
        return false;
    }
    return true;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if(self.fieldType == CLFormatFieldTypeDef){
        [self textFiledValueDidChanged];
        return YES;
    }
    NSString *text = textField.text;
    if ([@""isEqualToString:string] && range.length > 0) {//删除事件
        NSRange selectedRange = [textField selectedRange];
        NSString *s = [text substringWithRange:range];
        if ([@" "isEqualToString:s]) {//如果删除的是空格，向前删除两个
            text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location-1, range.length+1) withString:@""];
            selectedRange.location -= 2;
        }else{
            text = [text stringByReplacingCharactersInRange:range withString:@""];
            selectedRange.location -= 1;
        }
        textField.text = text;
        [self formatText];
        [self textFiledValueDidChanged];
        
        if (text.length > selectedRange.location) {
            [textField setSelectedRange:selectedRange];
        }
        return NO;
    }
    if ([self checkMaxLength] == false) {
        if (_delegate) {
            if ([_delegate respondsToSelector:@selector(CLFormatFieldTextValidateFail:msg:)]) {
                [_delegate CLFormatFieldTextValidateFail:self msg:_lengthErrorMsg];
            }
        }
        return NO;
    }
    NSRange selectedRange = [_textField selectedRange];
    _textField.text = [text stringByReplacingCharactersInRange:selectedRange withString:string];
    [self formatText];
    NSString *afterString = _textField.text;
    
    //1.如果输入完后，当前光标在空格之前，输入时加两位
    int dis = 1;
    if (afterString.length-text.length == 2) {//长度增加了两位并且光标在空格之前
        NSString *s = [afterString substringWithRange:NSMakeRange(selectedRange.location, 1)];
        if ([@" "isEqualToString:s]) {
            dis = 2;
        }
    }else{
        //2.如果当前光标在空格前面加两位
        if (text.length > selectedRange.location) {
            NSString *s = [text substringWithRange:NSMakeRange(selectedRange.location, 1)];
            if ([@" "isEqualToString:s]) {
                dis = 2;
            }
        }
    }
    [_textField setSelectedRange:NSMakeRange(selectedRange.location+dis, 0)];
    [self textFiledValueDidChanged];
    return NO;
}

-(void)textFiledValueDidChanged{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(CLFormatFieldTextValueDidChanged:)]) {
            [_delegate CLFormatFieldTextValueDidChanged:self];
        }
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

#pragma mark - 使用自定义键盘时使用事件
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(CLFormatFieldTextFieldDidBeginEditing:)]) {
            [_delegate CLFormatFieldTextFieldDidBeginEditing:self];
        }
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(CLFormatFieldTextFieldDidEndEditing:)]) {
            [_delegate CLFormatFieldTextFieldDidEndEditing:self];
        }
    }
    [self formatText];
    [self textFiledValueDidChanged];//复制粘贴也要触发
    
    if([self checkFormat] == false){
        if (_delegate) {
            if ([_delegate respondsToSelector:@selector(CLFormatFieldTextValidateFail:msg:)]) {
                [_delegate CLFormatFieldTextValidateFail:self msg:_formatErrorMsg];
            }
        }
    }
}

-(void)customPressKey:(NSString *)key selectedRange:(NSRange)range type:(CLFormatFieldKeyType)type{
    NSString *text = _textField.text;
    if (type == CLFormatFieldKeyTypeDelete) {//删除事件
        if (range.location == 0) {
            return;
        }
        NSString *s = [text substringWithRange:NSMakeRange(range.location-1, 1)];
        if ([@" "isEqualToString:s]) {//如果删除的是空格，向前删除两个
            text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location-2, 2) withString:@""];
            range.location -= 2;
        }else{
            text = [text stringByReplacingCharactersInRange:NSMakeRange(range.location-1, 1) withString:@""];
            range.location -= 1;
        }
        _textField.text = text;
        [self formatText];
        if (_textField.text.length >= range.location) {
            [_textField setSelectedRange:NSMakeRange(range.location,0)];
        }
    }else{
        if ([self checkMaxLength] == false) {
            if (_delegate) {
                if ([_delegate respondsToSelector:@selector(CLFormatFieldTextValidateFail:msg:)]) {
                    [_delegate CLFormatFieldTextValidateFail:self msg:_lengthErrorMsg];
                }
            }
            return;
        }
        NSMutableString *string = [NSMutableString stringWithString:text];
        [string insertString:key atIndex:range.location];
        _textField.text = string;
        [self formatText];
        //移动光标
        if (text.length == range.location) {//1.当前光标最后时
            NSString *afterString = _textField.text;
            NSInteger upLength = afterString.length - text.length;//前后长度增加数量
            [_textField setSelectedRange:NSMakeRange(range.location+upLength,0)];
        }else{
            //2.当前光标中间时，且后方不是空格时
            BOOL isBeforeSpace = false;
            if (text.length > range.location) {
                NSString *s = [text substringWithRange:NSMakeRange(range.location, 1)];
                if ([@" "isEqualToString:s]) {
                    isBeforeSpace = true;
                }
            }
            if (isBeforeSpace) {
                [_textField setSelectedRange:NSMakeRange(range.location+2,0)];
            }else{
                //3.当前光标中间时，后方是空格时光标增加两位
                [_textField setSelectedRange:NSMakeRange(range.location+1,0)];
            }
        }
    }
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(CLFormatFieldTextValueDidChanged:)]) {
            [_delegate CLFormatFieldTextValueDidChanged:self];
        }
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.text = @"";
    return true;
}

-(void)textFieldDone{
    [UIApplication.sharedApplication.keyWindow endEditing:true];
}


@end
