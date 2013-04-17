//
//  CounterLabelView.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/17/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "CounterLabelView.h"

@implementation CounterLabelView {
    int endValue;
    double delta;
}

//create an instance of the counter label
+ (instancetype)labelWithFont:(UIFont *)font frame:(CGRect)r andValue:(int)v {
    CounterLabelView *label = [[CounterLabelView alloc] initWithFrame:r];
    if (label != nil) {
        label.backgroundColor = [UIColor clearColor];
        label.font = font;
        label.value = v;
        
    }
    return label;
}

- (void)setValue:(int)value {
    _value = value;
    self.text = [NSString stringWithFormat:@" %i", self.value];
}

- (void)updateValueBy:(NSNumber *)valueDelta {
    // update the property
    self.value += [valueDelta intValue];
    // check for reaching the end value
    if ([valueDelta intValue] > 0) {
        if (self.value > endValue) {
            self.value = endValue;
            return;
        }
    } else {
        if (self.value < endValue) {
            self.value = endValue;
            return;
        }
    }
    // if not  do it again
//    [self perfor]
    [self performSelector:@selector(updateValueBy:) withObject:valueDelta afterDelay:delta];
}

//count to a given value
- (void)countTo:(int)to withDuration:(float)t {
    //1 detect the time for the animation
    delta = t/(abs(to-self.value)+1);
    
    if (delta < 0.05) {
        delta = 0.05;
    }
    //2 set the end value
    endValue = to;
    //3 cancel previous scheduled actions
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (to - self.value > 0) {
        [self updateValueBy:@1];
    } else {
        [self updateValueBy:@-1];
    }
    
}
@end
