//
//  CLKeyboardView.m
//  CLKits
//
//  Created by lion on 2020/9/28.
//  Copyright © 2020 chenl. All rights reserved.
//

#import "CLKeyboardView.h"
#import "CLKeyboardButton.h"

#import "EnvConstant.h"
#import "JKSizeFix.h"

#define kNumFont [UIFont systemFontOfSize:27]
#define textfield_height 40
#define tool_height 44
#define btn_height (JKFixHeightFloat(54))
#define keyboard_height (JKFixHeightFloat(216))

@interface CLKeyboardView()

@property(nonatomic,strong) UITextField *numberFiled;
@property(nonatomic,strong) AmountRuler *amountRuler;

@end

@implementation CLKeyboardView{
    NSMutableArray *_numArray;
    
    float _btnWidth;
    float _selfHeight;
    float _selfY;
    float _keyboardY;
}

#pragma mark - init
-(void)initParameters:(CLKeyboardModel *)model{
    _numArray = [NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"]];
    if (model.hideToolbar) {
        _selfHeight = keyboard_height;
    }else{
        _selfHeight = keyboard_height + tool_height;
    }
    _selfY = HEIGHT - _selfHeight;
    _keyboardY = HEIGHT - keyboard_height;
    
    if (model.type == CLKeyboardTypeScroll) {
        _btnWidth = WIDTH/4;
        _selfHeight += textfield_height;
        _selfY -= textfield_height;
    }else{
        _btnWidth = WIDTH/3;
    }
}

-(instancetype)initWithModel:(CLKeyboardModel *)model{
    _model = model;
    [self initParameters:model];
    CGRect frame = CGRectMake(0,HEIGHT,WIDTH,_selfHeight);
    self  = [self initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.userInteractionEnabled = YES;
        if (model.type == CLKeyboardTypeScroll) {
            [self createScrollView:frame];
        }else{
            [self createKeyboardView:frame];
        }
    }
    return self;
}

#pragma mark - show and hide
-(void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = CGRectMake(0, self->_selfY,WIDTH,self->_selfHeight);
        self.frame = frame;
    } completion:nil];
}

-(void)hide{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = CGRectMake(0, HEIGHT,WIDTH,self->_selfHeight);
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - keyboard view
-(void)createKeyboardView:(CGRect)frame{
    if (_model.hideToolbar == false) {
        [self addToolBar];
    }
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, _keyboardY-_selfY, WIDTH, keyboard_height)];
    for (int i=0; i<4; i++){
        for (int j=0; j<3; j++){
            CLKeyboardButton *button = [self createButtonX:i Y:j];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:button];
        }
    }
    [self addSubview:view];
    
    //add lines
    UIColor *color = [UIColor colorWithRed:188/255.0 green:192/255.0 blue:199/255.0 alpha:1];
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(_btnWidth, 0, ONE_SCALE, keyboard_height)];
    line1.backgroundColor = color;
    [view addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(_btnWidth*2, 0, ONE_SCALE, keyboard_height)];
    line2.backgroundColor = color;
    [view addSubview:line2];
    
    for (int i=0; i<4; i++){
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, btn_height*i, WIDTH, ONE_SCALE)];
        line.backgroundColor = color;
        [view addSubview:line];
    }
}

-(void)addToolBar{
    UIView *tool = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, tool_height)];
    tool.backgroundColor = [UIColor whiteColor];
    
    UIButton *sureButton = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 0, 40, tool_height)];
    [sureButton setImage:[UIImage imageNamed:@"keyboard_done"] forState:UIControlStateNormal];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureButton setTitleColor:BUTTON_NORMAL_COLOR forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [tool addSubview:sureButton];
    
    UIColor *color = [UIColor colorWithRed:188/255.0 green:192/255.0 blue:199/255.0 alpha:1];
    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, ONE_SCALE)];
    topLine.backgroundColor = color;
    [tool addSubview:topLine];

    [self addSubview:tool];
}
-(CLKeyboardButton *)createButtonX:(NSInteger) x Y:(NSInteger) y{
    CGFloat frameX = 0.0;
    CGFloat frameW = 0.0;
    switch (y){
        case 0:
            frameX = 0.0;
            frameW = _btnWidth;
            break;
        case 1:
            frameX = _btnWidth;
            frameW = _btnWidth;
            break;
        case 2:
            frameX = _btnWidth*2;
            frameW = _btnWidth;
            break;
    }
    CGFloat frameY = btn_height*x;
    
    CLKeyboardButton *button = [[CLKeyboardButton alloc]initWithFrame:CGRectMake(frameX, frameY, frameW, btn_height)];
    
    long num = y+3*x+1;
    button.tag = num;
    
    UIColor *colorNormal = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    
    UIColor *colorHightlighted = IMAGE_BG_COLOR;
    
    if ((num == 10 || num == 12) && !(_model.type == CLKeyboardTypeScroll)){
        colorHightlighted = colorNormal;
        colorNormal = IMAGE_BG_COLOR;
    }
    button.backgroundColor = colorNormal;
    CGSize imageSize = CGSizeMake(frameW, btn_height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorHightlighted set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [button setImage:pressedColorImg forState:UIControlStateHighlighted];
    
    if (num < 10){
        num = [self getRandomNumber:num];
        UILabel *labelNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frameW, btn_height)];
        labelNum.backgroundColor = [UIColor clearColor];
        labelNum.text = [NSString stringWithFormat:@"%ld",num];
        labelNum.textColor = [UIColor blackColor];
        labelNum.textAlignment = NSTextAlignmentCenter;
        labelNum.font = kNumFont;
        button.value = [NSString stringWithFormat:@"%ld",num];
        [button addSubview:labelNum];
    }else if (num == 11){
        num = [self getRandomNumber:0];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0,0 , frameW, btn_height)];
        label.text = [NSString stringWithFormat:@"%ld",num];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = kNumFont;
        button.value = [NSString stringWithFormat:@"%ld",num];
        [button addSubview:label];
    }else if (num == 10){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frameW, btn_height)];
        label.font = kNumFont;
        if(_model.type == CLKeyboardTypeFloat){
            label.text = @".";
        }else if(_model.type == CLKeyboardTypeIDCard){
            label.text = @"X";
        }else{
            label.text = @"";
            label.enabled = NO;
            button.enabled = NO;
        }
        
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        [button addSubview:label];
    }else{
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 17)];
        arrow.image = [UIImage imageNamed:@"arrowInKeyboard"];
        CGRect temp = arrow.frame;
        temp.origin.x = (_btnWidth - 22)/2;
        temp.origin.y = (btn_height - 17)/2;
        arrow.frame = temp;
        [button addSubview:arrow];
    }
    return button;
}

-(long)getRandomNumber:(long)num{
    if (_model.isRandom) {
        int index = arc4random()%[_numArray count];
        long randomTag = [[_numArray objectAtIndex:index]integerValue];
        [_numArray removeObjectAtIndex:index];
        return randomTag;
    }
    return num;
}

#pragma mark - scroll view
-(void)createScrollView:(CGRect)frame{
    _model.hideToolbar = false;//scorll view 总是有tool bar
    if ([@""isEqualToString:safeString(_model.minAmount)]) {
        _model.minAmount = @"0";
    }
    if ([@""isEqualToString:safeString(_model.maxAmount)]) {
        _model.maxAmount = @"100";
    }
    if ([@""isEqualToString:safeString(_model.average)]) {
        _model.average = @"10";
    }
    
    [self createNumberField];
    [self createKeyboardView:frame];
    [self createRightViewWithMinAmount:_model.minAmount andMaxAmount:_model.maxAmount andAverage:_model.average];
}
-(void)createNumberField{
    UIImageView *bgimageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, tool_height, WIDTH, textfield_height)];
    _numberFiled = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, WIDTH-20, textfield_height)];
    _numberFiled.delegate = self;
    _numberFiled.adjustsFontSizeToFitWidth = YES;
    _numberFiled.borderStyle = UITextBorderStyleNone;
    _numberFiled.textAlignment =  NSTextAlignmentRight;
    _numberFiled.font =[UIFont systemFontOfSize:25];
    _numberFiled.text = _model.text;
    _numberFiled.inputView = nil;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"numberBg"]];
    image.frame = CGRectMake(0, 0, WIDTH, textfield_height);
    [bgimageview addSubview:image];
    [bgimageview addSubview:_numberFiled];
    [self addSubview:bgimageview];
}
-(void)createRightViewWithMinAmount:(NSString *)minAmount andMaxAmount:(NSString *)maxAmount andAverage:(NSString *)average{
    float y = _keyboardY-_selfY;
    self.amountRuler = [[AmountRuler alloc] initWithFrame:CGRectMake(_btnWidth * 3, y, _btnWidth, btn_height * 3)];
    [self.amountRuler showRulerScrollViewWithMinAmount:minAmount maxAmount:maxAmount average:average];
    self.amountRuler.rulerDelegate = self;
    [self addSubview:self.amountRuler];
    
    UIView *leftLine = [[UIView alloc] initWithFrame:CGRectMake(_btnWidth * 3, y, ONE_SCALE, btn_height * 4)];
    [leftLine setBackgroundColor: [UIColor colorWithRed:0.737  green:0.753  blue:0.780 alpha:1]];
    [self addSubview:leftLine];

    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(_btnWidth * 3, y, WIDTH - _btnWidth * 3, 1/[UIScreen mainScreen].scale)];
    [topLine setBackgroundColor: [UIColor colorWithRed:0.737  green:0.753  blue:0.780 alpha:1]];
    [self addSubview:topLine];
    
    UIButton *confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(_btnWidth * 3, btn_height * 3+y, _btnWidth, btn_height)];
    [confirmBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    
    confirmBtn.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    CGSize imageSize = CGSizeMake(CGRectGetWidth(confirmBtn.frame), btn_height);
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [IMAGE_BG_COLOR set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [confirmBtn setImage:pressedColorImg forState:UIControlStateHighlighted];
    
    UILabel *labelNum = [[UILabel alloc] initWithFrame:confirmBtn.bounds];
    labelNum.backgroundColor = [UIColor clearColor];
    labelNum.text = @"完成";
    labelNum.textColor = [UIColor colorWithRed:1 green:0.455 blue:0.267 alpha:1];
    labelNum.textAlignment = NSTextAlignmentCenter;
    labelNum.font = [UIFont systemFontOfSize:18];
    [confirmBtn addSubview:labelNum];
    
    UIView *topBtnLine = [[UIView alloc] initWithFrame:CGRectMake(_btnWidth * 3, btn_height * 3+y, WIDTH - _btnWidth * 3, 1/[UIScreen mainScreen].scale)];
    [topBtnLine setBackgroundColor:[UIColor colorWithRed:0.737  green:0.753  blue:0.780 alpha:1]];
    [self addSubview:topBtnLine];
    
    UIView *leftBtnLine = [[UIView alloc] initWithFrame:CGRectMake(_btnWidth * 3, btn_height * 3+y, 1/[UIScreen mainScreen].scale, btn_height)];
    [leftBtnLine setBackgroundColor:[UIColor colorWithRed:0.737  green:0.753  blue:0.780 alpha:1]];
    [self addSubview:leftBtnLine];
}

- (void)getAmountRulerValue:(CGFloat)rulerValue{
    if (rulerValue == (int)rulerValue) {
        _numberFiled.text = [NSString stringWithFormat:@"%.0f",rulerValue];
    }else{
        _numberFiled.text = [NSString stringWithFormat:@"%.2f",rulerValue];
    }
    
//    if(_delegate != nil && [_delegate isKindOfClass:[NumberKeyBoardPlugin class]]){
//        NumberKeyBoardPlugin *temp = (NumberKeyBoardPlugin*)_delegate;
//        NSString *script = [NSString stringWithFormat:@"var _dataInput = $('#%@'); var maxLen=_dataInput.attr('maxlength'); maxLen=typeof(maxLen) == 'undefined' || maxLen == null ? %d : maxLen; _dataInput.val('%@'.substring(0, maxLen));if(typeof(_dataInput[0].oninput) != 'undefined'){var ev = document.createEvent('HTMLEvents');ev.initEvent('input', false, true);_dataInput[0].dispatchEvent(ev);}if(typeof(_dataInput[0].onpropertychange) != 'undefined'){var ev = document.createEvent('HTMLEvents');ev.initEvent('propertychange', false, true);_dataInput[0].dispatchEvent(ev);}if(_dataInput.attr('alt') == 'cardNo'){_dataInput.val(getCardNo(_dataInput.val()));}",_nid,(int)_numberFiled.text.length,_numberFiled.text];
//        [temp.webView stringByEvaluatingJavaScriptFromString:script];
//    }
}

#pragma mark - click and callback
-(void)buttonClick:(CLKeyboardButton *)sender{
    if (sender.tag == 10){
        [self.delegate performSelector:@selector(CLKeyboardOtherButton:) withObject:sender.value];
    }else if(sender.tag == 12){
        [self.delegate performSelector:@selector(CLKeyboardBackspace)];
    }else{
        [self.delegate performSelector:@selector(CLKeyboardInput:) withObject:sender.value];
    }
}

-(void)sure{
    [self sure:^{
        [self removeFromSuperview];
    }];
}

-(void)sure:(void(^)(void))finishBlock{
    [self closeKeyboard:^{
//        if(self->_delegate != nil && [self->_delegate isKindOfClass:[NumberKeyBoardPlugin class]]){
//            NumberKeyBoardPlugin *temp = (NumberKeyBoardPlugin*)self->_delegate;
//            if (![@""isEqualToString:self->_nid]) {
//                [temp.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"var el=document.getElementById('%@');if(el.onblur){el.onblur();}if(eval('window.assignScrollCenter')){assignScrollCenter();}",self->_nid]];
//            }
//            self->_numberFiled.text = @"";
//        }
        if (finishBlock) {
            finishBlock();
        }
    }];
}

-(void)closeKeyboard:(void(^)(void))finishBlock{
//    if(_delegate != nil && [_delegate isKindOfClass:[NumberKeyBoardPlugin class]]){
//        NumberKeyBoardPlugin *temp = (NumberKeyBoardPlugin *)_delegate;
//        for (UIView *view in [temp.webView.superview subviews]) {//越狱键盘BUG修改
//            if([view isKindOfClass:[UIToolbar class]]){
//                [view removeFromSuperview];
//            }
//        }
//        [temp scrollWebView:NO];
//    }
    [UIView animateWithDuration:0.2 animations:^{
        CGRect temp = self.frame;
        temp.origin.y = HEIGHT;
        self.frame = temp;
    } completion:^(BOOL finished) {
        if(finishBlock != nil){
            finishBlock();
        }
    }];
}

-(void)close:(void(^)(void))finishBlock{
    [self closeKeyboard:^{
//        if(self->_delegate != nil && [self->_delegate isKindOfClass:[NumberKeyBoardPlugin class]]){
//            NumberKeyBoardPlugin *temp = (NumberKeyBoardPlugin*)self->_delegate;
//            [temp.webView stringByEvaluatingJavaScriptFromString:@"if(eval('window.assignScrollCenter')){assignScrollCenter();}"];
//        }
        if (finishBlock) {
            finishBlock();
        }
    }];
}

-(void)del{
    _numberFiled.text = @"";
}
@end
