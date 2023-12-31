import SwiftUI
import simd

public struct Palette: Identifiable, Hashable {
    public typealias ColorType = MultiColor
    
    public var id: String { name }
    public let name: String
    public var artColors: [ArtColor] = []
    
    public var count: Int { artColors.count }
    
    public init(name: String, colors: [ColorType], names: [String]) {
        self.name = name;
        for i in 0..<colors.count {
            if (!artColors.contains(where: { aClr in aClr.name == names[i] })) {
                artColors.append(ArtColor(name: names[i], color: colors[i]))
            }
        }
        artColors.sort { lh, rh in
            lh.name < rh.name
        }
    }
    public func get(_ index: Int) -> ArtColor {
        return artColors[index]
    }
    public func findClosest(_ inColor: ColorType, _ threshold: Float = 10.0) -> Int {
        var closestIndex: Int = -1;
        var closestDist: Float = 1024.0;
        for i in 0..<self.count {
            let dist = simd_length(inColor.vectorRGBDiff(artColors[i].color))
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
        hasher.combine(artColors.count)
    }
    
}
