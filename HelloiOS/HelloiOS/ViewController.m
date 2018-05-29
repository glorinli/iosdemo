//
//  ViewController.m
//  HelloiOS
//
//  Created by Glorin Li on 2018/4/15.
//  Copyright © 2018 Glorin Li. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel* label = [[UILabel alloc]init];
    
    label.text = @"Hello iOS";
    
    [label sizeToFit];
    
    label.center = self.view.center;
    
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
