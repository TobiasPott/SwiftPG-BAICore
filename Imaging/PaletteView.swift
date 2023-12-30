import SwiftUI
import SwiftPG_Palettes

struct PalettePreview: View { 
    let palette: Palette;
    
    var body: some View {
        VStack {
            LazyVGrid(columns: [.init(.adaptive(minimum: 18, maximum: 24), spacing: 2, alignment: .topTrailing)]) {
                ForEach(0..<palette.names.count, id: \.self) { i in
                    palette.colors[i].swuiColor.aspectRatio(1.0, contentMode: .fill)
                }
            }
            HStack { Text("Contains \(palette.colors.count) Color\(palette.colors.count > 1 ? "s" : "")"); Spacer(); }
        }
    }
}

struct PalettePicker: View { 
    @Binding var selection: BuiltInPalette;
    
    var body: some View {
        HStack {
            Text("Palette")
            Spacer(minLength: 0)
            Picker(selection: $selection, label: Text("Picker")) {
                Text("Default").tag(BuiltInPalette.legoSimple)
                
                Label("Mosaic Maker", systemImage: "mosaic").tag(BuiltInPalette.legoMosaicMaker)
                Label("Batman", systemImage: "d.circle").tag(BuiltInPalette.legoDCBatman)
                
                Label("Floral Art", systemImage: "camera.macro.circle").tag(BuiltInPalette.legoFloralArt)
                Label("World Map", systemImage: "globe.europe.africa.fill").tag(BuiltInPalette.legoWorlMap)
                Label("DOTS", systemImage: "square.grid.3x3.square").tag(BuiltInPalette.legoDOTS)
                Divider()
                Label("Retro 3-Bit RGB", systemImage: "3.circle^").tag(BuiltInPalette.retroRGB3Bit)
            }
            
        }
        
    }
}
