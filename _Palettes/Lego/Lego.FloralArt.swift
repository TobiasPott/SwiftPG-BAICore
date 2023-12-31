import SwiftUI

public extension ArtPalette {
    static let floralArt: Palette = Palette(name: "Lego Floral Art", colors: floralArtColors)
    
    // Flower Art color palette
    private static let floralArtColors: [ArtColor] = [
        ArtColor(White, white),
        ArtColor(Blue, blue),
        ArtColor(DarkBlue, darkBlue),
        ArtColor(DarkTurquoise, darkTurquoise),
        ArtColor(BrightPink, brightPink),
        ArtColor(DarkPink, darkPink),
        ArtColor(LightFlesh, lightFlesh),
        ArtColor(BrightLightOrange, brightLightOrange),
    ]
    
}
