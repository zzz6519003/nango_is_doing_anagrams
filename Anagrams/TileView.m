//
//  TileView.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/15/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "TileView.h"
#import "config.h"

@implementation TileView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        NSAssert(NO, @"Use initWithLetter:andSideLength instead");
        return nil;
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

//2 create new tile for a given letter
- (instancetype)initWithLetter:(NSString *)letter andSideLength:(float)sideLength {
    UIImage *img = [UIImage imageNamed:@"tile.png"];
    self = [super initWithImage:img];
    if (self != nil) {
        float scale = sideLength / img.size.width;
        self.frame = CGRectMake(0, 0, img.size.width *scale, img.size.height * scale);
        
        UILabel *lblChar = [[UILabel alloc] initWithFrame:self.bounds];
        lblChar.textAlignment = NSTextAlignmentCenter;
        lblChar.textColor = [UIColor whiteColor];
        lblChar.backgroundColor = [UIColor clearColor];
        lblChar.text = [letter uppercaseString];
        lblChar.font = [UIFont fontWithName:@"Verdana-Bold" size:78.0 * scale];
        
        [self addSubview:lblChar];
        
        self.isMatched = NO;
        _letter = letter;
    }
    return self;
}

- (void)randomize {
    float rotation = randomf(0, 50) / (float)100 - 0.2;
    self.transform = CGAffineTransformMakeRotation(rotation);
    
    int yOffset = (arc4random() % 10) - 10;
    self.center = CGPointMake(self.center.x, self.center.y + yOffset);
}

@end
