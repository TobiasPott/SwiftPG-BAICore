import SwiftUI

extension View {
    
    func frameSquare(_ size: CGFloat) -> some View {
        return self.frame(width: size, height: size);
    }
    func frameRow(_ max: CGFloat = CGFloat.infinity, _ alignment: Alignment = Alignment.topLeading) -> some View {
        return self.frame(maxWidth: max, alignment: alignment)
    }
    func frameCol(_ max: CGFloat = CGFloat.infinity, _ alignment: Alignment = Alignment.topLeading) -> some View {
        return self.frame(maxHeight: max, alignment: alignment)
    }
    func frameStretch(_ alignment: Alignment = Alignment.topLeading) -> some View {
        return self.frame(maxWidth: CGFloat.infinity, maxHeight: CGFloat.infinity, alignment: alignment)
    }
    
    func frameMax(_ max: CGFloat, _ alignment: Alignment = Alignment.topLeading) -> some View {
        return self.frame(maxWidth: max, maxHeight: max, alignment: alignment)
    }
    func frameMax(_ maxSize: CGSize, _ alignment: Alignment = Alignment.topLeading) -> some View {
        return self.frame(maxWidth: maxSize.width, maxHeight: maxSize.height, alignment: alignment)
    }
    
}
