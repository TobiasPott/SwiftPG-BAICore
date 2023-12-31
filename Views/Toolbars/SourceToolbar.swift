import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var source: ArtSource;
    
    var body: some View {
            
            
        VStack(content: {
            RoundedPanel(content: {
                RoundedButton(systemName: "viewfinder.circle", action: { state.drag.location = CGPoint.zero; state.drag.fixedLocation = CGPoint.zero })
                RoundedStateButton(systemName: "arrow.up.and.down.and.arrow.left.and.right", action: { state.srcDragLocked.toggle(); }, state: state.srcDragLocked, stateColor: Styling.gray, background: Styling.buttonColor)
                
                RoundedStateButton(systemName: "magnifyingglass", action: { state.srcZoomLocked.toggle(); }, state: state.srcZoomLocked, stateColor: Styling.gray, background: Styling.buttonColor, padding: 10.0)
                
            }, orientation: .vertical)
        })        
    }
}
