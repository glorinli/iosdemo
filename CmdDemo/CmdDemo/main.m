//
//  main.m
//  CmdDemo
//
//  Created by Glorin Li on 2018/5/31.
//  Copyright © 2018 Glorin Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "./bean/Person.h"
#import "./util/MathUtil.h"

const int AGE = 10;

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        
        Person *person = [[Person alloc]init];
        [person selfIntroducation];
        
        NSLog(@"Storage size of unsigned long: %1$lu", sizeof(unsigned long));
        
        NSLog(@"Age is %1$d", AGE);
        
        NSLog(@"Max of %1$d and %2$d is %3$d", 1, 2, [MathUtil max:1 secondNumber:2]);
    }
    
    return 0;
}
