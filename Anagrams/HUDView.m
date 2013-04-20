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
    
    hud.userInteractionEnabled = YES;
    
    UILabel *pts = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 340, 30, 140, 70)];
    pts.backgroundColor = [UIColor clearColor];
    pts.font = kFontHud;
    pts.text = @"Points:";
    [hud addSubview:pts];
    
    hud.gamePoints = [CounterLabelView labelWithFont:kFontHud frame:CGRectMake(kScreenWidth - 200, 30, 200, 70) andValue:0];
    hud.gamePoints.textColor = [UIColor colorWithRed:0.38 green:0.098 blue:0.035 alpha:1];
    [hud addSubview:hud.gamePoints];
    
    
    
    // load the button image
    UIImage *image = [UIImage imageNamed:@"btn"];
    // the help button
    hud.btnHelp = [UIButton buttonWithType:UIButtonTypeCustom];
    [hud.btnHelp setTitle:@"Hint!" forState:UIControlStateNormal];
    hud.btnHelp.titleLabel.font = kFontHud;
    [hud.btnHelp setBackgroundImage:image forState:UIControlStateNormal];
    hud.btnHelp.frame = CGRectMake(50, 30, image.size.width, image.size.height);
    hud.btnHelp.alpha = 0.8;
    [hud addSubview:hud.btnHelp];
    
    return hud;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    //1 let touches through and only catch the ones on buttons
    UIView *hitView = (UIView *)[super hitTest:point withEvent:event];
    if ([hitView isKindOfClass:[UIButton class]]) {
        return hitView;
    }
    return nil;
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
