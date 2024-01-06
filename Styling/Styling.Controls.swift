import SwiftUI

public struct Styling {
    public static let appIcon = PImage(imageLiteralResourceName: "SwiftPG-BrickArtInstructor")
}

public extension Styling {
    static let labelWidth: CGFloat = 80.0
    
    static let blueprintToolbarMaxHeight: CGFloat = 400.0;
    
    static let buttonSize: CGFloat = 32.0;
    static let buttonPadding: CGFloat = 10.0;
    
    static let medButtonSize: CGFloat = 48.0;
    static let medButtonPadding: CGFloat = 12.0;
    
    static let roundedCornerRadius: CGFloat = 6.0;
    static let roundedCornerSize: CGSize = CGSize(width: roundedCornerRadius, height: roundedCornerRadius);
    static let roundedRect: RoundedRectangle = RoundedRectangle(cornerSize: roundedCornerSize)
    static let roundedRectTLBR = UnevenRoundedRectangle(topLeadingRadius: roundedCornerRadius, bottomTrailingRadius: roundedCornerRadius)
    static let roundedRectTRBL = UnevenRoundedRectangle(bottomLeadingRadius: roundedCornerRadius, topTrailingRadius: roundedCornerRadius)
    
    
    static let roundedRectHalf: RoundedRectangle = RoundedRectangle(cornerSize: CGSize(width: roundedCornerRadius / 2.0, height: roundedCornerRadius / 2.0))
    static let roundedRectHalfTLBR = UnevenRoundedRectangle(topLeadingRadius: roundedCornerRadius / 2.0, bottomTrailingRadius: roundedCornerRadius / 2.0)
    static let roundedRectHalfTRBL = UnevenRoundedRectangle(bottomLeadingRadius: roundedCornerRadius / 2.0, topTrailingRadius: roundedCornerRadius / 2.0)
    
    
}
