import SwiftUI
import SwiftPG_Palettes

public struct Styling {
    public static let labelWidth: CGFloat = 80

    public static let blueprintToolbarMaxHeight: CGFloat = 400;
    
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
    public static let blueprintColor: Color = MultiColor(cgColor: CGColor(srgbRed: 0, green: 49 / 100.0, blue: 83 / 100.0, alpha: 1.0)).swuiColor
    public static let panelColor: Color = MultiColor(cgColor: CGColor(srgbRed: 0.175, green: 0.175, blue: 0.175, alpha: 1.0)).swuiColor
    
    public static let roundedCornerRadius: CGFloat = 6;
    public static let roundedCornerSize: CGSize = CGSize(width: roundedCornerRadius, height: roundedCornerRadius);
    public static let roundedRect: RoundedRectangle = RoundedRectangle(cornerSize: roundedCornerSize)
    public static let roundedRectTLBR = UnevenRoundedRectangle(topLeadingRadius: Styling.roundedCornerRadius, bottomTrailingRadius: Styling.roundedCornerRadius)
    
    public static let appIcon = PImage(imageLiteralResourceName: "SwiftPG-BrickArtInstructor")
}
