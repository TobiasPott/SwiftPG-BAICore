import SwiftUI

struct CanvasToolbar: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var canvas: ArtCanvas;
    @ObservedObject var source: ArtSource;
    
    @State var sliderChange: Bool = false;
    @State var scaleFactor: CGFloat = 0.1
    
    func updateScale(_ amount: CGFloat) {
        canvas.scale += amount
        canvas.scale = canvas.scale.clamped(to: 1.0...64.0)
        _ = canvas.AnalyseAsync(source, state.palette)
    }
    
    var body: some View {
        ToolbarPanel(content: {
            RoundedLockButton(sName: "magnifyingglass", size: 28.0, action: { canvas.isLocked.toggle(); }, isLocked: canvas.isLocked)
            Divider().frame(width: 28.0)
            if (!state.isNavState(NavState.analysis) ) {
                
                VStack (alignment: HorizontalAlignment.trailing, spacing: 3.0) {
                    
                    RoundedBadgeImage(sName: "plus.magnifyingglass", size: 28.0, badgeSName: "10.square.fill")
                        .onTapGesture(perform: { updateScale(scaleFactor * 10) })
                    RoundedImage(sName: "plus.magnifyingglass", size: 28.0)
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
                    
                    RoundedImage(sName: "minus.magnifyingglass", size: 28.0)
                        .onTapGesture(perform: { updateScale(-scaleFactor) })
                        .onLongPressGesture(minimumDuration: 0.5, perform: {
                            scaleFactor = scaleFactor == 1.0 ? 0.1 : 1.0
                        })
                    RoundedBadgeImage(sName: "minus.magnifyingglass", size: 28.0, badgeSName: "10.square.fill")
                        .onTapGesture(perform: { updateScale(-scaleFactor * 10) })
                }
                .frame(width: 28.0)
                .disabled(canvas.isLocked)
                .font(Styling.caption2Font.monospaced())
                
            }
        }, orientation: PanelOrientation.vertical)                
    }
}



