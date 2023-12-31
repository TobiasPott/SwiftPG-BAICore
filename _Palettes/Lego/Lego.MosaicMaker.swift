import SwiftUI

public extension ArtPalette {
    static let mosaicMaker: Palette = Palette(name: "Lego Mosaic Maker", colors: mosaicMakerColors, names: mosaicMakerColorNames)
    
    // Mosaic Maker color palette
    private static let mosaicMakerColorNames: [String] = [ "white", "lightGray", "darkGray", "black", "yellow" ];
    private static let mosaicMakerColors: [ColorType] = [white, lightGray, darkGray, black, yellow];
    
}
