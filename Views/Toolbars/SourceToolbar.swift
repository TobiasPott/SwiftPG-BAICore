import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: GlobalState;
    @EnvironmentObject var gestures: GestureState;
    
    var forLargeScreen: Bool = false
    
    var body: some View {
        let size = forLargeScreen ? Styling.buttonSize * 1.5 : Styling.buttonSize;
        
        VStack(content: {
            ToolbarPanel(content: {
                RoundedButton(sName: "viewfinder.circle", size: size, action: { gestures.srcDrag.location = CGPoint.zero; gestures.srcDrag.fixedLocation = CGPoint.zero })
                RoundedLockButton(sName: "arrow.up.and.down.and.arrow.left.and.right", size: size, action: { gestures.srcDrag.enabled = gestures.srcDrag.enabled.not; }, isLocked: !gestures.srcDrag.enabled)
                RoundedLockButton(sName: "magnifyingglass", size: size, action: { gestures.srcZoom.enabled = gestures.srcZoom.enabled.not; }, isLocked: !gestures.srcZoom.enabled)
            }, orientation: PanelOrientation.vertical)
        })        
    }
}
