import SwiftUI

class GestureState : ObservableObject
{
    @Published var srcDrag: DragInfo = DragInfo();
    @Published var srcZoom: ZoomInfo = ZoomInfo(scale: Defaults.zoomScaleArt, lastScale: Defaults.zoomScaleArt);
    
    @Published var brickZoom: ZoomInfo = ZoomInfo(scale: 0.75, lastScale: 0.75);
    @Published var brickDrag: DragInfo = DragInfo();
    
    init() { 
    }
    
    func reset() {
        srcDrag = DragInfo()
        srcZoom = ZoomInfo(scale: Defaults.zoomScaleArt, lastScale: Defaults.zoomScaleArt)
        
        srcDrag.enabled = true;
        srcZoom.enabled = true;
        
        brickDrag = DragInfo();
        brickZoom = ZoomInfo(scale: 0.75, lastScale: 0.75);
    }
}
