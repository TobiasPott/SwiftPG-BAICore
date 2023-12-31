import SwiftUI
import SwiftPG_Palettes

struct UserModePicker: View {
    @Binding var userMode: UserMode
    
    var body: some View {
        
        Picker(selection: $userMode, content: {
            Label("Guided", systemImage: "info.bubble").tag(UserMode.guided)
            Label("Simple", systemImage: "rectangle").tag(UserMode.simple)
            //            Label("Advanced", systemImage: "rectangle.on.rectangle.badge.gearshape").tag(UserMode.advanced)
        }, label: { })
    }
}

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
                        .frameSquare(20)
                }
                .padding(.top, -16)
            }
        }
        .background(Styling.roundedRect.stroke(color, lineWidth: 2.0))
        .font(useCaption ? Styling.captionFont : Styling.bodyFont)
    }
}


struct GuideText: View {
    @EnvironmentObject var state: GlobalState
    
    var text: String = "";
    var alignment: VerticalAlignment = VerticalAlignment.center
    
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
            HStack(alignment: VerticalAlignment.center) { SNImage.get(systemName).resizable().aspectRatio(contentMode: .fit).frame(width: size, height: size) 
                if(autoSpace) { Spacer(minLength: 0); }
            }
            HStack { 
                if(autoSpace) { Spacer(minLength: 0); }
                Picker(selection: $value, label: EmptyView()) { content() }
                    .padding(.trailing, -16)
            }
        }
        .frame(maxWidth: 36 + size + (autoExpand ? CGFloat.infinity : 0))
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
            color.swuiColor
                .mask(Styling.roundedRect).aspectRatio(1.0, contentMode: .fit)
            VStack(alignment: HorizontalAlignment.leading) {
                HStack(spacing: 0) { Text("x \(numberOfUses)"); Spacer(); }.fontWeight(.bold)
                HStack(spacing: 0) { Text("\(colorInfo.name)") }
            }
            .padding(.horizontal, 3)
            .frameStretch(Alignment.topLeading)
            .font(Styling.footnoteFont)
        }
    }
    
}

struct ColorSwatchList: View {
    private static let gridItem: GridItem = GridItem(.adaptive(minimum: 160));
    
    let mappedColorsWithCount: Dictionary<MultiColor, Int>;
    let palette: Palette;
    let isWide: Bool    
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: ColorSwatchList.gridItem, count: isWide ? 4 : 2), spacing: 2) {
            ForEach(0..<mappedColorsWithCount.count, id: \.self) { i in
                let index = mappedColorsWithCount.index(mappedColorsWithCount.startIndex, offsetBy: i)
                let kvPair = mappedColorsWithCount[index];
                
                CompactSwatch(color: kvPair.key, numberOfUses: kvPair.value, palette: palette)
                    .aspectRatio(5, contentMode: .fit)
            }
        }.padding(.top, 6)
    }
}
