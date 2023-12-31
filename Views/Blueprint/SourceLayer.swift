import SwiftUI

struct SourceLayer: View {
    @EnvironmentObject var state: AppState
    
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack() {
                    BlueprintGrid(lineWidth: 1.0).scaleEffect(12, anchor: .center)
                    if (source.isImageSet) {
                        source.image.swuiImage
                            .overlay(content: {
                                CanvasesLayer(canvases: $canvases, source: source, borderColor: Styling.white.opacity(0.25))
                            })
                    } else {
                        Styling.appIcon.swuiImage
                            .mask(RoundedRectangle(cornerSize: CGSize(width: 32, height: 32)))
                            .shadow(color: Styling.black.opacity(0.75), radius: 32)
                    }
                }       
                .scaleEffect(state.zoom.scale / 100, anchor: .center)
                .gesture(GetDragGesture(), enabled: source.isImageSet && !state.srcDragLocked)
                .gesture(GetZoomGesture(), enabled: source.isImageSet && !state.srcZoomLocked)
            }
            .offset(x: state.drag.fixedLocation.x, y: state.drag.fixedLocation.y)
            
            if (state.drag.active) {
                source.image.swuiImage
                    .scaleEffect(state.zoom.scale / 100, anchor: .center)
                    .offset(x: state.drag.location.x, y: state.drag.location.y)
                    .opacity(0.75)
            }
        }
    }
    
    func GetZoomGesture() -> _EndedGesture<_ChangedGesture<MagnificationGesture>> {
        return MagnificationGesture()
            .onChanged { magValue in
                state.zoom.update(magValue)
            }.onEnded { magValue in
                state.zoom.update(magValue, true)
                state.zoom.clamp(10, 199)
            }
    }
    
    func GetDragGesture() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture().onChanged { gesture in
            state.drag.update(gesture, false);
        }
        .onEnded { gesture in          
            state.drag.update(gesture, true);
        }
    }
    
}

struct BlueprintGridView: View {
    @EnvironmentObject var state: AppState
    
    var body: some View {
        BlueprintGrid(baseSpacing: 128, lineWidth: 1.0)
            .scaleEffect(8, anchor: .center)
    }
    
    
}
