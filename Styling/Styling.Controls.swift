import SwiftUI

public struct Styling {
    
    public static let buttonSize: CGFloat = 32;
    public static let buttonPadding: CGFloat = 10;
    
    public static let medButtonSize: CGFloat = 48;
    public static let medButtonPadding: CGFloat = 12;
    
    public static let titleFont: Font = Font.title2
    public static let title2Font: Font = Font.title3
    public static let headlineFont: Font = Font.headline
    public static let captionFont: Font = Font.caption
    public static let caption2Font: Font = Font.caption2
    public static let bodyFont: Font = Font.body
    public static let footnoteFont: Font = Font.footnote
    
    
    
    public static let highlightColor: Color = .accentColor;
    public static let buttonColor: Color = .accentColor;
    public static let sliderColor: Color = .accentColor;
    public static let blueprintColor: Color = Color(.sRGB, red: 0, green: 49 / 100.0, blue: 83 / 100.0, opacity: 1.0);
    public static let panelColor: Color = Color(.sRGB, white: 0.175, opacity: 1.0);
    
    public static let roundedCornerRadius: CGFloat = 6;
    public static let roundedCornerSize: CGSize = CGSize(width: roundedCornerRadius, height: roundedCornerRadius);
    public static let roundedRect: RoundedRectangle = RoundedRectangle(cornerSize: roundedCornerSize)
    public static let roundedRectTLBR = UnevenRoundedRectangle(topLeadingRadius: Styling.roundedCornerRadius, bottomTrailingRadius: Styling.roundedCornerRadius)
    
    public static let appIcon = PImage(imageLiteralResourceName: "SwiftPG-BrickArtInstructor")
}
