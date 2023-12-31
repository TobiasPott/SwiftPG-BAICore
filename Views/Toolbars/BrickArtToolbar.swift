import SwiftUI

struct BrickArtToolbar: View {
    @Binding var brickOutline: BrickOutlineMode
    @Binding var drag: DragInfo
    @Binding var zoom: ZoomInfo
    
    var body: some View {
        
        ToolbarPanel(content: {
            RoundedButton(systemName: "viewfinder.circle", action: { drag.location = CGPoint.zero; drag.fixedLocation = CGPoint.zero })
            
            RoundedLockButton(systemName: "circle.square", action: { 
                brickOutline = brickOutline == .outlined ? .none : .outlined
            }, isLocked: brickOutline != .none)
            
        }, orientation: .vertical)
        .toggleStyle(.button)
    }
}
