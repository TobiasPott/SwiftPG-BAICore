import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var source: SourceInfo;
    
    var body: some View {
            
            
        VStack(content: {
            RoundedPanel(content: {
                RoundedButton(systemName: "viewfinder.circle", action: { state.drag.location = CGPoint.zero; state.drag.fixedLocation = CGPoint.zero })
                RoundedStateButton(systemName: "arrow.up.and.down.and.arrow.left.and.right", action: { state.srcDragLocked.toggle(); }, state: state.srcDragLocked, stateColor: .gray, background: Styling.buttonColor)
                
                RoundedStateButton(systemName: "magnifyingglass", action: { state.srcZoomLocked.toggle(); }, state: state.srcZoomLocked, stateColor: .gray, background: Styling.buttonColor, padding: 10.0)
                
            }, orientation: .vertical)
        })        
    }
}
