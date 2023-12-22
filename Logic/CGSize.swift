import SwiftUI

extension CGSize {
    
    func add(_ rh: CGSize) -> CGSize {
        return CGSize(width: self.width + rh.width, height: self.height + rh.height)
    }
    func sub(_ rh: CGSize) -> CGSize {
        return CGSize(width: self.width - rh.width, height: self.height - rh.height)
    }
    func mul(_ rh: CGSize) -> CGSize {
        return CGSize(width: self.width * rh.width, height: self.height * rh.height)
    }
    func div(_ rh: CGSize) -> CGSize {
        return CGSize(width: self.width / rh.width, height: self.height / rh.height)
    }
    
    func add(_ rh: CGFloat) -> CGSize {
        return CGSize(width: self.width + rh, height: self.height + rh)
    }
    func sub(_ rh: CGFloat) -> CGSize {
        return CGSize(width: self.width - rh, height: self.height - rh)
    }
    func mul(_ rh: CGFloat) -> CGSize {
        return CGSize(width: self.width * rh, height: self.height * rh)
    }
    func div(_ rh: CGFloat) -> CGSize {
        return CGSize(width: self.width / rh, height: self.height / rh)
    }
    
    static func add(_ lh: CGSize, _ rh: CGSize) -> CGSize {
        return CGSize(width: lh.width + rh.width, height: lh.height + rh.height)
    }
    static func sub(_ lh: CGSize, _ rh: CGSize) -> CGSize {
        return CGSize(width: lh.width - rh.width, height: lh.height - rh.height)
    }
    static func mul(_ lh: CGSize, _ rh: CGSize) -> CGSize {
        return CGSize(width: lh.width * rh.width, height: lh.height * rh.height)
    }
    static func div(_ lh: CGSize, _ rh: CGSize) -> CGSize {
        return CGSize(width: lh.width / rh.width, height: lh.height / rh.height)
    }
    
    static func add(_ lh: CGSize, _ rh: CGFloat) -> CGSize {
        return CGSize(width: lh.width + rh, height: lh.height + rh)
    }
    static func sub(_ lh: CGSize, _ rh: CGFloat) -> CGSize {
        return CGSize(width: lh.width - rh, height: lh.height - rh)
    }
    static func mul(_ lh: CGSize, _ rh: CGFloat) -> CGSize {
        return CGSize(width: lh.width * rh, height: lh.height * rh)
    }
    static func div(_ lh: CGSize, _ rh: CGFloat) -> CGSize {
        return CGSize(width: lh.width / rh, height: lh.height / rh)
    }
    
    func cgPoint() -> CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
}
