import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: GlobalState;
    @EnvironmentObject var gestures: GestureState;
    
    var forLargeScreen: Bool = false
    
    var body: some View {
        let size = forLargeScreen ? Styling.buttonSize * 1.3 : Styling.buttonSize;
        let padding = forLargeScreen ? Styling.buttonPadding * 1.3 : Styling.buttonPadding;
        
        VStack(content: {
            ToolbarPanel(content: {
                RoundedButton(sName: "viewfinder.circle", size: size, action: { gestures.srcDrag.location = CGPoint.zero; gestures.srcDrag.fixedLocation = CGPoint.zero }, padding: padding)
                RoundedLockButton(sName: "arrow.up.and.down.and.arrow.left.and.right", size: size, action: { gestures.srcDrag.enabled = gestures.srcDrag.enabled.not; }, isLocked: !gestures.srcDrag.enabled, padding: padding)
                RoundedLockButton(sName: "magnifyingglass", size: size, action: { gestures.srcZoom.enabled = gestures.srcZoom.enabled.not; }, isLocked: !gestures.srcZoom.enabled, padding: padding)
            }, orientation: PanelOrientation.vertical)
        })        
    }
}
