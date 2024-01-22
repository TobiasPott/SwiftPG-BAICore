import SwiftUI

struct BrickArtToolbar: View {
    @Binding var outline: BrickOutlineMode
    @Binding var drag: DragInfo
    @Binding var zoom: ZoomInfo
    
    var forLargeScreen: Bool = false
    
    var body: some View {
        let size = forLargeScreen ? Styling.buttonSize * 1.3 : Styling.buttonSize;
        let padding = forLargeScreen ? Styling.buttonPadding * 1.3 : Styling.buttonPadding;
        
        ToolbarPanel(content: {
            RoundedButton(sName: "viewfinder.circle", size: size, action: { drag.location = CGPoint.zero; drag.fixedLocation = CGPoint.zero }, padding: padding)
            
            RoundedLockButton(sName: "circle.square", size: size, action: { 
                outline = outline == BrickOutlineMode.outlined ? BrickOutlineMode.none : BrickOutlineMode.outlined
            }, isLocked: outline == BrickOutlineMode.none, padding: padding)
            
        }, orientation: PanelOrientation.vertical)
    }
}
