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
#import "TileView.h"
#import "HUDView.h"
#import "GameData.h"



@interface GameController : NSObject <TileDragDelegateProtocol>

@property (weak, nonatomic) UIView *gameView;
@property (strong, nonatomic) Level *level;
@property (weak, nonatomic) HUDView *hud;
@property (strong, nonatomic) GameData *data;

//display a new anagram on the screen
- (void)dealRandomAnagram;

-(void)checkForSuccess;

@end
