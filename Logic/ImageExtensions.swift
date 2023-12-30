import SwiftUI

extension Image {
    func rs(fit: Bool = true) -> some View {
        if (fit) { return AnyView(self.resizable().scaledToFit()) }
        else { return AnyView(self.resizable().scaledToFill()) }
    }
}
