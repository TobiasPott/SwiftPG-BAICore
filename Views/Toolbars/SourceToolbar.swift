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
            }, orientation: .vertical)
        })        
    }
}
