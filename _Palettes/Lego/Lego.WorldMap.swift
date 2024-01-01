import SwiftUI

public extension ArtPalette {
    static let worldMap: Palette = Palette(name: "Lego World Map", colors: worldMapColors)
    static let worldMapInv: ArtInventory = ArtInventory(name: "Lego World Map", items: worldMapItems)
    
    // World Map color palette
    private static let worldMapColors: [ArtColor] = [
        .init(White, white),
        .init(Tan, tan),
        .init(Orange, orange),
        .init(MediumAzure, mediumAzure),
        .init(Lime, lime),
        .init(DarkTurquoise, darkTurquoise),
        .init(DarkBlue, darkBlue),
        .init(Coral, coral),
        .init(BrightLightOrange, brightLightOrange),
        .init(BrightGreen, brightGreen)
    ]
    private static let worldMapItems: [ArtInventory.Item] = [
        .init(White, 3064),
        .init(Tan, 725),
        .init(Orange, 601),
        .init(MediumAzure, 1607),
        .init(Lime, 1060),
        .init(DarkTurquoise, 1879),
        .init(DarkBlue, 393),
        .init(Coral, 601),
        .init(BrightLightOrange, 599),
        .init(BrightGreen, 601)
    ]
}
