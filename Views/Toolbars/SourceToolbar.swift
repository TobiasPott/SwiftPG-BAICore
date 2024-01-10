import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var source: ArtSource;
    @State var scale: CGFloat = 10.0
    @State var scaleFactor: CGFloat = 1.0
    
    var body: some View {
        VStack(content: {
            ToolbarPanel(content: {
                RoundedButton(sName: "viewfinder.circle", size: 28.0, action: { state.drag.location = CGPoint.zero; state.drag.fixedLocation = CGPoint.zero })
                RoundedLockButton(sName: "arrow.up.and.down.and.arrow.left.and.right", size: 28.0, action: { state.srcDragLocked = state.srcDragLocked.not; }, isLocked: state.srcDragLocked)
                RoundedLockButton(sName: "magnifyingglass", size: 28.0, action: { state.srcZoomLocked = state.srcZoomLocked.not; }, isLocked: state.srcZoomLocked)
            }, orientation: PanelOrientation.vertical)
        })        
    }
}
