//
//  Fraction.h
//  Fraction_Calculator
//
//  Created by Civet on 2019/4/29.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fraction : NSObject

@property int numerator, denominator;

- (void) print;
- (void) setTo: (int) n over: (int) d;
- (Fraction *) add: (Fraction *) f;
- (Fraction *) subtract: (Fraction *) f;
- (Fraction *) multiply: (Fraction *) f;
- (Fraction *) divide: (Fraction *) f;
- (void) reduce;
- (double) convertToNum;
- (NSString *) convertToString;


@end
