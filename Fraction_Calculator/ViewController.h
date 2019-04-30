//
//  ViewController.h
//  Fraction_Calculator
//
//  Created by Civet on 2019/4/29.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel *display;

- (void)processDigit:(int) digit;
- (void)processOp:(char) theOp;
- (void)storeFracPart;

//数字键
- (IBAction) clickDigit:(UIButton *)sender;

//算术操作键
- (IBAction) clickPlus;
- (IBAction) clickMinus;
- (IBAction) clickMultiply;
- (IBAction) clickDivide;

//Misc键
- (IBAction) clickOver;
- (IBAction) clickEquals;
- (IBAction) clickClear;

@end

