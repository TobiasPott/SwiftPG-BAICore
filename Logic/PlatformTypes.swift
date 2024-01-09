import SwiftUI
import UIKit

public typealias PImage = UIImage

public extension PImage {
    var swuiImage: Image { 
        Image(uiImage: self)
    }
}
