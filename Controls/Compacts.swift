import SwiftUI

struct UserModePicker: View {
    @Binding var userMode: UserMode
    
    var body: some View {
        
        Picker(selection: $userMode, content: {
            Text("Guided").tag(UserMode.guided)
            Text("Simple").tag(UserMode.simple)
            //            Label("Advanced", systemImage: "rectangle.on.rectangle.badge.gearshape").tag(UserMode.advanced)
        }, label: { })
    }
}

struct Highlight<Content: View>: View{
    var content: () -> Content;
    var alignment: VerticalAlignment = VerticalAlignment.center
    
    var color: Color = Styling.highlightColor
    var useCaption: Bool = true
    var useIcon: Bool = true
    var systemName: String = "i.circle"
    
    var icon: some View {
        Image(systemName: systemName)
            .resizable()
            .padding(3.0)
            .background(color)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: alignment) {
                content()
                RootView.spacerZeroLength
            }
            .padding(6.0)
            if (useIcon) {
                HStack {
                    Spacer()
                    icon
                        .mask(Styling.roundedRectTLBR)
                        .frameSquare(20.0)
                }
                .padding(Edge.Set.top, -16.0)
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
        if (state.userMode == UserMode.guided) {
            Highlight(content: { Text(text) })
        } else {
            EmptyView()
        }
    }
}

struct LabelledText: View {
    let label: String;
    let text: String;
    
    var alignment: VerticalAlignment = VerticalAlignment.center
    
    var body: some View {
        HStack(alignment: alignment) { 
            Text(label); RootView.spacerZeroLength; Text(text);
        }
    }
}

struct CompactIconPicker<Content: View>: View {
    @Binding var value: Int;
    let systemName: String;
    var autoSpace: Bool = true
    var autoExpand: Bool = false
    
    @ViewBuilder let content: () -> Content;
    var size: CGFloat = 18.0;
    
    var body: some View {
        ZStack() {
            HStack(alignment: VerticalAlignment.center) { 
                SNImage.get(systemName)
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fit)
                    .frame(width: size, height: size) 
                if(autoSpace) { RootView.spacerZeroLength }
            }
            HStack { 
                if(autoSpace) { RootView.spacerZeroLength; }
                Picker(selection: $value, label: EmptyView()) { content() }
                    .padding(Edge.Set.trailing, -16.0)
            }
        }
        .frame(maxWidth: 36.0 + size + (autoExpand ? CGFloat.infinity : 0.0))
    }
}




