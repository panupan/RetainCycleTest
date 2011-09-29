//
//  TearDownTestView.m
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import "TearDownTestView.h"

@implementation TearDownTestView

// Perform cleanup
- (void)teardown
{
    [child unbind:@"frame"];
}

// Since we only use this view once, teardown once it is removed!
- (void)removeFromSuperview
{
    [super removeFromSuperview];
    [self teardown];
}

@end
