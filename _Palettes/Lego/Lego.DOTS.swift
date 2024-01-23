import SwiftUI

public extension ArtPalette {    
    static let dotsName: String = "Lego DOTS"
    static let dots: Palette = Palette(name: dotsName, colors: dotsColors)
    static let dotsInv: ArtInventory = ArtInventory.inventory(dotsName, inventory: ArtInventory(name: dotsName, items: dotsItems))
    
    // DOTS color palette
    private static let dotsColors: [ArtColor] = [
        .init(White, white),
        .init(Black, black),
        .init(Blue, blue),
        .init(Orange, orange),
        .init(Red, red),
        .init(Yellow, yellow),
        .init(Magenta, magenta),
        .init(Coral, coral),
        .init(Lavender, lavender),
        .init(Aqua, aqua),
        .init(BrightLightOrange, brightLightOrange),
        .init(BrightLightYellow, brightLightYellow),
        .init(BrightGreen, brightGreen),
        .init(BrightPink, brightPink),
        .init(DarkBluishGray, darkBluishGray),
        .init(DarkTurquoise, darkTurquoise),
        .init(DarkBlue, darkBlue),
        .init(DarkGreen, darkGreen),
        .init(DarkPurple, darkPurple),
        .init(DarkAzure, darkAzure),
        .init(MediumAzure, mediumAzure),
        .init(YellowishGreen, yellowishGreen),
        .init(SandGreen, sandGreen),
        .init(VibrantYellow, vibrantYellow)
    ]
    private static let dotsItems: [ArtInventory.Item] = [
        .init(White, defaultQuantity),
        .init(Black, defaultQuantity),
        .init(Blue, defaultQuantity),        
            .init(Orange, defaultQuantity),
        .init(Red, defaultQuantity),
        .init(Yellow, defaultQuantity),
        .init(Magenta, defaultQuantity),
        .init(Coral, defaultQuantity),
        .init(Lavender, defaultQuantity),
        .init(Aqua, defaultQuantity),
        .init(BrightLightOrange, defaultQuantity),
        .init(BrightLightYellow, defaultQuantity),
        .init(BrightGreen, defaultQuantity),
        .init(BrightPink, defaultQuantity),
        .init(DarkBluishGray, defaultQuantity),
        .init(DarkTurquoise, defaultQuantity),
        .init(DarkBlue, defaultQuantity),
        .init(DarkGreen, defaultQuantity),
        .init(DarkPurple, defaultQuantity),
        .init(DarkAzure, defaultQuantity),
        .init(MediumAzure, defaultQuantity),
        .init(YellowishGreen, defaultQuantity),
        .init(SandGreen, defaultQuantity),
        .init(VibrantYellow, defaultQuantity)
    ]
    
}
