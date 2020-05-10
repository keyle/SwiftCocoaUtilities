// Can't remember the source of this one sorry
// Empty window transparent with no chrome

import Cocoa

class CustomWindow: NSWindow {
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing bufferingType: NSWindow.BackingStoreType, defer flag: Bool) {
        super.init(contentRect: contentRect, styleMask: style, backing: bufferingType, defer: flag)
        
        // Set the opaque value off,remove shadows and fill the window with clear (transparent)
        self.isOpaque = true
        self.hasShadow = true
        self.backgroundColor = NSColor.clear // needed for no border
        
        // Change the title bar appereance
        self.title = "Boomdeck"
        self.titleVisibility = .hidden
        self.titlebarAppearsTransparent = true
        
        self.isMovableByWindowBackground = true // drag bg

    }
}
