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
#import "ExplodeView.h"
#import "StarDustView.h"

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
        self.audioController = [[AudioController alloc] init];
        [self.audioController preloadAudioEffects:kAudioEffectFiles];
        [self.audioController playEffect: kSoundIlike];

        
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
            [self.hud.gamePoints countTo:self.data.points withDuration:1.5];
            [self.audioController playEffect: kSoundDing];

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
            [self.hud.gamePoints countTo:self.data.points withDuration:.75];
//            [self.audioController playEffect:kSoundWrong];


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
    
    ExplodeView *explode = [[ExplodeView alloc] initWithFrame:CGRectMake(tileView.center.x, tileView.center.y, 10, 10)];
    [tileView.superview addSubview:explode];
    [tileView.superview sendSubviewToBack:explode];
}

- (void)checkForSuccess {
    for (TargetView *t in _targets) {
        if (t.isMatched == NO) return;
    }
    NSLog(@"game over");
    
    // win animation
    //win animation
    TargetView* firstTarget = _targets[0];
    
    int startX = 0;
    int endX = kScreenWidth + 300;
    int startY = firstTarget.center.y;
    
    StarDustView* stars = [[StarDustView alloc] initWithFrame:CGRectMake(startX, startY, 10, 10)];
    [self.gameView addSubview:stars];
    [self.gameView sendSubviewToBack:stars];
    [UIView animateWithDuration:3
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         // game finished
                         stars.center = CGPointMake(endX, startY);
                     } completion:^(BOOL finished) {
                         [stars removeFromSuperview];
                     }];
    [self.audioController playEffect:kSoundWin];

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

//connect the Hint button
- (void)setHud:(HUDView *)hud {
    _hud = hud;
    [hud.btnHelp addTarget:self action:@selector(actionHint) forControlEvents:UIControlEventTouchUpInside];
}

- (void)actionHint {
    self.hud.btnHelp.enabled = NO;
    self.data.points -= self.level.pointsPerTile / 2;
    [self.hud.gamePoints countTo:self.data.points withDuration:1.5];
//    NSLog(@"Help!");
    
    TargetView *target = nil;
    for (TargetView *t in _targets) {
        if (t.isMatched == NO) {
            target = t;
            break;
        }
    }
    
    TileView *tile = nil;
    for (TileView *t in _tiles) {
        if (t.isMatched == NO && [t.letter isEqualToString:target.letter]) {
            tile = t;
            break;
        }
    }
    
    [self.gameView bringSubviewToFront:tile];
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         tile.center = target.center;
                     } completion:^(BOOL finished) {
                         [self placeTile:tile atTarget:target];
                         self.hud.btnHelp.enabled = YES;
                         [self checkForSuccess];
                     }];
}
@end
