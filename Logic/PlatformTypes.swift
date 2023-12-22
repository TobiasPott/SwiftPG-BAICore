import SwiftUI

// todo: use NSImage on macOS
public typealias PImage = UIImage


public extension PImage {
    var swuiImage: Image {
        // todo: add nsImage variant for macOS 
        Image(uiImage: self)
    }
}
