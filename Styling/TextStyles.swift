import SwiftUI
struct ShadowOutline: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadowOutline(Styling.black.opacity(0.75), 1, 1)
            .foregroundColor(Styling.primary)

    }
}
struct ShadowText: ViewModifier {
    var font: Font = Styling.headlineFont
    
    func body(content: Content) -> some View {
        content
            .font(font).bold()
            .modifier(ShadowOutline())
    }
}
