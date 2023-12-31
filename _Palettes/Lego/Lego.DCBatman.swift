import SwiftUI

public extension ArtPalette {
    static let dcBatman: Palette = Palette(name: "Lego DC Batman", colors: dcBatmanColors, names: dcBatmanColorNames)
    
    // DC Batman color palette
    private static let dcBatmanColorNames: [String] = [ "white", "black", "blue",  "brightGreen", "darkBlue", "darkOrange", /* "darkStoneGray", */ "darkBluishGray", "flesh", /* "lightAqua", */"aqua", "mediumAzure", "mediumLavender", /* "mediumStoneGray", */ "lightBluishGray", "pearlDarkGray", "red", "reddishBrown", "tan"];
    private static let dcBatmanColors: [ColorType] = [white, black, blue, brightGreen, darkBlue, darkOrange, /* darkStoneGray, */ darkBluishGray, flesh, /* lightAqua, */aqua, mediumAzure, mediumLavender, /* mediumStoneGray, */ lightBluishGray, pearlDarkGray, red, reddishBrown, tan];
    
}
