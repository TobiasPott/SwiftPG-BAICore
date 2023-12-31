import SwiftUI

public extension Lego {
    static let dots: Palette = Palette(name: "Lego DOTS", colors: Lego.dotsColors, names: Lego.dotsColorNames)
    
    // DOTS color palette
    private static let dotsColorNames: [String] = [ "blue", "coral", "lavender", "aqua", "white", "black", "brightLightOrange", "brightLightYellow", "brightGreen", "brightPink", "darkBluishGray", "darkTurquoise", "darkBlue", "darkGreen", "darkPurple", "darkAzure", "magenta", "mediumAzure", "orange", "red", "yellow", "yellowishGreen", "sandGreen", "vibrantYellow" ];
    private static let dotsColors: [ColorType] = [blue, coral, lavender, aqua, white, black, brightLightOrange, brightLightYellow, brightGreen, brightPink, darkBluishGray, darkTurquoise, darkBlue, darkGreen, darkPurple, darkAzure, magenta, mediumAzure, orange, red, yellow, yellowishGreen, sandGreen, vibrantYellow ];
    
}
