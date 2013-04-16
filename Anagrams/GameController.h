//
//  GameController.h
//  Anagrams
//
//  Created by Snowmanzzz on 4/15/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Level.h"
#import "TargetView.h"


@interface GameController : NSObject

@property (weak, nonatomic) UIView *gameView;
@property (strong, nonatomic) Level *level;

//display a new anagram on the screen
- (void)dealRandomAnagram;

@end
