//
//  ViewController.m
//  Fraction_Calculator
//
//  Created by Civet on 2019/4/29.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "ViewController.h"

#import "Calculator.h"
#import "Masonry.h"
@interface ViewController ()

@property(nonatomic) char op;
@property(nonatomic) int currentNumber;
@property(nonatomic) BOOL firstOperand,isNumerator;
@property(nonatomic) Calculator *myCalculator;
@property(nonatomic) NSMutableString *displayString;
@property(nonatomic) UILabel *displayNum;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _firstOperand = YES;
    _isNumerator = YES;
    _displayString = [NSMutableString stringWithCapacity:40];
    _myCalculator =[[Calculator alloc]init];
    
    
    //申明区域，displayView是显示区域，keyboardView是键盘区域
    UIView *displayView = [UIView new];
    [displayView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:displayView];
    
    UIView *keyboardView = [UIView new];
    [self.view addSubview:keyboardView];
    
    //先按1：3分割 displView（显示结果区域）和 keyboardView（键盘区域）
    [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.and.right.equalTo(self.view);
        make.height.equalTo(keyboardView).multipliedBy(0.3f);
    }];
    
    [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(displayView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.and.right.equalTo(self.view);
        
    }];
    
    //设置显示位置的数字为0
    _displayNum = [[UILabel alloc]init];
    [displayView addSubview:_displayNum];
    _displayNum.text = @"0";
    _displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:40];
    _displayNum.textColor = [UIColor whiteColor];
    _displayNum.textAlignment = NSTextAlignmentRight;
    [_displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(displayView).with.offset(-10);
        make.bottom.equalTo(displayView).with.offset(-10);
    }];
    
    
    //定义键盘键名称，？号代表合并的单元格
    NSArray *keys = @[@"+",@"-",@"x",@"/"
                      ,@"7",@"8",@"9",@"Over"
                      ,@"4",@"5",@"6",@"C"
                      ,@"1",@"2",@"3",@"="
                      ,@"0",@"?",@".",@"?"];
    
    
    int indexOfKeys = 0;
    for (NSString *key in keys){
        //循环所有键
        indexOfKeys++;
        int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
        int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
        NSLog(@"index is:%d and row:%d,col:%d",indexOfKeys,rowNum,colNum);
        
        //键样式
        UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
        [keyboardView addSubview:keyView];
        [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [keyView setTitle:key forState:UIControlStateNormal];
  
        if (key == 0 || [key isEqualToString:@"1"] || [key isEqualToString:@"2"] ||
             [key isEqualToString:@"3"] || [key isEqualToString:@"4"] ||
             [key isEqualToString:@"5"] || [key isEqualToString:@"6"] ||
             [key isEqualToString:@"7"] || [key isEqualToString:@"8"] ||
             [key isEqualToString:@"9"] ){
            [keyView setTag:key.intValue];
            [keyView addTarget:self action:@selector(clickDigit:) forControlEvents:(UIControlEventTouchUpInside)];
        }
        else{
            if ([key isEqualToString:@"+"])
            {
                [keyView addTarget:self action:@selector(clickPlus) forControlEvents:(UIControlEventTouchUpInside)];
            }else if ([key isEqualToString:@"-"])
            {
                [keyView addTarget:self action:@selector(clickMinus) forControlEvents:(UIControlEventTouchUpInside)];
            }else if ([key isEqualToString:@"x"])
            {
                [keyView addTarget:self action:@selector(clickMultiply) forControlEvents:(UIControlEventTouchUpInside)];
            }else if ([key isEqualToString:@"/"])
            {
                [keyView addTarget:self action:@selector(clickDivide) forControlEvents:(UIControlEventTouchUpInside)];
            }else if ([key isEqualToString:@"="])
            {
                [keyView addTarget:self action:@selector(clickEquals) forControlEvents:(UIControlEventTouchUpInside)];
            }else if ([key isEqualToString:@"C"])
            {
                [keyView addTarget:self action:@selector(clickClear) forControlEvents:(UIControlEventTouchUpInside)];
            }else if ([key isEqualToString:@"Over"])
            {
                [keyView addTarget:self action:@selector(clickOver) forControlEvents:(UIControlEventTouchUpInside)];
            }
        }
        
        [keyView.layer setBorderWidth:1];
        [keyView.layer setBorderColor:[[UIColor blackColor]CGColor]];
        [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
        
        //键约束
        [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            //处理 0 合并单元格
            if([key isEqualToString:@"0"] || [key isEqualToString:@"?"] || [key isEqualToString:@"="] ){
                
                if([key isEqualToString:@"0"]){
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(.5);
                        make.left.equalTo(keyboardView.mas_left);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);

                    }];
                }
                else if([key isEqualToString:@"="]){
                    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(0.4f);
                        make.width.equalTo(keyboardView.mas_width).multipliedBy(0.25);
                        make.right.equalTo(keyboardView.mas_right);
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.8f);
                        //keyView.backgroundColor = [UIColor redColor];
                    }];
                }
                else if([key isEqualToString:@"?"]){
                    [keyView removeFromSuperview];
                }
                
            }
            //正常的单元格
            else{
                make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
                make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
                
                //按照行和列添加约束，这里添加行约束
                switch (rowNum) {
                    case 1:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.1f);
                        keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
                        
                    }
                        break;
                    case 2:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.3f);
                    }
                        break;
                    case 3:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.5f);
                    }
                        break;
                    case 4:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.7f);
                    }
                        break;
                    case 5:
                    {
                        make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
                    }
                        break;
                    default:
                        break;
                }
                //按照行和列添加约束，这里添加列约束
                switch (colNum) {
                    case 1:
                    {
                        make.left.equalTo(keyboardView.mas_left);
                        
                    }
                        break;
                    case 2:
                    {
                        make.right.equalTo(keyboardView.mas_centerX);
                        
                    }
                        break;
                    case 3:
                    {
                        make.left.equalTo(keyboardView.mas_centerX);
                    }
                        break;
                    case 4:
                    {
                        make.right.equalTo(keyboardView.mas_right);
                        [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
                    }
                        break;
                    default:
                        break;
                }
            }
        }];
   
    
}

}


- (void) processDigit:(int)digit{
    //NSLog(@"digit============%i",digit);
    _currentNumber = _currentNumber * 10 + digit;
    [_displayString appendString:[NSString stringWithFormat:@"%i", digit]];
    _displayNum.text = _displayString;
}

- (IBAction) clickDigit:(UIButton *)sender{
    int digit = (int)sender.tag;
    [self processDigit:digit];
}

- (void) processOp:(char)theOp{
    NSString *opStr;
    _op = theOp;
    switch (theOp) {
        case '+':
            opStr = @" + ";
            break;
        case '-':
            opStr = @" - ";
            break;
        case '*':
            opStr = @" * ";
            break;
        case '/':
            opStr = @" / ";
            break;
        default:
            break;
    }
    
    [self storeFracPart];
    _firstOperand = NO;
    _isNumerator = YES;
    [_displayString appendString:opStr];
    _displayNum.text =_displayString;
    
}

- (void) storeFracPart{
    NSLog(@"=============%@,%@,%d",_firstOperand?@"YES":@"NO",_isNumerator?@"YES":@"NO",_currentNumber);
    if (_firstOperand){
        if (_isNumerator){
            _myCalculator.operand1.numerator = _currentNumber;
            _myCalculator.operand1.denominator = 1;
        }else{
            _myCalculator.operand1.denominator = _currentNumber;
        }
    }else if (_isNumerator){
        _myCalculator.operand2.numerator = _currentNumber;
        _myCalculator.operand2.denominator = 1;
    }else{
        _myCalculator.operand2.denominator = _currentNumber;
        _firstOperand = YES;
    }
    _currentNumber = 0;
}

- (IBAction) clickOver{
    [self storeFracPart];
    _isNumerator = NO;
    [_displayString appendString:@"/"];
    _displayNum.text = _displayString;
}

//算术操作键
- (IBAction) clickPlus{
    [self processOp: '+'];
}

- (IBAction) clickMinus{
    [self processOp: '-'];
}

- (IBAction) clickMultiply{
    [self processOp: '*'];
}

- (IBAction) clickDivide{
    [self processOp: '/'];
}

//Misc键
- (IBAction) clickEquals{
    if (_firstOperand == NO){
        [self storeFracPart];
        [_myCalculator performOperation:_op];
        
        [_displayString appendString: @" = "];
        [_displayString appendString: [_myCalculator.accumulator convertToString]];
        _displayNum.text = _displayString;
        
        _currentNumber = 0;
        _isNumerator = YES;
        _firstOperand = YES;
        [_displayString setString: @""];
    }
}

- (IBAction) clickClear{
    _isNumerator = YES;
    _firstOperand = YES;
    _currentNumber = 0;
    [_myCalculator clear];
    
    [_displayString setString: @""];
    _displayNum.text = _displayString;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
