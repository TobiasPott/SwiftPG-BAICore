import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var source: ArtSource;
    @State var scale: CGFloat = 10.0
    @State var scaleFactor: CGFloat = 1.0
    
    var body: some View {
        VStack(content: {
            ToolbarPanel(content: {
                RoundedButton(systemName: "viewfinder.circle", size: 28, action: { state.drag.location = CGPoint.zero; state.drag.fixedLocation = CGPoint.zero })
                RoundedLockButton(systemName: "arrow.up.and.down.and.arrow.left.and.right", size: 28, action: { state.srcDragLocked.toggle(); }, isLocked: state.srcDragLocked)
                RoundedLockButton(systemName: "magnifyingglass", size: 28, action: { state.srcZoomLocked.toggle(); }, isLocked: state.srcZoomLocked, padding: 10.0)
                
//                VStack (spacing: 0) {
//                    RoundedImage(systemName: "plus.magnifyingglass", size: 28, padding: 10.0)
//                        .onTapGesture(perform: { scale += scaleFactor })
//                        .onLongPressGesture(minimumDuration: 0.5, perform: {
//                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
//                        })
//                    ZStack(alignment: .trailing) {
//                        Text("\(String(format: "%.1f", scale))")
//                            .frame(maxHeight: 24)
//                        Text("\(scaleFactor == 1.0 ? "\u{2581} \u{0020}" : "\u{0020} \u{2581}")").offset(x: 0, y: 1)
//                        Text("\(scaleFactor == 1.0 ? "\u{2594} \u{0020}" : "\u{0020} \u{2594}")").offset(x: 0, y: -3.0)
//                    }
//                    RoundedImage(systemName: "minus.magnifyingglass", size: 28, padding: 10.0)
//                        .onTapGesture(perform: { scale -= scaleFactor })
//                        .onLongPressGesture(minimumDuration: 0.5, perform: {
//                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
//                        })
//                }
//                .font(Styling.caption2Font.monospaced())
                
            }, orientation: .vertical)
        })        
    }
}
