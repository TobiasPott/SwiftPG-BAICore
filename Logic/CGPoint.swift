import SwiftUI

extension CGPoint {
    func add(_ rh: CGPoint) -> CGPoint {
        return CGPoint(x: self.x + rh.x, y: self.y + rh.y)
    }
    func sub(_ rh: CGPoint) -> CGPoint {
        return CGPoint(x: self.x - rh.x, y: self.y - rh.y)
    }
    func mul(_ rh: CGFloat) -> CGPoint {
        return CGPoint(x: self.x * rh, y: self.y * rh)
    }
    func div(_ rh: CGFloat) -> CGPoint {
        return CGPoint(x: self.x / rh, y: self.y / rh)
    }
    
    static func add(_ lh: CGPoint, _ rh: CGPoint) -> CGPoint {
        return CGPoint(x: lh.x + rh.x, y: lh.y + rh.y)
    }
    static func sub(_ lh: CGPoint, _ rh: CGPoint) -> CGPoint {
        return CGPoint(x: lh.x - rh.x, y: lh.y - rh.y)
    }
    static func mul(_ lh: CGPoint, _ rh: CGFloat) -> CGPoint {
        return CGPoint(x: lh.x * rh, y: lh.y * rh)
    }
    static func div(_ lh: CGPoint, _ rh: CGFloat) -> CGPoint {
        return CGPoint(x: lh.x / rh, y: lh.y / rh)
    }
    
    func FloorToInt() -> CGPoint {
        return CGPoint(x: floor(self.x), y: floor(self.y))
    }
    func Clamp(_ lower: CGFloat, _ upper: CGFloat) -> CGPoint {
        return CGPoint(x: min(max(self.x, lower), upper), y: min(max(self.y, lower), upper))
    }
    func Clamp(_ lower: CGPoint, _ upper: CGPoint) -> CGPoint {
        return CGPoint(x: min(max(self.x, lower.x), upper.x), y: min(max(self.y, lower.y), upper.y))
    }
    func distance(to point: CGPoint) -> CGFloat {
        sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))
    }
    func cgSize() -> CGSize {
        return CGSize(width: self.x, height: self.y)
    }
}
