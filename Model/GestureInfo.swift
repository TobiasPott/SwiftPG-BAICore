import SwiftUI

public struct DragInfo: Codable {
    var active: Bool = false;
    var location: CGPoint = CGPoint();
    var fixedLocation: CGPoint = CGPoint();
    var offset: CGPoint = CGPoint();
    
    mutating func update(_ gesture: DragGesture.Value, _ apply: Bool = false) {
        if(!active) {
            offset = fixedLocation.sub(gesture.startLocation);
            active = true
        }
        location = gesture.location.add(offset); 
        if (apply) {
            fixedLocation = location;
            active = false
        }
    }
    mutating func clamp(_ min: CGPoint, _ max: CGPoint) {
        self.location = CGPoint(x: location.x.clamped(lowerBound: 0, upperBound: max.x), y: location.y.clamped(lowerBound: 0, upperBound: max.y))
        self.fixedLocation = CGPoint(x: fixedLocation.x.clamped(lowerBound: 0, upperBound: max.x), y: fixedLocation.y.clamped(lowerBound: 0, upperBound: max.y))
    }
    
    mutating func reset(location: CGPoint? = nil) {
        self.location = location ?? CGPoint();
        self.fixedLocation = location ?? CGPoint();
        self.offset = CGPoint();
    }
    
    
}

public struct ZoomInfo: Codable {
    static let defaultScale: CGFloat = 30.0;
    var active: Bool = false;
    
    var scale: CGFloat = ZoomInfo.defaultScale;    
    var lastScale: CGFloat = ZoomInfo.defaultScale;
    
    mutating func update(_ value: CGFloat, _ apply: Bool = false) {
        self.scale = (self.lastScale * value).clamped(lowerBound: 0.001, upperBound: .infinity)
        if (apply) {
            self.lastScale = self.scale;
        }
    }
    
    mutating func clamp(_ min: CGFloat, _ max: CGFloat) {
        self.scale = self.scale.clamped(lowerBound: min, upperBound: max)
        self.lastScale = self.scale
    }
    
    mutating func reset(scale: CGFloat? = nil) {
        self.scale = scale ?? ZoomInfo.defaultScale;
        self.lastScale = scale ?? ZoomInfo.defaultScale;
    }
}
