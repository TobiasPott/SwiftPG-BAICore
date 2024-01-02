import SwiftUI

public extension ArtPalette {
    static let reduced: Palette = Palette(name: "Lego Simple", colors: reducedColors)
    
    // Simple color palette
    private static let reducedColors: [ArtColor] = [
        ArtColor(White, white),
        ArtColor(LightBluishGray, lightBluishGray),
        ArtColor(DarkBluishGray, darkBluishGray),
        ArtColor(PearlDarkGray, pearlDarkGray),
        ArtColor(Black, black),
        ArtColor(Red, red),
        ArtColor(Green, green),
        ArtColor(Blue, blue),
        ArtColor(BrightGreen, brightGreen),
        ArtColor(BrightLightBlue, brightLightBlue),
        ArtColor(Aqua, aqua),
        ArtColor(MediumAzure, mediumAzure),
        ArtColor(DarkBlue, darkBlue),
        ArtColor(Violet, violet),
        ArtColor(Magenta, magenta),
        ArtColor(DarkPink, darkPink),
        ArtColor(MediumLavender, mediumLavender),
        ArtColor(Rust, rust),
        ArtColor(Salmon, salmon),
        ArtColor(Orange, orange),
        ArtColor(SandRed, sandRed),
        ArtColor(Orange, darkOrange),
        ArtColor(ReddishBrown, reddishBrown),
        ArtColor(Tan, tan),
        ArtColor(Flesh, flesh),
        // extended simple color set
    ]
    private static let simpleColorNames: [String] = [ "black", "blue", "green", "darkTurquoise", "red", "darkPink", "brown", "lightGray", "darkGray", "lightBlue", "brightGreen", "lightTurquoise", "salmon", "pink", "yellow", "white", "lightGreen", "lightYellow", "tan", "lightViolet", "purple", "darkBlueViolet", "orange", "magenta", "lime", "darkTan", "brightPink", "mediumLavender", "lavender", "veryLightOrange", "lightPurple", "reddishBrown", "lightBluishGray", "darkBluishGray", "mediumBlue", "mediumGreen", "lightPink", "lightFlesh", "metallicSilver", "metallicGreen", "metallicGold", "mediumDarkFlesh", "darkPurple", "darkFlesh", "royalBlue", "flesh", "lightSalmon", "violet", "blueViolet", "mediumLime", "aqua", "lightLime", "lightOrange", "copper", "metalBlue", "veryLightBluishGray", "yellowishGreen", "flatDarkGold", "flatSilver", "pearlLightGray", "pearlLightGold", "pearlDarkGray", "pearlVeryLightGray", "pearlWhite", "brightLightOrange", "brightLightBlue", "rust", "brightLightYellow", "skyBlue", "darkBlue", "darkGreen", "pearlGold", "darkBrown", "darkRed", "darkAzure", "mediumAzure", "lightAque", "oliveGreen", "sandRed", "mediumDarkPink", "earthOrange", "sandPurple", "sandGreen", "sandBlue", "fabulandBrown", "mediumOrange", "darkOrange", "veryLightGray", "mediumViolet", "reddishLilac", "coral", "vibrantYellow" ];
    /*
     private static let simpleColors: [ColorType] = [black, blue, green, darkTurquoise, red, darkPink, brown, lightGray, darkGray, lightBlue, brightGreen, lightTurquoise, salmon, pink, yellow, white, lightGreen, lightYellow, tan, lightViolet, purple, darkBlueViolet, orange, magenta, lime, darkTan, brightPink, mediumLavender, lavender, veryLightOrange, lightPurple, reddishBrown, lightBluishGray, darkBluishGray, mediumBlue, mediumGreen, lightPink, lightFlesh, metallicSilver, metallicGreen, metallicGold, mediumDarkFlesh, darkPurple, darkFlesh, royalBlue, flesh, lightSalmon, violet, blueViolet, mediumLime, aqua, lightLime, lightOrange, copper, metalBlue, veryLightBluishGray, yellowishGreen, flatDarkGold, flatSilver, pearlLightGray, pearlLightGold, pearlDarkGray, pearlVeryLightGray, pearlWhite, brightLightOrange, brightLightBlue, rust, brightLightYellow, skyBlue, darkBlue, darkGreen, pearlGold, darkBrown, darkRed, darkAzure, mediumAzure, lightAque, oliveGreen, sandRed, mediumDarkPink, earthOrange, sandPurple, sandGreen, sandBlue, fabulandBrown, mediumOrange, darkOrange, veryLightGray, mediumViolet, reddishLilac, coral, vibrantYellow];
     */
}
