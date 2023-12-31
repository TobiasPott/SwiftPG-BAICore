import SwiftUI
import simd

public struct Palette: Identifiable, Hashable {
    public typealias ColorType = MultiColor
    
    public var id: String { name }
    public let name: String
    public var colors: [ColorType] = []
    public var names: [String] = []
    
    public init(name: String, colors: [ColorType], names: [String]) {
        self.name = name;
        self.colors = colors;
        self.names = names;
    }
    
    public func get(_ index: Int) -> (color: ColorType, name: String) {
        return (colors[index], names[index])
    }
    public func findClosest(_ inColor: ColorType, _ threshold: Float = 10.0) -> Int {
        var closestIndex: Int = -1;
        var closestDist: Float = 1024.0;
        for i in 0..<colors.count {
            let diff: SIMD3<Float> = inColor.vectorRGBDiff(colors[i]);
            let dist = simd_length(diff)
            if (dist < closestDist) {
                closestIndex = i;
                closestDist = dist;
                if (closestDist <= threshold) {
                    return closestIndex
                }
            }
        }
        return closestIndex;
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(colors.count)
    }
    
}
