## How to use

Feel free to download and decode this project in order to implement it in your own projects. Or follow these loose instructions to configure it.

## Instructions for other implementations

Configure your project as necessary this project is using ARC and sandboxed with no entitlements.

1. Import Carbon.framework into your project if it's not already.
2. Import the PTHotKey files into your project. I like to group them to stay organized.
3. **If you are using ARC** be sure to add `-fno-objc-arc` under the compiler flags for each of the PTHotKey m files. (This is found by clicking on your Target's settings -> Build Phases -> Compile Sources)
4. Import the PTHotKey header files into your controlling header file.
	
		#import "PTKeyComboPanel.h"
		#import "PTKeyCombo.h"
		#import "PTHotKeyCenter.h"
		#import "PTHotKey.h"
	
*I found that the project worked correctly with these import statements. Your implementation may vary.*

5. Create another view named `PTKeyComboPanel.xib` (the naming matters) file with a single window and change the File Owner's custom class to `PTKeyComboPanel`
6. Add the rest of the controls to the window dependent on what you want. See the view in this project for the "typical" implementation. **I would recommend copying the window in this project and pasting it into yours. If you choose to configure it yourself there is a hidden element that needs to be bound to the File's Owner.**
7. Bind your controls to the File Owner.
8. Implement the controlling code in your m file. See this project for other details. The key is configuring the `@selector` argument being passed to `registerAppActivationKeystrokeWithTarget` with the action you want the shortcut the execute when pressed. In this example it toggles the main window.
9. ???
10. Profit!

## Notes

- This configuration is not perfectly coded there are some things I would change it before implementing this method to be more efficient. *Use it wisely.*
- This configuration saves the hotkey information to `[NSUserDefaults standardUserDefaults]` if you'd like to save it to a different controller or plist you'll need to change those settings.
- The statements in `applicationDidFinishLaunching` register the hotkeys when the application is launched. Be sure to edit that statement's `@selector` as you did before.
- I have yet to configure this example to work with multiple hotkey instances. It would require some sort of configuration to use separate sets of shortcuts for different functions.
- If you would like to configure 1 shortcut to be user customizable for different options use a NSPopupButton with something like this configuration. (This can also be done with an NSArrayController)

		SEL customSelector = NSSelectorFromString([[[button selectedItem] title] stringByAppendingString:@":"]);
	Then implement `customSelector` in place of the `@selector` **Be sure to append the colon so it can function correctly.**
		

## Attributions

This implementation came from [Brett Terpstra's](http://brettterpstra.com/) fork [nvALT](https://github.com/ttscoff/nv) when searching for a dynamic global shortcut solution. Thank's for being awesome Brett.