import SwiftUI

public extension ArtPalette {
    static let mosaicMaker: Palette = Palette(name: "Lego Mosaic Maker", colors: mosaicMakerColors)
    
    // Mosaic Maker color palette
    private static let mosaicMakerColors: [ArtColor] = [
        ArtColor(White, white),
        ArtColor(LightGray, lightGray),
        ArtColor(DarkGray, darkGray),
        ArtColor(Black, black),
        ArtColor(Yellow, yellow),
    ]
}
