import SwiftUI

public extension ArtPalette {
    static let mosaicMaker: Palette = Palette(name: "Lego Mosaic Maker", colors: mosaicMakerColors)
    static let mosaicMakerInv: ArtInventory = ArtInventory(name: "Lego Mosaic Maker", items: mosaicMakerItems)
    
    // Mosaic Maker color palette
    private static let mosaicMakerColors: [ArtColor] = [
        .init(White, white),
        .init(LightGray, lightGray),
        .init(DarkGray, darkGray),
        .init(Black, black),
        .init(Yellow, yellow),
    ]
    private static let mosaicMakerItems: [ArtInventory.Item] = [
        .init(White, 900),
        .init(LightGray, 900),
        .init(DarkGray, 900),
        .init(Black, 900),
        .init(Yellow, 900),
    ]
}
