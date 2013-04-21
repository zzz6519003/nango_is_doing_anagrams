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
#import "AudioController.h"

//just under the imports at the top and above the interface declaration
typedef void (^CallbackBlock)();

@interface GameController : NSObject <TileDragDelegateProtocol>

@property (weak, nonatomic) UIView *gameView;
@property (strong, nonatomic) Level *level;
@property (weak, nonatomic) HUDView *hud;
@property (strong, nonatomic) GameData *data;
@property (strong, nonatomic) AudioController *audioController;
@property (strong, nonatomic) CallbackBlock onAnagramSolved;


//display a new anagram on the screen
- (void)dealRandomAnagram;

-(void)checkForSuccess;

@end
