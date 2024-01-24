import SwiftUI

struct ColorSwatchList: View {
    private static let gridItem: GridItem = GridItem(GridItem.Size.adaptive(minimum: 160.0, maximum: 165.0));
    
    let colorsWithCount: Dictionary<MultiColor, Int>;
    let palette: Palette;
    let isWide: Bool    
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: ColorSwatchList.gridItem, count: isWide ? 4 : 2), spacing: 2.0) {
            let dictKeys = getSortedKeys()
            ForEach(dictKeys, id: \.self) { key in
                ColorSwatch(color: key, numberOfUses: colorsWithCount[key] ?? 0, palette: palette)
                    .aspectRatio(5.0, contentMode: ContentMode.fit)
            }
        }.padding(6.0)
    }
    
    func getSortedKeys(asc: Bool = true) -> [MultiColor] {
        var keys = Array(colorsWithCount.keys)
        keys.sort { 
            let lhIndex = palette.findClosest($0)
            let lhName = lhIndex >= 0 ? palette.get(lhIndex).name : "none"
            let rhIndex = palette.findClosest($1)
            let rhName = rhIndex >= 0 ? palette.get(rhIndex).name : "none"
            return asc ? lhName < rhName : lhName > rhName
        }
        return keys
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
        
        HStack(spacing: 4.0) {
            color.swuiColor
                .aspectRatio(1.0, contentMode: ContentMode.fill)
                .mask(Styling.roundedRect)
                .frameMax(32.0)
            VStack(alignment: HorizontalAlignment.leading) {
                HStack(spacing: 0.0) { Text("x \(numberOfUses)"); Spacer(); }.fontWeight(Font.Weight.bold)
                HStack(spacing: 0.0) { Text("\(colorInfo.name)") }
            }
            .frameStretch(Alignment.topLeading)
            .font(Styling.footnoteFont)
        }
    }
    
}
