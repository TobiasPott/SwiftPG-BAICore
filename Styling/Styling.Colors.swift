import SwiftUI

public extension Styling {
    
    static let clear: Color = Color.clear
    static let white: Color = Color.white;
    static let black: Color = Color.black;
    
    static let accent: Color = Color.accentColor;
    static let primary: Color = Color.primary;
    static let secondary: Color = Color.secondary;
    
    
    static let red: Color = Color.red;
    static let green: Color = Color.green;
    static let blue: Color = Color.blue;
    static let yellow: Color = Color.yellow;
    static let gray: Color = Color.gray;
    
    
    
    static let highlightColor: Color = Color.accentColor;
    static let buttonColor: Color = Color.accentColor;
    static let sliderColor: Color = Color.accentColor;
    static let blueprintColor: Color = MultiColor(cgColor: CGColor(srgbRed: 0.0, green: 49.0 / 100.0, blue: 83.0 / 100.0, alpha: 1.0)).swuiColor
    static let panelColor: Color = Color(cgColor: UIColor.tertiarySystemFill.cgColor)
    
}
