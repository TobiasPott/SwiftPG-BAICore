import SwiftUI

public struct PixelData {
    var a: UInt8
    var r: UInt8
    var g: UInt8
    var b: UInt8
}

public extension MultiColor {
    var pixelRGBA: PixelData { PixelData(a: 255, r: r, g: g, b: b) }
}
