import SwiftUI

struct ColorSwatchList: View {
    private static let gridItem: GridItem = GridItem(.adaptive(minimum: 160, maximum: 165));
    
    let colorsWithCount: Dictionary<MultiColor, Int>;
    let palette: Palette;
    let isWide: Bool    
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: ColorSwatchList.gridItem, count: isWide ? 4 : 2), spacing: 2) {
            ForEach(0..<colorsWithCount.count, id: \.self) { i in
                let index = colorsWithCount.index(colorsWithCount.startIndex, offsetBy: i)
                let kvPair = colorsWithCount[index];
                
                ColorSwatch(color: kvPair.key, numberOfUses: kvPair.value, palette: palette)
                    .aspectRatio(5, contentMode: .fit)
            }
        }.padding(6)
    }
}

struct ColorSwatch: View {
    
    var index: Int = -1
    let color: MultiColor;
    let numberOfUses: Int;
    let palette: Palette;
    
    var body: some View {
        let pIndex: Int = palette.findClosest(color);
        let colorInfo = pIndex >= 0 ? palette.get(pIndex) : ArtColor(name: "none", color: color);
        
        HStack(spacing: 4) {
            color.swuiColor
                .aspectRatio(1.0, contentMode: .fill)
                .mask(Styling.roundedRect)
                .frameMax(32)
            VStack(alignment: HorizontalAlignment.leading) {
                HStack(spacing: 0) { Text("x \(numberOfUses)"); Spacer(); }.fontWeight(.bold)
                HStack(spacing: 0) { Text("\(colorInfo.name)") }
            }
//            .padding(.ß, 3)
            .frameStretch(Alignment.topLeading)
            .font(Styling.footnoteFont)
        }
    }
    
}