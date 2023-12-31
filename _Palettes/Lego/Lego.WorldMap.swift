import SwiftUI

public extension Lego {
    static let worldMap: Palette = Palette(name: "Lego World Map", colors: Lego.worldMapColors, names: Lego.worldMapColorNames)
    
    // World Map color palette
    private static let worldMapColorNames: [String] = [ "white", "tan", "orange", "mediumAzure", "lime", "darkTurquoise", "darkBlue", "coral", "brightLightOrange", "brightGreen" ];
    private static let worldMapColors: [ColorType] = [white, tan, orange, mediumAzure, lime, darkTurquoise, darkBlue, coral, brightLightOrange, brightGreen ];
    
}
