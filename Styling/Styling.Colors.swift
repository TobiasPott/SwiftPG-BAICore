import SwiftUI

public extension Styling {
    
    static let clear: Color = Color.clear
    static let white: Color = Color.white;
    static let black: Color = Color.black;
    
    static let accent: Color = Color.accentColor;
    static let red: Color = Color.red;
    static let green: Color = Color.green;
    static let blue: Color = Color.blue;
    static let gray: Color = Color.gray;
    
    static let highlightColor: Color = Color.accentColor;
    static let buttonColor: Color = Color.accentColor;
    static let sliderColor: Color = Color.accentColor;
    static let blueprintColor: Color = MultiColor(cgColor: CGColor(srgbRed: 0, green: 49 / 100.0, blue: 83 / 100.0, alpha: 1.0)).swuiColor
    static let panelColor: Color = Color(.tertiarySystemFill)
    
}
