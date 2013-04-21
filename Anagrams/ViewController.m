//
//  ViewController.m
//  Anagrams
//
//  Created by Marin Todorov on 16/02/2013.
//  Copyright (c) 2013 Underplot ltd. All rights reserved.
//

#import "config.h"
#import "ViewController.h"
#import "Level.h"
#import "HUDView.h"
#import "GameController.h"

@interface ViewController () <UIActionSheetDelegate>
@property (strong, nonatomic) GameController *controller;
@end

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self != nil) {
        self.controller = [[GameController alloc] init];
    }
    
    return self;
}

//setup the view and instantiate the game controller
- (void)viewDidLoad
{
    [super viewDidLoad];
//    Level *level1 = [Level levelWithNum:1];
//    NSLog(@"anagrams: %@", level1.anagrams);
    
    UIView *gameLayer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:gameLayer];
    self.controller.gameView = gameLayer;

//    self.controller.level = level1;
//    [self.controller dealRandomAnagram];
    
    HUDView *hudView = [HUDView viewWithRect:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [self.view addSubview:hudView];
    self.controller.hud = hudView;
    
    __weak ViewController *weakSelf = self;
    self.controller.onAnagramSolved = ^() {
        [weakSelf showLevelMenu];
    };
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if ((orientation == UIInterfaceOrientationPortrait) ||
        (orientation == UIInterfaceOrientationLandscapeLeft))
        return YES;
    
    return NO;
}

- (void)showLevelMenu {
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"Play a difficulty level" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"Easy-peasy", @"Normal", @"我是男哥", nil];
    [action showInView:self.view];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showLevelMenu];
}

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == -1) {
        [self showLevelMenu];
    }
    int levelNum = buttonIndex + 1;
    self.controller.level = [Level levelWithNum:levelNum];
    [self.controller dealRandomAnagram];   
}

@end
