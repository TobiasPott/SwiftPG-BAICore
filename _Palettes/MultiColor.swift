import SwiftUI
#if canImport(UIKit)
import UIKit
#endif
import simd

public struct MultiColor : Hashable {
    public let hue: CGFloat;
    public let saturation: CGFloat;
    public let brightness: CGFloat;
    public let r: UInt8;
    public let g: UInt8;
    public let b: UInt8;
    public let cgColor: CGColor;
    
    public let vectorRGB: SIMD3<Float>;
    
    public init(cgColor: CGColor) {
        self.cgColor = cgColor;
        var h: CGFloat = 0;
        var s: CGFloat = 0;
        var b: CGFloat = 0;
        var a: CGFloat = 1;
        
#if canImport(UIKit)
        if (UIColor(cgColor: cgColor).getHue(&h, saturation: &s, brightness: &b, alpha: &a)) {
        }
#else
        NSColor(cgColor: cgColor)?.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
#endif
        
        self.hue = h;
        self.saturation = s;
        self.brightness = b;
        
        let comps = cgColor.components ?? [0.0, 0.0, 0.0]
        self.r = UInt8((comps[0] * 255).clamped(lowerBound: 0, upperBound: 255))
        self.g = UInt8((comps[1] * 255).clamped(lowerBound: 0, upperBound: 255))
        self.b = UInt8((comps[2] * 255).clamped(lowerBound: 0, upperBound: 255))
        
        self.vectorRGB = SIMD3<Float>(Float(comps[0] * 255.0), Float(comps[1] * 255.0), Float(comps[2] * 255.0));
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(r)
        hasher.combine(g)
        hasher.combine(b)
    }
    
    func vectorRGBDiff(_ rh: MultiColor) -> SIMD3<Float> {
        return self.vectorRGB - rh.vectorRGB;
    }
    
    static let maxRGB: CGFloat = 255.0;
    public static func rgb(_ r: Int16, _ g: Int16, _ b: Int16) -> MultiColor {
        // converts 0-1 to 0-255
        let cgColor: CGColor = CGColor(red: (CGFloat(r) / maxRGB), green: (CGFloat(g) / maxRGB), blue: (CGFloat(b) / maxRGB), alpha: 1.0)
        return MultiColor(cgColor: cgColor);
    }
    
}
