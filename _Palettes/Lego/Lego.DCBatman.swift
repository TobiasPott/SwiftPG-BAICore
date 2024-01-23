import SwiftUI

public extension ArtPalette {
    static let dcBatmanName: String = "Lego DC Batman"
    static let dcBatman: Palette = Palette(name: dcBatmanName, colors: dcBatmanColors)
    static let dcBatmanInv: ArtInventory = ArtInventory.inventory(dcBatmanName, inventory: ArtInventory(name: dcBatmanName, items: dcBatmanItems, isEditable: false))
    
    // DC Batman color palette
    private static let dcBatmanColors: [ArtColor] = [
        .init(White, white),
        .init(LightBluishGray, lightBluishGray),
        .init(DarkBluishGray, darkBluishGray),
        .init(PearlDarkGray, pearlDarkGray),
        .init(Black, black),
        .init(Red, red),
        .init(BrightGreen, brightGreen),
        .init(Blue, blue),
        .init(DarkBlue, darkBlue),
        .init(Aqua, aqua),
        .init(MediumAzure, mediumAzure),
        .init(Orange, darkOrange),
        .init(ReddishBrown, reddishBrown),
        .init(Tan, tan),
        .init(Flesh, flesh),
        .init(MediumLavender, mediumLavender)
    ]
    private static let dcBatmanItems: [ArtInventory.Item] = [
        .init(White, 257),
        .init(LightBluishGray, 277),
        .init(DarkBluishGray, 216),
        .init(PearlDarkGray, 432),
        .init(Black, 566),
        .init(Red, 112),
        .init(BrightGreen, 210),
        .init(Blue, 293),
        .init(DarkBlue, 423),
        .init(Aqua, 194),
        .init(MediumAzure, 139),
        .init(Orange, 55),
        .init(ReddishBrown, 165),
        .init(Tan, 380),
        .init(Flesh, 153),
        .init(MediumLavender, 95)
    ]

}
