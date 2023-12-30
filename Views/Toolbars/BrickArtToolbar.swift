import SwiftUI

struct BrickArtToolbar: View {
    @EnvironmentObject var state: AppState;
    
    
    var body: some View {
        
        RoundedPanel(content: {
            
            RoundedStateButton(systemName: state.brickOutline == .none ? "square" : "circle.square", action: { 
                state.brickOutline = state.brickOutline == .outlined ? .none : .outlined
            }, state: state.brickOutline == .none)
            
//            Spacer()
        }, orientation: .vertical)
        .toggleStyle(.button)
    }
}
