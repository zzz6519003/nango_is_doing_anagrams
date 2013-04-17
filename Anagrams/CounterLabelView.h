//
//  CounterLabelView.h
//  Anagrams
//
//  Created by Snowmanzzz on 4/17/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CounterLabelView : UILabel

@property (assign, nonatomic) int value;
//value is a property that will hold the score currently shown on the label.


+ (instancetype)labelWithFont:(UIFont *)font frame:(CGRect)r andValue:(int)v;
//labelWithFont:frame:andValue: is a class method that will return a new CounterLabelView initialized with the given frame, font and value.


- (void)countTo:(int)to withDuration:(float)t;
//countTo:withDuration: will animate the label’s text, counting up or down to/from the current value to the one provided. The animation will have the given duration in seconds.


@end
