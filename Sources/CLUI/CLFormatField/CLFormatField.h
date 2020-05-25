//
//  CLFormatField.h
//  FormatFieldDemo
//
//  Created by lion on 2020/4/29.
//  Copyright © 2020 lion. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    CLFormatFieldTypeDef = 0,
    CLFormatFieldTypeMobilePhone = 1,
    CLFormatFieldTypeBankCard = 2,
    CLFormatFieldTypeIDCard = 3,
    CLFormatFieldTypeSMS = 4,
    CLFormatFieldTypeNumber = 5,
}CLFormatFieldType;

typedef enum{
    CLFormatFieldKeyTypeDef = 0,
    CLFormatFieldKeyTypeDelete = 1,
}CLFormatFieldKeyType;

@interface CLFormatField : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(CLFormatFieldType)type;

-(void)customPressKey:(NSString *)key selectedRange:(NSRange)range type:(CLFormatFieldKeyType)type;

-(BOOL)checkFormat;
-(BOOL)checkMaxLength;

-(NSRange)selectedRange;
-(void)setSelectedRange:(NSRange)range;

@property(nonatomic,strong)UITextField *textField;
@property(nonatomic,assign)CLFormatFieldType fieldType;
@property(nonatomic,assign)float fieldPaddingX;
@property(nonatomic,assign)float maxTextLength;
@property(nonatomic,strong)NSString *placeHolder;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,strong)UIColor *textColor;
@property(nonatomic,assign)BOOL secureTextEntry;
@property(nonatomic,assign)BOOL endEditing;
@property(nonatomic,assign)BOOL enabled;
@property(nonatomic,strong)UIView *inputView;

@property(nonatomic,assign)UITextFieldViewMode clearButtonMode;

@property(nonatomic,strong)NSString *lengthErrorMsg;
@property(nonatomic,strong)NSString *formatErrorMsg;

@property(nonatomic,assign)id delegate;
@end


@protocol CLFormatFieldDelegate <NSObject>

-(void)CLFormatFieldTextFieldDidBeginEditing:(CLFormatField *)formatField;
-(void)CLFormatFieldTextFieldDidEndEditing:(CLFormatField *)formatField;

@optional
-(void)CLFormatFieldTextValueDidChanged:(CLFormatField *)formatField;

@optional
-(void)CLFormatFieldTextValidateFail:(CLFormatField *)formatField msg:(NSString *)msg;
@end
