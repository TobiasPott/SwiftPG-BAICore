import SwiftUI

public extension ArtPalette {
    static let worldMap: Palette = Palette(name: "Lego World Map", colors: worldMapColors)
    
    // World Map color palette
    private static let worldMapColors: [ArtColor] = [
        ArtColor(White, white),
        ArtColor(Tan, tan),
        ArtColor(Orange, orange),
        ArtColor(MediumAzure, mediumAzure),
        ArtColor(Lime, lime),
        ArtColor(DarkTurquoise, darkTurquoise),
        ArtColor(DarkBlue, darkBlue),
        ArtColor(Coral, coral),
        ArtColor(BrightLightOrange, brightLightOrange),
        ArtColor(BrightGreen, brightGreen)
    ]
    
}
