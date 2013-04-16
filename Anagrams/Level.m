//
//  Level.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/15/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "Level.h"

@implementation Level


+ (instancetype)levelWithNum:(int)levelNum {
    // find plist
    NSString *fileName = [NSString stringWithFormat:@"level%i.plist", levelNum];
    NSString *levelPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:fileName];
    // load list
    NSDictionary *levelDict = [NSDictionary dictionaryWithContentsOfFile:levelPath];
    // validation
    NSAssert(levelDict, @"level config file not found");
    // create level instance
    Level *l = [[Level alloc] init];
    // initialize the object from the dictionary;
    l.pointsPerTile = [levelDict[@"pointsPerTile"] intValue];
    l.anagrams = levelDict[@"anagrams"];
    l.timeToSolve = [levelDict[@"timeToSolve"] intValue];
    
    return l;
}

@end
