import SwiftUI

public extension ArtPalette {
    static let dcBatman: Palette = Palette(name: "Lego DC Batman", colors: dcBatmanColors)
    
    // DC Batman color palette
    private static let dcBatmanColors: [ArtColor] = [
        ArtColor(White, white),
        ArtColor(LightBluishGray, lightBluishGray),
        ArtColor(DarkBluishGray, darkBluishGray),
        ArtColor(PearlDarkGray, pearlDarkGray),
        ArtColor(Black, black),
        ArtColor(Red, red),
        ArtColor(BrightGreen, brightGreen),
        ArtColor(Blue, blue),
        ArtColor(DarkBlue, darkBlue),
        ArtColor(Aqua, aqua),
        ArtColor(MediumAzure, mediumAzure),
        ArtColor(Orange, darkOrange),
        ArtColor(ReddishBrown, reddishBrown),
        ArtColor(Tan, tan),
        ArtColor(Flesh, flesh),
        ArtColor(MediumLavender, mediumLavender)
    ]
    
}
