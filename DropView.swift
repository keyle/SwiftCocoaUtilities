//
//  DropView.swift
//  https://stackoverflow.com/questions/31657523/os-x-swift-get-file-path-using-drag-and-drop
//
//  an NSview for handling dropping of external files in the application
//  Shows an image on hover (updated it)
//  Also update the handler func.

import Cocoa

class DropView: NSView {
    
    let expectedExt = ["mp3", "wav", "aiff", "m3u"]  //file extensions allowed for Drag&Drop (example: "jpg","png","docx", etc..)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.wantsLayer = true
        //self.layer?.backgroundColor = NSColor.green.cgColor // for debugging
        
        registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        // Drawing code here.
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        if checkExtension(sender) == true {
            self.layer?.contents = NSImage(named: "drop")
            //self.layer?.backgroundColor = NSColor.blue.cgColor
            return .copy
        } else {
            return NSDragOperation()
        }
    }
    
    fileprivate func checkExtension(_ drag: NSDraggingInfo) -> Bool {
        guard let board = drag.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let path = board[0] as? String
            else { return false }
        
        let suffix = URL(fileURLWithPath: path).pathExtension
        for ext in self.expectedExt {
            if ext.lowercased() == suffix {
                return true
            }
        }
        return false
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.layer?.backgroundColor = nil
        self.layer?.contents = nil
    }
    
    override func draggingEnded(_ sender: NSDraggingInfo) {
        self.layer?.backgroundColor = nil
        self.layer?.contents = nil
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let all_files = sender.draggingPasteboard.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
            let _ = all_files[0] as? String
            else { return false }
        
        print("got a successful drop of \(all_files.count) files")
        
        // NotificationCenter.default.post(Notification(name: Notification.Name(Messages.FILES_DROPPED.rawValue), object: all_files))
        // Postbox.broadcast(message: Messages.FILES_DROPPED, object: all_files)
        
        return true
    }
}
