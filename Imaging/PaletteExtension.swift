import SwiftUI
import simd

public enum BuiltInPalette {
    case lego, legoSimple, legoMosaicMaker, legoDCBatman, legoFloralArt, legoWorlMap, legoDOTS, retroRGB3Bit
}

public extension Palette {
    static func getPalette(_ builtIn: BuiltInPalette) -> Palette {
        switch(builtIn) {
        case .lego:
            return ArtPalette.all;
        case .legoSimple:
            return ArtPalette.simple;
        case .legoMosaicMaker:
            return ArtPalette.mosaicMaker;
        case .legoDCBatman:
            return ArtPalette.dcBatman;
        case .legoFloralArt:
            return ArtPalette.floralArt;
        case .legoWorlMap:
            return ArtPalette.worldMap;
        case .legoDOTS:
            return ArtPalette.dots;
        case .retroRGB3Bit:
            return ArtPalette.rgb3bit
        }
    }
    
}
