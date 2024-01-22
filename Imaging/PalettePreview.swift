import SwiftUI

struct PalettePreview: View { 
    let palette: Palette;
    var size: CGFloat = 24.0
    
    @State var showList: Bool = false
    
    var body: some View {
        VStack {
            HStack { 
                Text("Contains \(palette.count) Color\(palette.count > 1 ? "s" : "")");
                Spacer(); 
                Toggle(isOn: $showList, label: {
                    Image(systemName: "list.dash")
                }).toggleStyle(ButtonToggleStyle())
            }.font(Styling.captionFont)
            if (!showList) {
                LazyVGrid(columns: [GridItem(GridItem.Size.adaptive(minimum: size, maximum: size), spacing: 2.0, alignment: Alignment.topTrailing)]) {
                    ForEach(0..<palette.count, id: \.self) { i in
                        palette.artColors[i].swuiColor.aspectRatio(1.0, contentMode: ContentMode.fit)
                            .mask(Styling.roundedRectHalf)
                    }
                }
            } else {
                ScrollView(content: {
                    VStack(alignment: HorizontalAlignment.leading, spacing: 2.0){
                        ForEach(0..<palette.count, id: \.self) { i in
                            HStack {
                                palette.artColors[i].swuiColor
                                    .aspectRatio(1.0, contentMode: ContentMode.fit)
                                    .mask(Styling.roundedRectHalf)
                                Text("\(palette.artColors[i].name)")
                                Spacer()
                            }.frame(maxHeight: 18.0)
                        }
                    }   
                    .font(Styling.captionFont.monospaced())
                })
                .frame(maxHeight: 240.0)
            }
        }
    }
}




