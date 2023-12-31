import SwiftUI

// https://en.wikipedia.org/wiki/List_of_8-bit_computer_hardware_graphics

public extension ArtPalette {
    
    static let rgb3bit: Palette = Palette(name: "Retro RGB 3-Bit", colors: rgb3BitColors, names: rgb3BitColorNames)
    
    // 3-Bit RGB Retro PC to Lego mapped color palette
    private static let rgb3BitColorNames: [String] = [ "black", "blue", "green", "cyan", "red", "magenta", "yellow", "white" ];
    private static let rgb3BitColors: [ColorType] = [ArtPalette.black, ArtPalette.blue, ArtPalette.brightGreen, ArtPalette.lightTurquoise, ArtPalette.red, ArtPalette.pink, ArtPalette.yellow, ArtPalette.white];
    
    // ToDo: Add 'dark'/'bright' color variants
    //    
    //    static let rgbi4bit: Palette = Palette(name: "Retro RGBI 4-Bit", colors: Retro8Bit.rgbi4BitColors, names: Retro8Bit.rgbi4BitColorNames)
    //    
    //    // 4-Bit RGBI Retro PC to Lego mapped color palette
    //    private static let rgbi4BitColorNames: [String] = [ "black", "blue", "green", "cyan", "red", "magenta", "yellow", "white" ];
    //    private static let rgbi4BitColors: [ColorType] = [Lego.black, Lego.blue, Lego.green, Lego.darkTurquoise, Lego.red, Lego.pink, Lego.yellow, Lego.white];
    //    
}
