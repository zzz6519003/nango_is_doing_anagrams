//
//  GameController.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/15/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "GameController.h"
#import "config.h"
#import "TileView.h"


@implementation GameController {
    NSMutableArray *_tiles;
    NSMutableArray *_targets;
    int _secondsLeft;
    NSTimer *_timer;
}

- (instancetype)init {
    self = [super init];
    if (self != nil) {
        // initialize
        self.data = [[GameData alloc] init];
    }
    return self;
}

//fetches a random anagram, deals the letter tiles and creates the targets
- (void)dealRandomAnagram {
    NSAssert(self.level.anagrams, @"no level loaded");
    // random anagram
    int randomIndex = arc4random() % [self.level.anagrams count];
    NSArray *anaPair = self.level.anagrams[randomIndex];
    
    NSString *anagram1 = anaPair[0];
    NSString *anagram2 = anaPair[1];
    
    int ana1length = [anagram1 length];
    int ana2length = [anagram2 length];
    
    NSLog(@"phrase1[%i]: %@", ana1length, anagram1);
    NSLog(@"phrase2[%i]: %@", ana2length, anagram2);

    
    // calculate the tile size
//    float tileSide = ceilf(kScreenWidth)
    //calculate the tile size
    float tileSide = ceilf( kScreenWidth*0.9 / (float)MAX(ana1length, ana2length) ) - kTileMargin;
    
    float xOffset = (kScreenWidth - MAX(ana1length, ana2length) * (tileSide + kTileMargin)) / 2;
    
    // adjust for tile center
    xOffset += tileSide / 2;
    

    _tiles = [NSMutableArray arrayWithCapacity:ana1length];
    
    for (int i = 0; i < ana1length; i++) {
        NSString *letter = [anagram1 substringWithRange:NSMakeRange(i, 1)];
        
        if (![letter isEqualToString:@" "]) {
            TileView *tile = [[TileView alloc] initWithLetter:letter andSideLength:tileSide];
            tile.center = CGPointMake(xOffset + i * (tileSide + kTileMargin), kScreenHeight / 4 * 3);
            [tile randomize];
            
            tile.dragDelegate = self;
            // 4
            [self.gameView addSubview:tile];
            [_tiles addObject:tile];
        }
    }
    
    _targets = [NSMutableArray arrayWithCapacity:ana2length];
    
    for (int i = 0; i < ana2length; i++) {
        NSString *letter = [anagram2 substringWithRange:NSMakeRange(i, 1)];
        if (![letter isEqualToString:@" "]) {
            TargetView *target = [[TargetView alloc] initWithLetter:letter andSideLength:tileSide];
            target.center = CGPointMake(xOffset + i * (tileSide + kTileMargin), kScreenHeight / 4);
            [self.gameView addSubview:target];
            [_targets addObject:target];
        }
    }

    [self startStopwatch];
}

// a tile was dragged, check if matches a target
- (void)tileView:(TileView *)tileView didDragToPoint:(CGPoint)pt {
    TargetView *targetView = nil;
    for (TargetView *tv in _targets) {
        if (CGRectContainsPoint(tv.frame, pt)) {
            targetView = tv;
            break;
        }
    }
    if (targetView != nil) {
        if ([targetView.letter isEqualToString:tileView.letter]) {
            NSLog(@"Success! You should place the tile here!");
            [self placeTile:tileView atTarget:targetView];

            self.data.points += self.level.pointsPerTile;


        } else {
            NSLog(@"Failure. Let the player know this tile doesn't belong here.");
            [tileView randomize];
            [UIView animateWithDuration:0.35
                                  delay:0.00
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 tileView.center = CGPointMake(tileView.center.x + randomf(-20, 20), tileView.center.y + randomf(-20, 20));
                             } completion:nil];
            self.data.points -= self.level.pointsPerTile / 2;

        }
        [self checkForSuccess];

    }
}

- (void)placeTile:(TileView *)tileView atTarget:(TargetView *)targetView {
    NSLog(@"s");

    targetView.isMatched = YES;
    tileView.isMatched = YES;
    
    tileView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.35
                          delay:0.00
                        options:UIViewAnimationOptionCurveEaseOut animations:^{
                            tileView.center = targetView.center;
                            tileView.transform = CGAffineTransformIdentity;
                        } completion:^(BOOL finished) {
                            targetView.hidden = YES;
                        }];
}

- (void)checkForSuccess {
    for (TargetView *t in _targets) {
        if (t.isMatched == NO) return;
    }
    NSLog(@"game over");
}

- (void)startStopwatch {
    _secondsLeft = self.level.timeToSolve;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
}

- (void)stopStopwatch {
    [_timer invalidate];
    _timer = nil;
}

//stopwatch on tick
- (void)tick:(NSTimer *)timer {
    _secondsLeft--;
    [self.hud.stopwatch setSeconds:_secondsLeft];
    if (_secondsLeft == 0) {
        [self stopStopwatch];
    }
}
@end
