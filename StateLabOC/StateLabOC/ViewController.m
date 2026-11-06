//
//  ViewController.m
//  StateLabOC
//
//  Created by Glorin Li on 2020/5/15.
//  Copyright © 2020 Glorin Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

UILabel* label;
bool animate = false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CGRect bounds = self.view.bounds;
    CGRect labelFrame = CGRectMake(bounds.origin.x, bounds.origin.y / 2 - 20, bounds.size.width, bounds.size.height);
    
    label = [[UILabel alloc]initWithFrame:labelFrame];
    label.font = [UIFont fontWithName: @"Helvetica" size: 70];
    [label setText:@"星星"];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setBackgroundColor:UIColor.clearColor];
    
    [[self view] addSubview:label];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
}

- (void)rotateLabelDown {
    [UIView animateWithDuration:0.5 animations:^{
        [label setTransform:CGAffineTransformMakeRotation(M_PI)];
    } completion:^(BOOL finished) {
        [self rotateLabelUp];
    }];
}

- (void)rotateLabelUp {
    [UIView animateWithDuration:0.5 animations:^{
        [label setTransform:CGAffineTransformMakeRotation(0)];
    } completion:^(BOOL finished) {
        if (animate) {
            [self rotateLabelDown];
        }
    }];
}

- (void)appWillResignActive:(NSNotification*)notification {
    animate = false;
}

- (void)appWillBecomeActive:(NSNotification*)notification {
    animate = true;
    [self rotateLabelDown];
}


@end
