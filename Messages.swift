import Cocoa

enum Messages: String {
    case FILES_DROPPED, // examples
    FILE_SELECTED,
    FILE_ENDED,
    RACK_ENDED,
    PLAY_RACK
}

// Postbox.register(observer: self, message: Messages.FILES_DROPPED, callback: #selector(onFilesDroppedNotification))
// Postbox.broadcast(message: Messages.FILES_DROPPED, object: all_files)
// @objc func onFilesDroppedNotification(notif: Notification) {} // notif.object is the object payload if any.
class Postbox {
    
    static func register(observer: Any, message: Messages, callback: Selector) {
        NotificationCenter.default.addObserver(observer, selector: callback, name: Notification.Name(message.rawValue), object: nil)
    }
    
    static func broadcast(message:Messages, object: Any?) {
        NotificationCenter.default.post(Notification(name: Notification.Name(message.rawValue), object: object))
    }
    
    static func deregister(observer: Any) {
        NotificationCenter.default.removeObserver(observer)
    }
}
