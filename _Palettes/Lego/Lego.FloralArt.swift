import SwiftUI

public extension Lego {
    static let floralArt: Palette = Palette(name: "Lego Floral Art", colors: Lego.floralArtColors, names: Lego.floralArtColorNames)
    
    // Flower Art color palette
    private static let floralArtColorNames: [String] = [ "blue", "brightLightOrange", "brightPink", "darkBlue", "darkPink", "darkTurquoise", /* lightNougat, */ "lightFlesh", "white" ];
    private static let floralArtColors: [ColorType] = [blue, brightLightOrange, brightPink, darkBlue, darkPink, darkTurquoise, /* lightNougat, */ lightFlesh, white];
    
}
