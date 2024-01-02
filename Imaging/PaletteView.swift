import SwiftUI

struct PaletteRowPreview: View { 
    let palette: Palette;
    
    var max: Int = 24 
    let size: CGFloat
    
    var body: some View {
        GeometryReader(content: { geometry in
            let cMin = min(palette.count, Int(floor(geometry.size.width / (size + 2))))
            let isCapped = (CGFloat(cMin) * (size + 2)) >= CGFloat(geometry.size.width - 8)
            let nMin = cMin - (isCapped ? Int(ceil(50 / size)) : 0) 
            let overhang = palette.count - nMin
            let fMax = (overhang > 0 ? nMin : cMin)
            ZStack {
                LazyVGrid(columns: [.init(.adaptive(minimum: size, maximum: size), spacing: 2)]) {
                    ForEach(0..<fMax, id: \.self) { i in
                        palette.artColors[i].swuiColor.frameSquare(size)
                            .mask(Styling.roundedRectHalf)
                    }
                }
                
                if (overhang > 0) {
                    Text(" \(fMax) of \(palette.count) ")
                        .font(Styling.caption2Font)
                        .background(Styling.black.opacity(0.65))
                        .mask(Styling.roundedRect)
                        .frameRow(CGFloat.infinity, Alignment.trailing)
                }
            }
        })
        
    }
    
}

struct PalettePreview: View { 
    let palette: Palette;
    var size: CGFloat = 24
    
    @State var showList: Bool = false
    
    var body: some View {
        VStack {
            HStack { 
                Text("Contains \(palette.count) Color\(palette.count > 1 ? "s" : "")");
                Spacer(); 
                Toggle(isOn: $showList, label: {
                    Image(systemName: "list.dash")
                }).toggleStyle(.button)
            }.font(Styling.captionFont)
            if (!showList) {
                LazyVGrid(columns: [.init(.adaptive(minimum: size, maximum: size), spacing: 2, alignment: Alignment.topTrailing)]) {
                    ForEach(0..<palette.count, id: \.self) { i in
                        palette.artColors[i].swuiColor.aspectRatio(1.0, contentMode: .fit)
                            .mask(Styling.roundedRectHalf)
                    }
                }
            } else {
                ScrollView(content: {
                VStack(alignment: .leading, spacing: 2){
                    ForEach(0..<palette.count, id: \.self) { i in
                        HStack {
                            palette.artColors[i].swuiColor
                                .aspectRatio(1.0, contentMode: .fit)
                                .mask(Styling.roundedRectHalf)
                            Text("\(palette.artColors[i].name)")
                            Spacer()
                        }.frame(maxHeight: 18)
                    }
                }   
                .font(Styling.captionFont.monospaced())
                })
                .frame(maxHeight: 240)
//                .background(.red.opacity(0.4))
            }
        }
    }
}

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


