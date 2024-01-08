import SwiftUI

struct CanvasToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var canvas: ArtCanvas;
    @ObservedObject var source: ArtSource;
    
    @State var sliderChange: Bool = false;
    @State var scaleFactor: CGFloat = 1.0
    
    func updateScale(_ amount: CGFloat) {
        canvas.scale += amount
        canvas.scale = canvas.scale.clamped(to: 1.0...64.0)
        _ = canvas.AnalyseAsync(source, state.palette)
    }
    
    var body: some View {
        ToolbarPanel(content: {
            RoundedLockButton(sName: "magnifyingglass", size: 28.0, action: { canvas.isLocked.toggle(); }, isLocked: canvas.isLocked)
            
            if (!state.isNavState(NavState.analysis) ) {
                
                VStack (alignment: HorizontalAlignment.trailing, spacing: 3.0) {
                    
                    RoundedImage(sName: "plus.magnifyingglass", size: 28.0, padding: 10.0)
                        .onTapGesture(perform: { updateScale(scaleFactor) })
                        .onLongPressGesture(minimumDuration: 0.5, perform: {
                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
                        })
                    
                    RoundedPanel(content: {
                        ZStack(alignment: Alignment.trailing) {
                            Text("\(String(format: "%0.f", (canvas.scale * 10.0)))")
                                .frame(maxHeight: 20.0)
                            Text("\(scaleFactor == 1.0 ? "\u{2581}\u{0020}" : "\u{0020}\u{2581}")").offset(x: 0.0, y: 1.0)
                            Text("\(scaleFactor == 1.0 ? "\u{2594}\u{0020}" : "\u{0020}\u{2594}")").offset(x: 0.0, y: -3.0)
                        }
                        .frame(maxWidth: CGFloat.infinity)
                        .padding(2.0)
                    }, orientation: PanelOrientation.vertical, background: Styling.black.opacity(0.5))
                    
                    
                    RoundedImage(sName: "minus.magnifyingglass", size: 28.0, padding: 10.0)
                        .onTapGesture(perform: { updateScale(-scaleFactor) })
                        .onLongPressGesture(minimumDuration: 0.5, perform: {
                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
                        })
                    
                    VStack(content: {
                        VerticalSlider<CGFloat>(value: $canvas.scale, in: 1.0...canvas.maxScale, step: 0.1, onEditingChanged: { changed in
                            if (sliderChange) { 
                                sliderChange = false
                                updateScale(0.0)
                            } else {
                                sliderChange = true
                            }
                        })
                    }).frame(maxHeight: 96.0)
                    
                }
                .frame(width: 28.0)
                .disabled(canvas.isLocked)
                .font(Styling.caption2Font.monospaced())
                
            }
        }, orientation: PanelOrientation.vertical)                
    }
}



