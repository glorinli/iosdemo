//
//  Person.h
//  CmdDemo
//
//  Created by Glorin Li on 2019/4/6.
//  Copyright © 2019 Glorin Li. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^Completion)();

@interface Person : NSObject

- (void) selfIntroducation;

- (void) eat:(Completion)completion;

@end

NS_ASSUME_NONNULL_END
