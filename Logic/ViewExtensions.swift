import SwiftUI

extension View {
    func hidden(_ isHidden: Bool) -> some View {
        if (isHidden) {
            return AnyView(self.hidden())
        } else {
            return AnyView(self);
        }
    }
    
    func labelOverlay(label: String, alignment: Alignment = Alignment.topLeading, color: Color = Styling.panelColor, textColor: Color = Styling.primary) -> some View {
        return self.overlay(content: { 
            Text(label).foregroundColor(textColor)    
                .padding(Edge.Set.horizontal, 3.0)
                .padding(3.0).frame(minWidth: 24.0)
                .font(Styling.captionFont)
                .background(Styling.roundedRect.foregroundColor(color.opacity(0.75)))
                .padding(6.0)
                .frameStretch(alignment)
        })
    }
    
    func gesture<T>(_ gesture: T, enabled: Bool) -> some View where T : Gesture {
        if (enabled) {
            return AnyView(self.gesture(gesture))
        } else {
            return AnyView(self);
        }
    }
}
