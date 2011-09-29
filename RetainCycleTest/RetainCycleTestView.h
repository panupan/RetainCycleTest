//
//  RetainCycleTestView.h
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RetainCycleTestView : NSView {
    int tacos;   
    NSView *child;
    NSRect childFrame;
}
@property (nonatomic, assign) int tacos;
@property (nonatomic, assign) NSRect childFrame;
@end
