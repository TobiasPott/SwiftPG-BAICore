import SwiftUI

public extension ArtPalette {
    static let floralArt: Palette = Palette(name: "Lego Floral Art", colors: floralArtColors, names: floralArtColorNames)
    
    // Flower Art color palette
    private static let floralArtColorNames: [String] = [ "blue", "brightLightOrange", "brightPink", "darkBlue", "darkPink", "darkTurquoise", /* lightNougat, */ "lightFlesh", "white" ];
    private static let floralArtColors: [ColorType] = [blue, brightLightOrange, brightPink, darkBlue, darkPink, darkTurquoise, /* lightNougat, */ lightFlesh, white];
    
}
