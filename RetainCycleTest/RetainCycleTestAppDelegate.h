//
//  RetainCycleTestAppDelegate.h
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RetainCycleTestAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    
    IBOutlet NSTextField *consoleTextField;
    
    IBOutlet NSView *currentViewContainer;
    NSView *currentView;
    IBOutlet NSComboBox *classNameComboBox;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)allocClicked:(id)sender;
- (IBAction)releaseClicked:(id)sender;
@end
