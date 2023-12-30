import SwiftUI

struct BlueprintPanel: View {
    @EnvironmentObject var state: AppState
    
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;
    let isLandscape: Bool
    
    var body: some View {
        GeometryReader { geometry in
            let geoSize = geometry.size;
            ZStack(alignment: .center) {
                GetViewForState()
                    .frame(maxWidth: geoSize.width, maxHeight: geoSize.height, alignment: .center) 
                    .mask(Styling.roundedRect)
                
                VStack(spacing: 6) {
                    if (state.isNavState([.setup])) { SourceToolbar(source: source); }
                    if (state.isNavState(.setup) && state.canvas != nil) { CanvasToolbar(canvas: state.canvas!, source: source); }
                }
                .frame(maxWidth: .infinity, maxHeight: Styling.blueprintToolbarMaxHeight, alignment: .leading)
                .padding(.all, 6)
            }
        }
        
    }
    
    func GetViewForState() -> some View {
        if (state.isNavState(.analysis)) {
            guard let canvas: CanvasInfo = state.canvas else { return RootView.anyEmpty }
            guard let analysis: AnalysisInfo = canvas.analysis else { return RootView.anyEmpty }
            return AnyView(BrickArtLayer(analysis: analysis))
        } else { //if (state.isNavState(.setup)) {            
            return AnyView(SourceLayer(canvases: $canvases, source: source))
        } 
    }
    
}
