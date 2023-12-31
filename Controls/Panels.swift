import SwiftUI

public enum PanelOrientation {
    case horizonal, vertical
}
struct RoundedPanel<Content: View>: View {
    
    @ViewBuilder let content: () -> Content;
    let orientation: PanelOrientation;
    var padding: CGFloat = 0;
    var spacing: CGFloat = 5;
    var background: Color = Styling.panelColor; 
    var paddingIsSpacing: Bool = false;
    
    
    var verticalAlignment: HorizontalAlignment = .center;
    var horizontalAlignment: VerticalAlignment = .center; 
    
    var body: some View {
        Group {
            if(orientation == .vertical) {
                VStack(alignment: verticalAlignment, spacing: paddingIsSpacing ? padding : spacing) { content(); }
            } else {
                HStack(alignment: horizontalAlignment, spacing: paddingIsSpacing ? padding : spacing) { content(); }
            }
        }
        .padding(.all, padding)
        .background(Styling.roundedRect.foregroundColor(background).opacity(0.75))
    }
}
struct ToolbarPanel<Content: View>: View {
    
    @ViewBuilder let content: () -> Content;
    let orientation: PanelOrientation;
    var padding: CGFloat = 5;
    var spacing: CGFloat = 5;
    var background: Color = Styling.black.opacity(0.6); 
    var paddingIsSpacing: Bool = false;
    
    
    var verticalAlignment: HorizontalAlignment = .center;
    var horizontalAlignment: VerticalAlignment = .center; 
    
    var body: some View {
        RoundedPanel(content: content, orientation: orientation, padding: padding, spacing: spacing, background: background, paddingIsSpacing: paddingIsSpacing, verticalAlignment: verticalAlignment, horizontalAlignment: horizontalAlignment)
    }
}
