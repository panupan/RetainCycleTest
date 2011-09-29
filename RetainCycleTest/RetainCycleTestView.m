//
//  RetainCycleTestView.m
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import "RetainCycleTestView.h"

@implementation RetainCycleTestView
@synthesize tacos, childFrame;

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        child = [[NSView alloc] initWithFrame:frame];    
        
        // This causes a retain cycle
        [child bind:@"frame" toObject:self withKeyPath:@"childFrame" options:nil];
    }
    
    return self;
}

- (void)dealloc
{
    [child unbind:@"childFrame"];
    [super dealloc];
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
    [[NSColor greenColor] setFill];
    NSRectFill(dirtyRect);
}

@end
