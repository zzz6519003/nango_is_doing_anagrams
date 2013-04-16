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

}
@end
