import SwiftUI

struct BrickArtToolbar: View {
    @Binding var outline: BrickOutlineMode
    @Binding var drag: DragInfo
    @Binding var zoom: ZoomInfo
    
    var body: some View {
        
        ToolbarPanel(content: {
            RoundedButton(sName: "viewfinder.circle", action: { drag.location = CGPoint.zero; drag.fixedLocation = CGPoint.zero })
            
            RoundedLockButton(sName: "circle.square", action: { 
                outline = outline == BrickOutlineMode.outlined ? BrickOutlineMode.none : BrickOutlineMode.outlined
            }, isLocked: outline == BrickOutlineMode.none)
            
        }, orientation: PanelOrientation.vertical)
        .toggleStyle(ButtonToggleStyle())
    }
}
