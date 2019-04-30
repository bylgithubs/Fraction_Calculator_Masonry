//
//  Calculator.h
//  Fraction_Calculator
//
//  Created by Civet on 2019/4/29.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Fraction.h"

@interface Calculator : NSObject

@property (nonatomic, strong) Fraction *operand1;
@property (nonatomic, strong) Fraction *operand2;
@property (nonatomic, strong) Fraction *accumulator;

- (Fraction *) performOperation: (char) op;
- (void) clear;

@end
