//
//  GameData.m
//  Anagrams
//
//  Created by Snowmanzzz on 4/17/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "GameData.h"

@implementation GameData

- (void)setPoints:(int)points {
    _points = MAX(points, 0);
}

@end
