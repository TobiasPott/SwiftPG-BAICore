import SwiftUI

public extension Lego {
    static let mosaicMaker: Palette = Palette(name: "Lego Mosaic Maker", colors: Lego.mosaicMakerColors, names: Lego.mosaicMakerColorNames)
    
    // Mosaic Maker color palette
    private static let mosaicMakerColorNames: [String] = [ "white", "lightGray", "darkGray", "black", "yellow" ];
    private static let mosaicMakerColors: [ColorType] = [white, lightGray, darkGray, black, yellow];
    
}
