import SwiftUI

struct CanvasToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var canvas: ArtCanvas;
    @ObservedObject var source: ArtSource;
    
    @State var sliderChange: Bool = false;
    var body: some View {
        ToolbarPanel(content: {
            RoundedLockButton(systemName: "square.arrowtriangle.4.outward", size: 28, action: { canvas.isLocked.toggle(); }, isLocked: canvas.isLocked)
            
            if (!state.isNavState(.analysis) && !canvas.isLocked) {
                VStack(content: {
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
                .frame(maxWidth: 28)
                .font(Styling.captionFont)
            }
        }, orientation: .vertical)                
    }
}
