//
//  TargetView.h
//  Anagrams
//
//  Created by Snowmanzzz on 4/16/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TargetView : UIImageView

@property (strong, nonatomic, readonly) NSString *letter;
@property (assign, nonatomic) BOOL isMatched;

- (instancetype)initWithLetter:(NSString *)letter andSideLength:(float)sideLength;

@end
