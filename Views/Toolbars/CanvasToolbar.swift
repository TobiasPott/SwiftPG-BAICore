import SwiftUI

struct CanvasToolbar: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var canvas: CanvasInfo;
    @ObservedObject var source: SourceInfo;
    
    @State var sliderChange: Bool = false;
    var body: some View {
        RoundedPanel(content: {
            
            RoundedStateButton(systemName: "lock.fill", action: { canvas.isLocked.toggle(); }, state: canvas.isLocked, stateColor: .red, background: .gray)
            
            if (!state.isNavState(.analysis)) {
                RoundedPanel(content: {
                    SNImage.magnifyingglass.rs().padding(5)
                    VerticalSlider<CGFloat>(value: $canvas.scale, in: 1.0...canvas.maxScale, step: 0.1, onEditingChanged: { changed in
                        if (sliderChange) {
                            _ = canvas.Analyse(source, state.palette)
                            sliderChange = false
                        } else {
                            sliderChange = true
                        }
                    })
                        .disabled(canvas.isLocked)
                        .frame(maxHeight: 96)
                    
                    Text("\(Int(canvas.scale))")
                        .frame(maxHeight: 22)
                }, orientation: .vertical, padding: 0)    
                .frame(maxWidth: Styling.buttonSize)
                .font(.system(size: 14))
            }
        }, orientation: .vertical)
    }
}
