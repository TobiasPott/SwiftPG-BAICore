import SwiftUI

public enum PanelOrientation {
    case horizonal, vertical
}
struct RoundedPanel<Content: View>: View {
    
    @ViewBuilder let content: () -> Content;
    let orientation: PanelOrientation;
    var padding: CGFloat = 0;
    var spacing: CGFloat = 5;
    var background: Color = Styling.panelColor.opacity(0.75); 
    var paddingIsSpacing: Bool = false;
    
    
    var verticalAlignment: HorizontalAlignment = HorizontalAlignment.center;
    var horizontalAlignment: VerticalAlignment = VerticalAlignment.center; 
    
    var body: some View {
        Group {
            if(orientation == PanelOrientation.vertical) {
                VStack(alignment: verticalAlignment, spacing: paddingIsSpacing ? padding : spacing) { content(); }
            } else {
                HStack(alignment: horizontalAlignment, spacing: paddingIsSpacing ? padding : spacing) { content(); }
            }
        }
        .padding(Edge.Set.all, padding)
        .background(background)
        .mask(Styling.roundedRect)
    }
}
struct ToolbarPanel<Content: View>: View {
    
    @ViewBuilder let content: () -> Content;
    let orientation: PanelOrientation;
    var padding: CGFloat = 5;
    var spacing: CGFloat = 5;
    var background: Color = Styling.black.opacity(0.6); 
    var paddingIsSpacing: Bool = false;
    
    
    var verticalAlignment: HorizontalAlignment = HorizontalAlignment.center;
    var horizontalAlignment: VerticalAlignment = VerticalAlignment.center; 
    
    var body: some View {
        RoundedPanel(content: content, orientation: orientation, padding: padding, spacing: spacing, background: background, paddingIsSpacing: paddingIsSpacing, verticalAlignment: verticalAlignment, horizontalAlignment: horizontalAlignment)
    }
}
