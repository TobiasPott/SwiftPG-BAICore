import SwiftUI
import SwiftPG_Palettes

struct PalettePreview: View { 
    let palette: Palette;
    var size: CGFloat = 18
    
    var body: some View {
        VStack {
            
            LazyVGrid(columns: [.init(.adaptive(minimum: size, maximum: size + 6), spacing: 2, alignment: Alignment.topTrailing)]) {
                ForEach(0..<palette.names.count, id: \.self) { i in
                    palette.colors[i].swuiColor.aspectRatio(1.0, contentMode: .fit)
                }
            }
            HStack { Text("Contains \(palette.colors.count) Color\(palette.colors.count > 1 ? "s" : "")"); Spacer(); }.font(Styling.captionFont)
        }
    }
}

struct PalettePicker: View { 
    @Binding var selection: BuiltInPalette;
    
    var body: some View {
        Picker(selection: $selection, label: Text("Picker")) {
            Text("Default").tag(BuiltInPalette.legoSimple)
            //            Label("Mosaic Maker", systemImage: "mosaic")
            Text("Mosaic Maker").tag(BuiltInPalette.legoMosaicMaker)
            //            Label("Batman", systemImage: "d.circle")
            Text("Batman").tag(BuiltInPalette.legoDCBatman)
            
            //            Label("Floral Art", systemImage: "camera.macro.circle")
            Text("Floral Art").tag(BuiltInPalette.legoFloralArt)
            //            Label("World Map", systemImage: "globe.europe.africa.fill")
            Text("World Map").tag(BuiltInPalette.legoWorlMap)
            //            Label("DOTS", systemImage: "square.grid.3x3.square")
            Text("DOTS").tag(BuiltInPalette.legoDOTS)
            Divider()
            //            Label("Retro 3-Bit RGB", systemImage: "3.circle^")
            Text("Retro 3-Bit").tag(BuiltInPalette.retroRGB3Bit)
        }
        
    }
}


