//
//  SelfProxyTestView.m
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import "SelfProxyTestView.h"

@implementation SelfProxyTestView
@synthesize tacos, childFrame;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        // Use proxy to prevent retain cycle
        child = [[NSView alloc] initWithFrame:frame];    
        [child bind:@"frame" 
           toObject:selfProxy 
        withKeyPath:@"content.childFrame" 
            options:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [child unbind:@"frame"];
    [child release];
    
    [super dealloc];
}

@end
