//
//  TileView.h
//  Anagrams
//
//  Created by Snowmanzzz on 4/15/13.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TileView;

@protocol TileDragDelegateProtocol <NSObject>

- (void)tileView:(TileView *)tileView didDragToPoint:(CGPoint)pt;

@end

@interface TileView : UIImageView

@property (strong, nonatomic, readonly) NSString *letter;
//letter: A property that will hold the letter assigned to the tile.


@property (assign, nonatomic) BOOL isMatched;
//isMatched: A property that will hold a Boolean indicating whether this tile has already been successfully “matched” to a target on the top of the screen.

@property (weak, nonatomic) id<TileDragDelegateProtocol> dragDelegate;


- (instancetype)initWithLetter:(NSString *)letter andSideLength:(float)sideLength;
//initWithLetter:andSideLength: a custom init method to set up an instance of the class with a given letter and tile size.

- (void)randomize;
@end
