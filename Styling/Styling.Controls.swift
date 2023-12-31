import SwiftUI
import SwiftPG_Palettes

public struct Styling {
    public static let appIcon = PImage(imageLiteralResourceName: "SwiftPG-BrickArtInstructor")
}

public extension Styling {
    static let labelWidth: CGFloat = 80
    
    static let blueprintToolbarMaxHeight: CGFloat = 400;
    
    static let buttonSize: CGFloat = 32;
    static let buttonPadding: CGFloat = 10;
    
    static let medButtonSize: CGFloat = 48;
    static let medButtonPadding: CGFloat = 12;
    
    static let roundedCornerRadius: CGFloat = 6;
    static let roundedCornerSize: CGSize = CGSize(width: roundedCornerRadius, height: roundedCornerRadius);
    static let roundedRect: RoundedRectangle = RoundedRectangle(cornerSize: roundedCornerSize)
    static let roundedRectTLBR = UnevenRoundedRectangle(topLeadingRadius: Styling.roundedCornerRadius, bottomTrailingRadius: Styling.roundedCornerRadius)
    
    
}
