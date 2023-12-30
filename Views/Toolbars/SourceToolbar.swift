import SwiftUI

struct SourceToolbar: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var source: SourceInfo;
    
    var body: some View {
        RoundedPanel(content: {
            RoundedButton(systemName: "viewfinder.circle", action: { state.drag.location = CGPoint.zero; state.drag.fixedLocation = CGPoint.zero })
            
            RoundedStateButton(systemName: "arrow.up.and.down.and.arrow.left.and.right", action: { state.srcDragLocked.toggle(); }, state: state.srcDragLocked, stateColor: .gray, background: Styling.buttonColor)
            
            RoundedStateButton(systemName: "magnifyingglass", action: { state.srcZoomLocked.toggle(); }, state: state.srcZoomLocked, stateColor: .gray, background: Styling.buttonColor, padding: 10.0)
            
            if (!state.isNavState(.analysis) && !state.srcZoomLocked) {
                RoundedPanel(content: {
                    VerticalSlider<CGFloat>(value: $state.zoom.scale, in: 15.0...max(64.0, state.zoom.scale), step: 1.0)
                        .frame(maxHeight: 96)
                    Text("\(Int(state.zoom.scale))")
                        .frame(maxHeight: 22)
                }, orientation: .vertical, padding: 0)    
                .frame(maxWidth: Styling.buttonSize)
                .font(Styling.captionFont)
            }
        }, orientation: .vertical)
        
    }
}
