//
//  TargetView.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/16/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "TargetView.h"

@implementation TargetView

- (id)initWithFrame:(CGRect)frame
{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
    NSAssert(NO, @"Use initWithLetter:andSideLength instead");
    return nil;
}

- (instancetype)initWithLetter:(NSString *)letter andSideLength:(float)sideLength {
    UIImage *img = [UIImage imageNamed:@"slot"];
    self = [super initWithImage:img];
    if (self != nil) {
        self.isMatched = NO;
        float scale = sideLength / img.size.width;
        self.frame = CGRectMake(0, 0, img.size.width * scale, img.size.height * scale);
        _letter = letter;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
