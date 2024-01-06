import SwiftUI

public typealias PImage = UIImage

public extension PImage {
    var swuiImage: Image { 
        Image(uiImage: self)
    }
}
