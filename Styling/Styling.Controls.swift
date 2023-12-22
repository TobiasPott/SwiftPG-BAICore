import SwiftUI

public struct Styling {
    
    public static let buttonSize: CGFloat = 32;
    public static let buttonPadding: CGFloat = 10;
    
    public static let medButtonSize: CGFloat = 48;
    public static let medButtonPadding: CGFloat = 12;
    
    public static let titleFont: Font = .system(.title2, design: .default, weight: .bold);
    public static let title2Font: Font = .system(.title3, design: .default, weight: .bold);
    
    
    
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
