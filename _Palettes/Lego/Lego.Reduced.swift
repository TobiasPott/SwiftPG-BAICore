import SwiftUI

public extension ArtPalette {
    static let reducedName: String = "Lego Reduced"
    static let reduced: Palette = Palette(name: reducedName, colors: reducedColors)
    static let reducedInv: ArtInventory = ArtInventory.inventory(reducedName, inventory: ArtInventory(name: reducedName, items: reducedItems, isEditable: false))
    
    // Simple color palette
    private static let reducedColors: [ArtColor] = [
        .init(White, white),
        .init(LightBluishGray, lightBluishGray),
        .init(DarkBluishGray, darkBluishGray),
        .init(PearlDarkGray, pearlDarkGray),
        .init(Black, black),
        .init(Red, red),
        .init(Green, green),
        .init(Blue, blue),
        .init(BrightGreen, brightGreen),
        .init(BrightLightBlue, brightLightBlue),
        .init(Aqua, aqua),
        .init(MediumAzure, mediumAzure),
        .init(DarkBlue, darkBlue),
        .init(Violet, violet),
        .init(Magenta, magenta),
        .init(DarkPink, darkPink),
        .init(MediumLavender, mediumLavender),
        .init(Rust, rust),
        .init(Salmon, salmon),
        .init(Orange, orange),
        .init(SandRed, sandRed),
        .init(Orange, darkOrange),
        .init(ReddishBrown, reddishBrown),
        .init(Tan, tan),
        .init(Flesh, flesh),
        // extended simple color set
    ]
    private static let reducedItems: [ArtInventory.Item] = [
        .init(White, defaultQuantity),
        .init(LightBluishGray, defaultQuantity),
        .init(DarkBluishGray, defaultQuantity),
        .init(PearlDarkGray, defaultQuantity),
        .init(Black, defaultQuantity),
        .init(Red, defaultQuantity),
        .init(Green, defaultQuantity),
        .init(Blue, defaultQuantity),
        .init(BrightGreen, defaultQuantity),
        .init(BrightLightBlue, defaultQuantity),
        .init(Aqua, defaultQuantity),
        .init(MediumAzure, defaultQuantity),
        .init(DarkBlue, defaultQuantity),
        .init(Violet, defaultQuantity),
        .init(Magenta, defaultQuantity),
        .init(DarkPink, defaultQuantity),
        .init(MediumLavender, defaultQuantity),
        .init(Rust, defaultQuantity),
        .init(Salmon, defaultQuantity),
        .init(Orange, defaultQuantity),
        .init(SandRed, defaultQuantity),
        .init(Orange, defaultQuantity),
        .init(ReddishBrown, defaultQuantity),
        .init(Tan, defaultQuantity),
        .init(Flesh, defaultQuantity),
        // extended simple color set
    ]
}
