import SwiftUI

struct BrickArtToolbar: View {
    @Binding var brickOutline: BrickOutlineMode
    @Binding var drag: DragInfo
    @Binding var zoom: ZoomInfo
    
    var body: some View {
        
        RoundedPanel(content: {
            RoundedButton(systemName: "viewfinder.circle", action: { drag.location = CGPoint.zero; drag.fixedLocation = CGPoint.zero })
            
            RoundedStateButton(systemName: brickOutline == .none ? "square" : "circle.square", action: { 
                brickOutline = brickOutline == .outlined ? .none : .outlined
            }, state: brickOutline == .none)
            
        }, orientation: .vertical)
        .toggleStyle(.button)
    }
}
