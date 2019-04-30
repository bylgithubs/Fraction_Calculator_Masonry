//
//  Fraction.m
//  Fraction_Calculator
//
//  Created by Civet on 2019/4/29.
//  Copyright © 2019年 PandaTest. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

- (void) setTo:(int)n over:(int)d{
    _numerator = n;
    _denominator = d;
}

- (void) print{
    NSLog(@"%i/%i",_numerator,_denominator);
}

- (double) convertToNum{
    if (_denominator != 0){
        return  (double)_numerator/_denominator;
    }else{
        return NAN;
    }
}

- (NSString *) convertToString{
    if (_numerator == _denominator){
        if (_numerator == 0)
            return @"0";
        else
            return @"1";
    }else if (_denominator == 1)
        return [NSString stringWithFormat:@"%i", _numerator];
    else
        return [NSString stringWithFormat:@"%i/%i",_numerator,_denominator];
}

//添加一个分数到消息的接受器
- (Fraction *) add:(Fraction *)f{
    //将两个分数相加；
    //a/b + ((a*d) + (b*c)) / (b*d)
    //存储相加后的结果
    Fraction *result = [[Fraction alloc] init];
    result.numerator = _numerator * f.denominator + _denominator * f.numerator;
    result.denominator = _denominator * f.denominator;
    [result reduce];
    return result;
}

- (Fraction *) subtract:(Fraction *)f{
    //将两个分数相减
    // a/b - c/d = ((a*d) - (b*c) / (b*d)
    Fraction *result = [[Fraction alloc] init];
    result.numerator = _numerator * f.denominator - _denominator * f.numerator;
    result.denominator = _denominator * f.denominator;
    [result reduce];
    return result;
}

- (Fraction *) multiply:(Fraction *)f{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = _numerator * f.numerator;
    result.denominator = _denominator * f.denominator;
    [result reduce];
    return result;
}

- (Fraction *) divide:(Fraction *)f{
    Fraction *result = [[Fraction alloc] init];
    result.numerator = _numerator * f.denominator;
    result.denominator = _denominator * f.numerator;
    [result reduce];
    return result;
}

- (void) reduce{
    int u = _numerator;
    int v = _denominator;
    int temp;
    NSLog(@"numerator,denominator===========%i,%i",_numerator,_denominator);
    if (u == 0)
        return;
    else if(u < 0)
        u = -u;
    //8/32 u=32 v=8    u=8 v=0   12 21 7 12
    while (v != 0){
        temp = u % v;
        u = v;
        v = temp;
    }
    _numerator /= u;
    _denominator /= u;
    NSLog(@"numerator1,denominator1===========%i,%i",_numerator,_denominator);
}

@end


