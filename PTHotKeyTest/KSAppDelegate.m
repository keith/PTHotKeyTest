//
//  KSAppDelegate.m
//  PTHotKeyTest
//
//  Created by Keith Smiley on 6/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "KSAppDelegate.h"


@implementation KSAppDelegate

@synthesize window = _window;

NSString *HotKeyAppToFrontName = @"application to foreground";
static NSString *AppActivationKeyCodeKey = @"AppActivationKeyCode";
static NSString *AppActivationModifiersKey = @"AppActivationModifiers";

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self registerAppActivationKeystrokeWithTarget:self selector:@selector(toggle:)];
    [appShortcutField setStringValue:[[self appActivationKeyCombo] description]];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)theApplication hasVisibleWindows:(BOOL)flag {
    [NSApp activateIgnoringOtherApps:YES];
    [_window makeKeyAndOrderFront:nil];
    return YES;
}

- (IBAction)setAppShortcut:(id)sender {
	[[PTKeyComboPanel sharedPanel] showSheetForHotkey:[self appActivationHotKey] forWindow:_window modalDelegate:self]; // Change _window to the window you want the sheet to come down from
}

- (void)keyComboPanelEnded:(PTKeyComboPanel*)panel {
	PTKeyCombo *oldKeyCombo = [self appActivationKeyCombo];
	[self setAppActivationKeyCombo:[panel keyCombo] sender:self];
	
	[appShortcutField setStringValue:[[self appActivationKeyCombo] description]];

	if (![self registerAppActivationKeystrokeWithTarget:[NSApp delegate] selector:@selector(toggle:)]) {
		[self setAppActivationKeyCombo:oldKeyCombo sender:self];
		NSLog(@"reverting to old (hopefully working key combo");
	}

}

- (IBAction)toggle:(id)sender {
    if ([_window isKeyWindow]) {
        [_window close];
    } else {
        [NSApp activateIgnoringOtherApps:YES];
        [_window makeKeyAndOrderFront:nil];
    }
}

- (void)setAppActivationKeyCombo:(PTKeyCombo*)aCombo sender:(id)sender {
	if (aCombo) {
		appActivationKeyCombo = nil;
		appActivationKeyCombo = aCombo;
		
		[[self appActivationHotKey] setKeyCombo:appActivationKeyCombo];
        
		[[NSUserDefaults standardUserDefaults] setInteger:[aCombo keyCode] forKey:AppActivationKeyCodeKey];
		[[NSUserDefaults standardUserDefaults] setInteger:[aCombo modifiers] forKey:AppActivationModifiersKey];
	}
}

- (PTHotKey*)appActivationHotKey {
	if (!appActivationHotKey) {
		appActivationHotKey = [[PTHotKey alloc] init];
		[appActivationHotKey setName:HotKeyAppToFrontName];
		[appActivationHotKey setKeyCombo:[self appActivationKeyCombo]];
	}
	
	return appActivationHotKey;
}

- (PTKeyCombo*)appActivationKeyCombo {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if (!appActivationKeyCombo) {
		appActivationKeyCombo = [[PTKeyCombo alloc] initWithKeyCode:[[defaults objectForKey:AppActivationKeyCodeKey] intValue]
														  modifiers:[[defaults objectForKey:AppActivationModifiersKey] intValue]];
	}
	return appActivationKeyCombo;
}

- (BOOL)registerAppActivationKeystrokeWithTarget:(id)target selector:(SEL)selector {
	PTHotKey *hotKey = [self appActivationHotKey];
	
	[hotKey setTarget:target];
	[hotKey setAction:selector];
	
	[[PTHotKeyCenter sharedCenter] unregisterHotKeyForName:HotKeyAppToFrontName];
	
	return [[PTHotKeyCenter sharedCenter] registerHotKey:hotKey];
}

@end
