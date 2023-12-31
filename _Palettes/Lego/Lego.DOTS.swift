import SwiftUI

public extension ArtPalette {
    static let dots: Palette = Palette(name: "Lego DOTS", colors: dotsColors)
    
    // DOTS color palette
    private static let dotsColors: [ArtColor] = [
        ArtColor(White, white),
        ArtColor(Black, black),
        ArtColor(Blue, blue),        
        ArtColor(Orange, orange),
        ArtColor(Red, red),
        ArtColor(Yellow, yellow),
        ArtColor(Magenta, magenta),
        ArtColor(Coral, coral),
        ArtColor(Lavender, lavender),
        ArtColor(Aqua, aqua),
        ArtColor(BrightLightOrange, brightLightOrange),
        ArtColor(BrightLightYellow, brightLightYellow),
        ArtColor(BrightGreen, brightGreen),
        ArtColor(BrightPink, brightPink),
        ArtColor(DarkBluishGray, darkBluishGray),
        ArtColor(DarkTurquoise, darkTurquoise),
        ArtColor(DarkBlue, darkBlue),
        ArtColor(DarkGreen, darkGreen),
        ArtColor(DarkPurple, darkPurple),
        ArtColor(DarkAzure, darkAzure),
        ArtColor(MediumAzure, mediumAzure),
        ArtColor(YellowishGreen, yellowishGreen),
        ArtColor(SandGreen, sandGreen),
        ArtColor(VibrantYellow, vibrantYellow)
    ]
}
