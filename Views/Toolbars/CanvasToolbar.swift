import SwiftUI

struct CanvasToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var canvas: ArtCanvas;
    @ObservedObject var source: ArtSource;
    
    @State var sliderChange: Bool = false;
    @State var scaleFactor: CGFloat = 0.1
    
    var forLargeScreen: Bool = false
    
    func updateScale(_ amount: CGFloat) {
        canvas.scale += amount
        canvas.scale = canvas.scale.clamped(to: 1.0...64.0)
        _ = canvas.AnalyseAsync(source, state.palette)
    }
    
    var body: some View {
        let size = forLargeScreen ? Styling.buttonSize * 1.3 : Styling.buttonSize;
        let padding = forLargeScreen ? Styling.buttonPadding * 1.3 : Styling.buttonPadding;
        
        ToolbarPanel(content: {
            RoundedLockButton(sName: "magnifyingglass", size: size, action: { canvas.isLocked = canvas.isLocked.not; }, isLocked: canvas.isLocked, padding: padding)
            Divider().frame(width: size)
            if (!state.isNavState(NavState.analysis) ) {
                
                VStack (alignment: HorizontalAlignment.trailing, spacing: 3.0) {
                    
                    RoundedBadgeImage(sName: "plus.magnifyingglass", size: size, badgeSName: "10.square.fill", padding: padding)
                        .onTapGesture(perform: { updateScale(scaleFactor * 10) })
                    RoundedImage(sName: "plus.magnifyingglass", size: size, padding: padding)
                        .onTapGesture(perform: { updateScale(scaleFactor) })
                    RoundedPanel(content: {
                        ZStack(alignment: Alignment.trailing) {
                            Text("\(String(format: "%0.f", (canvas.scale * 10.0)))")
                            Text("\(scaleFactor == 1.0 ? "\u{2581}\u{0020}" : "\u{0020}\u{2581}")").offset(x: 0.0, y: 1.0)
                            Text("\(scaleFactor == 1.0 ? "\u{2594}\u{0020}" : "\u{0020}\u{2594}")").offset(x: 0.0, y: -3.0)
                        }                          
                        .frame(width: size)
                        .frame(minHeight: 20.0, maxHeight: size + 2.0)
                        .onLongPressGesture(minimumDuration: 0.5, perform: {
                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
                        })
                    }, orientation: PanelOrientation.vertical, background: Styling.accent.opacity(1.0))
                    
                    RoundedImage(sName: "minus.magnifyingglass", size: size, padding: padding)
                        .onTapGesture(perform: { updateScale(-scaleFactor) })
                    RoundedBadgeImage(sName: "minus.magnifyingglass", size: size, badgeSName: "10.square.fill", padding: padding)
                        .onTapGesture(perform: { updateScale(-scaleFactor * 10) })
                }
                .disabled(canvas.isLocked)
                .font(Styling.captionMono)
                
            }
        }, orientation: PanelOrientation.vertical)                
    }
}



