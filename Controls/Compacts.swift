import SwiftUI
import SwiftPG_Palettes

struct Highlight<Content: View>: View{
    var content: () -> Content;
    var alignment: VerticalAlignment = .center
    
    var color: Color = Styling.highlightColor
    var useCaption: Bool = true
    var useIcon: Bool = true
    var systemName: String = "i.circle"
    
    var icon: some View {
        Image(systemName: systemName)
            .resizable()
            .padding(3)
            .background(color)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: alignment) {
                content()
                Spacer(minLength: 0)
            }
            .padding(6)
            if (useIcon) {
                HStack {
                    Spacer()
                    icon
                        .mask(Styling.roundedRectTLBR)
                        .frame(width: 20, height: 20)
                }
                .padding(.top, -16)
            }
        }
        .background(Styling.roundedRect.stroke(color, lineWidth: 2.0))
        .font(useCaption ? .caption : .body)
    }
}


struct GuideText: View {
    @EnvironmentObject var state: AppState
    
    var text: String = "";
    var alignment: VerticalAlignment = .center
    
    var body: some View {
        if (state.userMode == .guided) {
            Highlight(content: { Text(text) })
        } else {
            EmptyView()
        }
    }
}

struct LabelledText: View {
    let label: String;
    let text: String;
    
    var alignment: VerticalAlignment = .center
    
    var body: some View {
        HStack(alignment: alignment) { 
            Text(label); Spacer(minLength: 0); Text(text);
        }
    }
}

struct CompactIconPicker<Content: View>: View {
    @Binding var value: Int;
    let systemName: String;
    var autoSpace: Bool = true
    var autoExpand: Bool = false
    
    @ViewBuilder let content: () -> Content;
    var size: CGFloat = 18;
    
    var body: some View {
        ZStack() {
            HStack(alignment: .center) { SNImage.get(systemName).resizable().aspectRatio(contentMode: .fit).frame(width: size, height: size) 
                if(autoSpace) { Spacer(minLength: 0); }
            }
            HStack { 
                if(autoSpace) { Spacer(minLength: 0); }
                Picker(selection: $value, label: EmptyView()) { content() }
                    .padding(.trailing, -16)
            }
        }
        .frame(maxWidth: 36 + size + (autoExpand ? .infinity : 0))
    }
}

struct CompactSwatch: View {
    
    var index: Int = -1
    let color: MultiColor;
    let numberOfUses: Int;
    let palette: Palette;
    
    var body: some View {
        let pIndex: Int = palette.findClosest(color);
        let colorInfo = pIndex >= 0 ? palette.get(pIndex) : (color: color, name: "none");
        
        HStack(spacing: 2) {
            Color(cgColor: color.cgColor).mask(Styling.roundedRect).aspectRatio(1.0, contentMode: .fit)
            VStack(alignment: .leading) {
                Text("x \(numberOfUses)").fontWeight(.bold)
                HStack(spacing: 0) {
                    Text("\(colorInfo.name)")
                    Spacer();
                }
            }.padding(.horizontal, 3).colorSwatchOverlay().frameInfinity(.topLeading)
        }
    }
    
}

struct ColorSwatchList: View {
    private static let gridItem: GridItem = GridItem(.adaptive(minimum: 110, maximum: 200));
    
    let mappedColorsWithCount: Dictionary<MultiColor, Int>;
    let palette: Palette;
    var isWide: Bool = false    
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: ColorSwatchList.gridItem, count: isWide ? 4 : 2), spacing: 4) {
            ForEach(0..<mappedColorsWithCount.count, id: \.self) { i in
                let index = mappedColorsWithCount.index(mappedColorsWithCount.startIndex, offsetBy: i)
                let kvPair = mappedColorsWithCount[index];
                
                CompactSwatch(color: kvPair.key, numberOfUses: kvPair.value, palette: palette)
                    .aspectRatio(4.5, contentMode: .fill)
            }
        }.padding(.top, 6)
            .frame(alignment: .topTrailing)
    }
}
