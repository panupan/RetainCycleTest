//
//  SelfProxyView.m
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import "SelfProxyView.h"

@implementation SelfProxyView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        selfProxy = [[NSObjectController alloc] initWithContent:self];
    }
    
    return self;
}

- (oneway void)release
{
    // special case when count is 3, we are being retained twice by the object controller...
    if ([self retainCount] == 3) {
        [super release];        
        [selfProxy setContent:nil];        
        return;
    }
    
    [super release];
}

- (void)dealloc
{
    [selfProxy release];
    [super dealloc];
}


@end
