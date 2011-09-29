//
//  SelfProxyView.h
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SelfProxyView : NSView {
    NSObjectController *selfProxy;
}

@end
