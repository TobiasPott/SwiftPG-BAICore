import SwiftUI

struct BrickArtToolbar: View {
    @Binding var brickOutline: BrickOutlineMode
    @Binding var drag: DragInfo
    @Binding var zoom: ZoomInfo
    
    var body: some View {
        
        ToolbarPanel(content: {
            RoundedButton(systemName: "viewfinder.circle", action: { drag.location = CGPoint.zero; drag.fixedLocation = CGPoint.zero })
            
            RoundedLockButton(systemName: "circle.square", action: { 
                brickOutline = brickOutline == BrickOutlineMode.outlined ? BrickOutlineMode.none : BrickOutlineMode.outlined
            }, isLocked: brickOutline == BrickOutlineMode.none)
            
        }, orientation: PanelOrientation.vertical)
        .toggleStyle(ButtonToggleStyle())
    }
}
