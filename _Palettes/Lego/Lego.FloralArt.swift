import SwiftUI

public extension ArtPalette {
    static let floralArt: Palette = Palette(name: "Lego Floral Art", colors: floralArtColors)
    static let floralArtInv: ArtInventory = ArtInventory(name: "Lego Floral Art", items: floralArtItems)
    
    // Flower Art color palette
    private static let floralArtColors: [ArtColor] = [
        .init(White, white),
        .init(Blue, blue),
        .init(DarkBlue, darkBlue),
        .init(DarkTurquoise, darkTurquoise),
        .init(BrightPink, brightPink),
        .init(DarkPink, darkPink),
        .init(LightFlesh, lightFlesh),
        .init(BrightLightOrange, brightLightOrange),
    ]
    private static let floralArtItems: [ArtInventory.Item] = [
        .init(White, 550),
        .init(Blue, 242),
        .init(DarkBlue, 281),
        .init(DarkTurquoise, 370),
        .init(BrightPink, 158),
        .init(DarkPink, 370),
        .init(LightFlesh, 370),
        .init(BrightLightOrange, 370),
    ]
}
