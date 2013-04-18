//
//  AudioController.h
//  Anagrams
//
//  Created by Snowmanzzz on 4/18/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioController : NSObject

- (void)playEffect:(NSString *)name;

- (void)preloadAudioEffects:(NSArray *)effectFileNames;

@end
