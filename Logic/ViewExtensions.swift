import SwiftUI

extension View {
    func hidden(_ isHidden: Bool) -> some View {
        if (isHidden) {
            return AnyView(self.hidden())
        } else {
            return AnyView(self);
        }
    }
    
    func labelOverlay(label: String, alignment: Alignment = .topLeading, color: Color = Styling.panelColor, textColor: Color = .primary) -> some View {
        return self.overlay(content: { 
            Text(label).foregroundColor(textColor)    
                .padding(.horizontal, 3)
                .padding(3).frame(minWidth: 24)
                .font(Styling.captionFont)
                .background(Styling.roundedRect.foregroundColor(color.opacity(0.75)))
                .padding(6)
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
