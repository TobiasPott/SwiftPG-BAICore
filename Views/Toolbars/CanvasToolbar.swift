import SwiftUI

struct CanvasToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var canvas: ArtCanvas;
    @ObservedObject var source: ArtSource;
    
    @State var sliderChange: Bool = false;
    @State var scaleFactor: CGFloat = 1.0
    
    func updateScale(_ amount: CGFloat) {
        canvas.scale += amount
        canvas.scale.clamp(to: 1...64)
        _ = canvas.Analyse(source, state.palette)
    }
    
    var body: some View {
        ToolbarPanel(content: {
            RoundedLockButton(systemName: "magnifyingglass", size: 28, action: { canvas.isLocked.toggle(); }, isLocked: canvas.isLocked)
            
            if (!state.isNavState(.analysis) ) {
                
                VStack (alignment: .trailing, spacing: 3) {
                    
                    RoundedImage(systemName: "plus.magnifyingglass", size: 28, padding: 10.0)
                        .onTapGesture(perform: { updateScale(scaleFactor) })
                        .onLongPressGesture(minimumDuration: 0.5, perform: {
                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
                        })
                    
                    RoundedPanel(content: {
                        ZStack(alignment: .trailing) {
                            Text("\(String(format: "%0.f", (canvas.scale * 10)))")
                                .frame(maxHeight: 20)
                            Text("\(scaleFactor == 1.0 ? "\u{2581}\u{0020}" : "\u{0020}\u{2581}")").offset(x: 0, y: 1)
                            Text("\(scaleFactor == 1.0 ? "\u{2594}\u{0020}" : "\u{0020}\u{2594}")").offset(x: 0, y: -3.0)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(2)
                    }, orientation: .vertical, background: Styling.black.opacity(0.5))
                    
                    
                    RoundedImage(systemName: "minus.magnifyingglass", size: 28, padding: 10.0)
                        .onTapGesture(perform: { updateScale(-scaleFactor) })
                        .onLongPressGesture(minimumDuration: 0.5, perform: {
                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
                        })
                    
                    VStack(content: {
                        VerticalSlider<CGFloat>(value: $canvas.scale, in: 1.0...canvas.maxScale, step: 0.1, onEditingChanged: { changed in
                            if (sliderChange) { 
                                sliderChange = false
                            } else {
                                sliderChange = true
                            }
                        })
                    }).frame(maxHeight: 96)
                    
                }
                .frame(width: 28)
                .disabled(canvas.isLocked)
                .font(Styling.caption2Font.monospaced())
                
            }
        }, orientation: .vertical)                
    }
}



