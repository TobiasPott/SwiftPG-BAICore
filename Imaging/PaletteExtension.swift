import SwiftUI
import simd
import SwiftPG_Palettes

public enum BuiltInPalette {
    case lego, legoSimple, legoMosaicMaker, legoDCBatman, legoFloralArt, legoWorlMap, legoDOTS, retroRGB3Bit
}

public extension MultiColor {
    var swuiColor: Color {
        return Color(hue: self.hue, saturation: self.saturation, brightness: self.brightness, opacity: 1.0)    
    }
}

public extension Palette {
    static func getPalette(_ builtIn: BuiltInPalette) -> Palette {
        switch(builtIn) {
        case .lego:
            return Lego.all;
        case .legoSimple:
            return Lego.simple;
        case .legoMosaicMaker:
            return Lego.mosaicMaker;
        case .legoDCBatman:
            return Lego.dcBatman;
        case .legoFloralArt:
            return Lego.floralArt;
        case .legoWorlMap:
            return Lego.worldMap;
        case .legoDOTS:
            return Lego.dots;
        case .retroRGB3Bit:
            return Retro8Bit.rgb3bit
        }
    }
    
}
