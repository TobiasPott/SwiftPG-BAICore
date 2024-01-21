import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: GlobalState;
    @EnvironmentObject var gestures: GestureState;
    
    
    @ObservedObject var source: ArtSource;
    @State var scale: CGFloat = 10.0
    @State var scaleFactor: CGFloat = 1.0
    
    var body: some View {
        VStack(content: {
            ToolbarPanel(content: {
                RoundedButton(sName: "viewfinder.circle", size: 28.0, action: { gestures.srcDrag.location = CGPoint.zero; gestures.srcDrag.fixedLocation = CGPoint.zero })
                RoundedLockButton(sName: "arrow.up.and.down.and.arrow.left.and.right", size: 28.0, action: { gestures.srcDrag.enabled = gestures.srcDrag.enabled.not; }, isLocked: !gestures.srcDrag.enabled)
                RoundedLockButton(sName: "magnifyingglass", size: 28.0, action: { gestures.srcZoom.enabled = gestures.srcZoom.enabled.not; }, isLocked: !gestures.srcZoom.enabled)
            }, orientation: PanelOrientation.vertical)
        })        
    }
}
