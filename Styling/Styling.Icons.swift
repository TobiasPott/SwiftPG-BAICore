import SwiftUI

public struct SNImage {
    
    public static func get(_ systemName: String) -> Image {
        return Image(systemName: systemName)
    }
    public static let circleInsetFilled = get("circle.inset.filled")
    public static let circle = get("circle")
    public static let squareAndArrowUp = get("square.and.arrow.up")
    
    public static let folder = get("folder")
    public static let lockFill = get("lockFill")
    
    public static let questionmarkApp = get("questionmark.app")
    public static let magnifyingglass = get("magnifyingglass")
    public static let magnifyingglassCircle = get("magnifyingglass.circle")
}
