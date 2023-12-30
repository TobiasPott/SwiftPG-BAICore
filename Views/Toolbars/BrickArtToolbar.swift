import SwiftUI

struct BrickArtToolbar: View {
    @EnvironmentObject var state: AppState;
    
    @Binding var drag: DragInfo
    @Binding var zoom: ZoomInfo
    
    var body: some View {
        
        RoundedPanel(content: {
            
            RoundedButton(systemName: "viewfinder.circle", action: { drag.location = CGPoint.zero; drag.fixedLocation = CGPoint.zero })
            
            RoundedStateButton(systemName: state.brickOutline == .none ? "square" : "circle.square", action: { 
                state.brickOutline = state.brickOutline == .outlined ? .none : .outlined
            }, state: state.brickOutline == .none)
            
//            Spacer()
        }, orientation: .vertical)
        .toggleStyle(.button)
    }
}
