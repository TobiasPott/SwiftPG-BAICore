import SwiftUI

struct BlueprintPanel: View {
    @EnvironmentObject var state: AppState
    
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;
    let isLandscape: Bool
    // ToDo: Move source drag & zoom to panel scope too!
    // Add "enabled" flag and consider grouping into packed info for both gestures
    @State var brickZoom: ZoomInfo = ZoomInfo(scale: 0.75, lastScale: 0.75);
    @State var brickDrag: DragInfo = DragInfo();
    
    var body: some View {
        GeometryReader { geometry in
            let geoSize = geometry.size;
            ZStack(alignment: Alignment.center) {
                GetViewForState()
                    .frameMax(geoSize, Alignment.center)
                    .mask(Styling.roundedRect)
                
                VStack(spacing: 6) {
                    if (state.isNavState([.setup])) { SourceToolbar(source: source); }
                    if (state.isNavState(.setup) && state.canvas != nil) { CanvasToolbar(canvas: state.canvas!, source: source); }
                }
                .frame(maxWidth: CGFloat.infinity, maxHeight: Styling.blueprintToolbarMaxHeight, alignment: Alignment.leading)
                .padding(.all, 6)
                
                VStack(spacing: 6) {
//                    BrickArtToolbar(drag: $brickDrag, zoom: $brickZoom)
                    if (state.isNavState(.analysis)) { BrickArtToolbar(drag: $brickDrag, zoom: $brickZoom); }
                }
                .frame(maxWidth: CGFloat.infinity, maxHeight: Styling.blueprintToolbarMaxHeight, alignment: Alignment.trailing)
                .padding(.all, 6)
            }
        }
        
    }
    
    func GetViewForState() -> some View {
        if (state.isNavState(.analysis)) {
            guard let canvas: CanvasInfo = state.canvas else { return RootView.anyEmpty }
            guard let analysis: AnalysisInfo = canvas.analysis else { return RootView.anyEmpty }
            return AnyView(BrickArtLayer(analysis: analysis, drag: $brickDrag, zoom: $brickZoom))
        } else {            
            return AnyView(SourceLayer(canvases: $canvases, source: source))
        } 
    }
    
}
