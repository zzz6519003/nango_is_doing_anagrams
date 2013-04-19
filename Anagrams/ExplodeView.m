//
//  ExplodeView.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/18/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "ExplodeView.h"
#import <QuartzCore/QuartzCore.h>

@implementation ExplodeView {
    CAEmitterLayer *_emitter;
}

// with the other methods
+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//    }
//    return self;
    self = [super initWithFrame:frame];
    if (self) {
        _emitter = (CAEmitterLayer *)self.layer;
        _emitter.emitterPosition = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
        _emitter.emitterSize = self.bounds.size;
        _emitter.emitterMode = kCAEmitterLayerAdditive;
        _emitter.emitterShape = kCAEmitterLayerRectangle;
    }
    return self;
}

- (void)didMoveToSuperview {
    // 1
    [super didMoveToSuperview];
    if (self.superview == nil) return;
    
    UIImage *texture = [UIImage imageNamed:@"particle.png"];
    NSAssert(texture, @"particle png not found");
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    
    emitterCell.contents = (__bridge id)[texture CGImage];
    
    emitterCell.name = @"cell";
    
    emitterCell.birthRate = 1000;
    emitterCell.lifetime = 0.75;
    
    emitterCell.blueRange = 0.33;
    emitterCell.blueSpeed = -0.33;
    
    emitterCell.velocity = 160;
    emitterCell.velocityRange = 40;
    
    emitterCell.scaleRange = 0.5;
    emitterCell.scaleSpeed = -0.2;
    
    emitterCell.emissionRange = M_PI * 2;
    
    _emitter.emitterCells = @[emitterCell];
    
    [self performSelector:@selector(disableEmitterCell) withObject:nil afterDelay:0.1];
    [self performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:2.0];
}

- (void)disableEmitterCell {
    [_emitter setValue:@0 forKey:@"emitterCell.cell.birthRate"];
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
