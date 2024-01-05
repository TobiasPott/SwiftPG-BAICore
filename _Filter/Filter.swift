import SwiftUI

public enum BuiltInFilter: Int, Codable {
    case posterize, scale, saturation
    case thermal, xray, sepiatone, hueadjust, comiceffect
}

public struct Filter: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, enabled, name, type, args
    }
    
    public let id: UUID = UUID();
    public var enabled: Bool;
    public let name: String;
    public let type: BuiltInFilter;
    public var args: [CGFloat] = [];
    public var action: (CIImage, [CGFloat]) -> CIImage = { (input, args) in return input; }
    
    public func apply(_ input: CIImage) -> CIImage {
        return action(input, args);
    }    
    
    public static func generic(_ name: String, _ type: BuiltInFilter, _ args: [CGFloat], action: @escaping (CIImage, [CGFloat]) -> CIImage) -> Filter { 
        return Filter(enabled: true, name: name, type: type, args: args, action: action)
    }
    
}
