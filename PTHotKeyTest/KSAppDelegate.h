//
//  KSAppDelegate.h
//  PTHotKeyTest
//
//  Created by Keith Smiley on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PTKeyComboPanel.h"
#import "PTKeyCombo.h"
#import "PTHotKeyCenter.h"
#import "PTHotKey.h"

//@class PTKeyCombo;
//@class PTHotKey;

@interface KSAppDelegate : NSObject <NSApplicationDelegate> {
    IBOutlet NSWindow *hotkey;
    
    IBOutlet NSTextField *appShortcutField;
    
    PTHotKey *appActivationHotKey;
    PTKeyCombo *appActivationKeyCombo;
}

@property (assign) IBOutlet NSWindow *window;

- (IBAction)setAppShortcut:(id)sender;

@end
