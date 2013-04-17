//
//  HUDView.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/17/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "HUDView.h"
#import "config.h"

@implementation HUDView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (instancetype)viewWithRect:(CGRect)r {
    HUDView *hud = [[HUDView alloc] init];
    
    hud.stopwatch = [[StopwatchView alloc] initWithFrame: CGRectMake(kScreenWidth / 2 - 150, 0, 300, 100)];

    
    hud.stopwatch.seconds = 0;
    [hud addSubview:hud.stopwatch];
    
    hud.userInteractionEnabled = NO;
    return hud;
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
