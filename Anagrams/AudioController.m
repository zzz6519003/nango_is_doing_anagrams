//
//  AudioController.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/18/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "AudioController.h"
#import <AVFoundation/AVFoundation.h>

@implementation AudioController {
    NSMutableDictionary *audio;
}

- (void)preloadAudioEffects:(NSArray *)effectFileNames {
    audio = [NSMutableDictionary dictionaryWithCapacity:effectFileNames.count];
    for (NSString *effect in effectFileNames) {
        NSString *soundPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:effect];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        
        NSError *loadError = nil;
        AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundURL error:&loadError];
        NSAssert(loadError == nil, @"load sound failed");
        
        // prepare the play
        player.numberOfLoops = 0;
        [player prepareToPlay];
        
        // 4 add to the array ivar
        audio[effect] = player;
    }
}

- (void)playEffect:(NSString *)name {
    NSAssert(audio[name], @"effect not found");
    AVAudioPlayer *player = (AVAudioPlayer *)audio[name];
    if (player.isPlaying) {
        player.currentTime = 0;
    } else {
        [player play];
    }
    
}

@end
