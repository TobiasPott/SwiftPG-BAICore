import SwiftUI

struct BlueprintPanel: View {
    @EnvironmentObject var state: GlobalState
    @EnvironmentObject var load: LoadState;
    
    @Binding var canvases: Canvases;
    @ObservedObject var source: ArtSource;
    
    @State var brickZoom: ZoomInfo = ZoomInfo(scale: 0.75, lastScale: 0.75);
    @State var brickDrag: DragInfo = DragInfo();
    
    var body: some View {
        GeometryReader { geometry in
            let geoSize = geometry.size;
            ZStack(alignment: Alignment.center) {
                navStateView
                    .frameMax(geoSize, Alignment.center)
                    .mask(Styling.roundedRect)
                
                VStack(spacing: 6) {
                    if (state.isNavState(NavState.setup)) { SourceToolbar(source: source); }
                    if (state.isNavState(NavState.setup) && state.canvas != nil) { CanvasToolbar(canvas: state.canvas!, source: source); }
                }
                .frame(maxWidth: CGFloat.infinity, maxHeight: Styling.blueprintToolbarMaxHeight, alignment: Alignment.leading)
                .padding(Edge.Set.all, 6)
                
                VStack(spacing: 6) {
                    if (state.isNavState(NavState.analysis)) { BrickArtToolbar(brickOutline: $state.brickOutline, drag: $brickDrag, zoom: $brickZoom); }
                }
                .frame(maxWidth: CGFloat.infinity, maxHeight: Styling.blueprintToolbarMaxHeight, alignment: Alignment.trailing)
                .padding(Edge.Set.all, 6)
            }
        }
        
    }
    
    var navStateView: some View {
        if (state.isNavState(NavState.analysis)) {
            guard let canvas: ArtCanvas = state.canvas else { return RootView.anyEmpty }
            guard let analysis: ArtAnalysis = canvas.analysis else { return RootView.anyEmpty }
            return AnyView(
                BrickArtLayer(analysis: analysis, drag: $brickDrag, zoom: $brickZoom)
            )
        } else {            
            return AnyView(
                SourceLayer(load: load, source: source, canvases: $canvases, overlayContent: {
                    CanvasesLayer(canvases: $canvases, source: source, borderColor: Styling.white.opacity(0.25))
                })
            )
        } 
    }
    
}
