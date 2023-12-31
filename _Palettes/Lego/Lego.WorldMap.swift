import SwiftUI

public extension ArtPalette {
    static let worldMap: Palette = Palette(name: "Lego World Map", colors: worldMapColors, names: worldMapColorNames)
    
    // World Map color palette
    private static let worldMapColorNames: [String] = [ "white", "tan", "orange", "mediumAzure", "lime", "darkTurquoise", "darkBlue", "coral", "brightLightOrange", "brightGreen" ];
    private static let worldMapColors: [ColorType] = [white, tan, orange, mediumAzure, lime, darkTurquoise, darkBlue, coral, brightLightOrange, brightGreen ];
    
}
