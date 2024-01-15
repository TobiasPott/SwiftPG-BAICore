import SwiftUI
import PDFKit

extension View {
    func hidden(_ isHidden: Bool) -> some View {
        if (isHidden) {
            return AnyView(self.hidden())
        } else {
            return AnyView(self);
        }
    }
    func shadowOutline(_ color: Color, _ radius: CGFloat, _ offset: CGFloat = 1.0) -> some View {
        return self
        .shadow(color: color, radius: radius, x: 0, y: offset)
        .shadow(color: color, radius: radius, x: 0, y: -offset)
        .shadow(color: color, radius: radius, x: offset, y: 0)
        .shadow(color: color, radius: radius, x: -offset, y: 0)
    }
    func labelOverlay(label: String, alignment: Alignment = Alignment.topLeading, color: Color = Styling.black, textColor: Color = Styling.primary) -> some View {
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
    
    @MainActor public func asPDFPage(_ width: CGFloat) -> PDFPage? {
        return PDFPage(image: ImageRenderer(content: self.frame(width: width)).uiImage!)
    }
    
    @MainActor public func asUIImage(_ width: CGFloat) -> UIImage {
        return ImageRenderer(content: self.frame(width: width)).uiImage!
    }
}
