import SwiftUI

public extension ArtPalette {
    static let mosaicMakerName: String = "Lego Mosaic Maker"
    static let mosaicMaker: Palette = Palette(name: mosaicMakerName, colors: mosaicMakerColors)
    static let mosaicMakerInv: ArtInventory = ArtInventory.inventory(mosaicMakerName, inventory: ArtInventory(name: mosaicMakerName, items: mosaicMakerItems))
    
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
