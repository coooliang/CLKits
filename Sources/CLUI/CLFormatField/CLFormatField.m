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

#define FIELD_TEXT_COLOR ([UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha:1/1.0])
//#define FIELD_BG_COLOR ([UIColor colorWithRed:240/255.0 green:243/255.0 blue:246/255.0 alpha:1])
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
//    self.layer.cornerRadius = 5;
//    self.layer.borderWidth = (1/[UIScreen mainScreen].scale);
//    self.layer.borderColor = ([UIColor colorWithRed:0.871 green:0.871 blue:0.871 alpha:1]).CGColor;
//    self.layer.masksToBounds = true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledValueDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
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
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1/1.0],NSFontAttributeName:[UIFont fontWithName:@"PingFangSC-Regular" size:18]}];
    _textField.attributedPlaceholder = attrString;
}

-(NSString *)getPlaceHolder{
    return _textField.placeholder;
}

-(void)setText:(NSString *)text{
    _textField.text = text;
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

- (void)setFieldType:(CLFormatFieldType)fieldType{
    _fieldType = fieldType;
    switch (fieldType) {
        case CLFormatFieldTypeMobilePhone:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 11;
        }
            break;
        case CLFormatFieldTypeBankCard:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 19;
        }
            break;
        case CLFormatFieldTypeIDCard:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 18;
        }
            break;
        case CLFormatFieldTypeSMS:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 6;
        }
            break;
        case CLFormatFieldTypeNumber:{
            _textField.keyboardType = UIKeyboardTypeNumberPad;
            _maxTextLength = 64;
        }
            break;
        default:{
            _textField.keyboardType = UIKeyboardTypeDefault;
            _maxTextLength = 64;
        }
            break;
    }
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
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
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
            return [NSString isMobilePhone:text];
        }
            break;
        case CLFormatFieldTypeBankCard:{
            return [NSString isBankCard:text];
        }
            break;
        case CLFormatFieldTypeIDCard:{
            return [NSString isIDCard:text];
        }
            break;
        case CLFormatFieldTypeSMS:{
            return [NSString isSMS:text];
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
    
    if([self checkFormat] == false){
        if (_delegate) {
            if ([_delegate respondsToSelector:@selector(CLFormatFieldTextValidateFail:msg:)]) {
                [_delegate CLFormatFieldTextValidateFail:self msg:_formatErrorMsg];
            }
        }
    }
}

-(void)customPressKey:(NSString *)key selectedRange:(NSRange)range type:(CLFormatFieldKeyType)type{
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(CLFormatFieldTextValueDidChanged:)]) {
            [_delegate CLFormatFieldTextValueDidChanged:self];
        }
    }
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
    }
}

@end
