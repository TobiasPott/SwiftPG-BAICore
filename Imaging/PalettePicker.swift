import SwiftUI

struct PalettePicker: View { 
    @Binding var selection: BuiltInPalette;
    
    var body: some View {
        Picker(selection: $selection, label: Text("Picker")) {
            Text("Full").tag(BuiltInPalette.lego)
            Text("Reduced").tag(BuiltInPalette.legoReduced)
            Text("DOTS").tag(BuiltInPalette.legoDOTS)
            Divider()
            Text("Mosaic Maker (40179)").tag(BuiltInPalette.legoMosaicMaker)
            Text("Batman (31205)").tag(BuiltInPalette.legoDCBatman)
            Text("Floral Art (31207)").tag(BuiltInPalette.legoFloralArt)
            Text("World Map (31203)").tag(BuiltInPalette.legoWorlMap)
            Divider()
            Text("Retro 3-Bit").tag(BuiltInPalette.retroRGB3Bit)
        }
        
    }
}
