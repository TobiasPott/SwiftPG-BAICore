import SwiftUI

struct CanvasToolbar: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var canvas: CanvasInfo;
    @ObservedObject var source: SourceInfo;
    
    @State var sliderChange: Bool = false;
    var body: some View {
        RoundedPanel(content: {
            
            RoundedStateButton(systemName: "lock.fill", action: { canvas.isLocked.toggle(); }, state: canvas.isLocked, stateColor: Styling.red, background: Styling.gray)
            
            if (!state.isNavState(.analysis)) {
                VStack(content: {
                    SNImage.squareArrowTriangle4Outward.rs().padding(5)
                    VerticalSlider<CGFloat>(value: $canvas.scale, in: 1.0...canvas.maxScale, step: 0.1, onEditingChanged: { changed in
                        if (sliderChange) {
                            _ = canvas.Analyse(source, state.palette)
                            sliderChange = false
                        } else {
                            sliderChange = true
                        }
                    })
                    .disabled(canvas.isLocked)
                    
                    Text("\(String(format: "%.1f", canvas.scale))")
                        .frame(maxHeight: 22)
                })    
                .frame(maxWidth: Styling.buttonSize)
                .font(Styling.captionFont)
            }
        }, orientation: .vertical)                
    }
}
