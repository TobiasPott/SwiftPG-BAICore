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
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
        })
    }
    func colorSwatchOverlay(color: Color = Styling.panelColor) -> some View {
        return self.padding(3).frame(minWidth: 24)
            .font(Styling.captionFont)
            .background(Styling.roundedRect.foregroundColor(color.opacity(0.75)))
    }
    
    func square(_ size: CGFloat) -> some View {
        return self.frame(width: size, height: size);
    }
    
    func panelBackground(_ padding: CGFloat = 4, _ color: Color = Styling.panelColor) -> some View {
        return self.padding(padding).background(Styling.roundedRect.foregroundColor(color))
    }
    func panelInFrame(padding: CGFloat = 4, color: Color = Styling.panelColor, alignment: Alignment = .center) -> some View {
        return self.panelBackground(padding, color)
            .frameInfinity(alignment)
    }
    func frameInfinity(_ alignment: Alignment = .center) -> some View {
        return self.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
    
    func gesture<T>(_ gesture: T, enabled: Bool) -> some View where T : Gesture {
        if (enabled) {
            return AnyView(self.gesture(gesture))
        } else {
            return AnyView(self);
        }
    }
}
