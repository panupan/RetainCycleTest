//
//  RetainCycleTestAppDelegate.m
//  RetainCycleTest
//
//  Created by Panupan Sriautharawong on 9/29/11.
//  Copyright 2011 Panupan.com. All rights reserved.
//

#import "RetainCycleTestAppDelegate.h"
#import <objc/objc-runtime.h>

// Swizzle dealloc method
@implementation NSResponder(DeallocLogger)
- (void)loggingDealloc
{
    [NSApp sendAction:@selector(deallocCalled:) to:nil from:self];
    [self loggingDealloc]; // calls dealloc
}

+ (void)swizzle {
    SEL originalSelector = @selector(dealloc);
    SEL overrideSelector = @selector(loggingDealloc);
    Method originalMethod = class_getInstanceMethod(self, originalSelector);
    Method overrideMethod = class_getInstanceMethod(self, overrideSelector);
    if (class_addMethod(self, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(self, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}
@end

@implementation RetainCycleTestAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [NSResponder swizzle];
    [classNameComboBox selectItemAtIndex:0];
    [consoleTextField setStringValue:@"Application Launched"];
}

- (void)log:(NSString *)message{ 
    [consoleTextField setStringValue:[NSString stringWithFormat:@"%@\n%@",  consoleTextField.stringValue, message]];
    
}

- (IBAction)allocClicked:(id)sender {
    
    currentView = [[NSClassFromString([classNameComboBox objectValueOfSelectedItem]) alloc] initWithFrame:currentViewContainer.frame];

    if (!currentView) {
        [self log:[NSString stringWithFormat:@"%@ isn't defined!", [classNameComboBox objectValueOfSelectedItem]]];
        return;
    }
    
    consoleTextField.stringValue = [NSString stringWithFormat:@"[%@ init]", [classNameComboBox objectValueOfSelectedItem]];    
    
    [self log:[NSString stringWithFormat:@"%@ retainCount:%d", [currentView className], (int)[currentView retainCount]]];
    
    [self log:[NSString stringWithFormat:@"[currentViewController addSubview]"]];        
    [currentViewContainer addSubview:currentView];    
    
    [self log:[NSString stringWithFormat:@"%@ retainCount:%d", [currentView className], (int)[currentView retainCount]]];    
}

- (IBAction)releaseClicked:(id)sender {
    if (!currentView) return;
        
    [self log:[NSString stringWithFormat:@"[%@ removeFromSuperview]", [currentView className]]];        
    [currentView removeFromSuperview];
    
    [self log:[NSString stringWithFormat:@"%@ retainCount:%d", [currentView className], (int)[currentView retainCount]]];
    
    [self log:[NSString stringWithFormat:@"[%@ release]", [currentView className]]];    
    [currentView release];
    
    [self log:[NSString stringWithFormat:@"%@ retainCount:%d", [currentView className], (int)[currentView retainCount]]]; 
    
    currentView = nil;
}

- (void)logCalled:(id)sender {
    [self log:[NSString stringWithFormat:@"%@", sender]];
}

- (void)deallocCalled:(id)sender {
    [self log:[NSString stringWithFormat:@"[%@ dealloc]", [sender className]]];     
}
@end
