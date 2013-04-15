//
//  Level.h
//  Anagrams
//
//  Created by Snowmanzzz on 4/15/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Level : NSObject

@property (assign, nonatomic) int pointsPerTile;
@property (assign, nonatomic) int timeToSolve;
@property (assign, nonatomic) NSArray *anagrams;

//factory method to load a .plist file and initialize the model
+ (instancetype)levelWithNum:(int)levelNum;

@end
