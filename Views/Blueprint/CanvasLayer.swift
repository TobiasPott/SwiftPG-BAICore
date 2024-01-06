import SwiftUI

struct CanvasLayer: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var canvas: ArtCanvas;
    let source: ArtSource;
    
    var borderColor: Color = Color.white;
    
    var body: some View {
        let canSize: CGSize = canvas.size.mul(canvas.scale) 
        ZStack() {
            fixedCanvas
                .gesture(GetDragGesture(), enabled: !canvas.isLocked)
            if (canvas.drag.active) { draggedCanvas }
        }
        .frame(width: canSize.width, height: canSize.height)
    }
    
    var fixedCanvas: some View {
        ZStack() {
            Styling.black.opacity(0.01)
            Grid(cols: CGFloat(canvas.tileWidth) * 16.0, rows: CGFloat(canvas.tileHeight) * 16.0, gridColor: Styling.black.opacity(0.75))
            Grid(cols: CGFloat(canvas.tileWidth), rows: CGFloat(canvas.tileHeight), gridColor: canvas.isLocked ? Styling.red : Styling.white, lineWidth: 3.0)
        }
        .border(canvas.isLocked ? Styling.red : borderColor, width: max(canvas.scale * 0.25, 6.0))
        .offset(x: canvas.drag.fixedLocation.x, y: canvas.drag.fixedLocation.y)
    }
    
    var draggedCanvas: some View {
        ZStack() {
            Styling.black.opacity(0.01)
            Grid(cols: CGFloat(canvas.tileWidth) * 16.0, rows: CGFloat(canvas.tileHeight) * 16.0, gridColor: Styling.gray.opacity(0.75))
            Grid(cols: CGFloat(canvas.tileWidth), rows: CGFloat(canvas.tileHeight), gridColor: canvas.isLocked ? Styling.red : Styling.white, lineWidth: 3.0)
        }
        .border(canvas.isLocked ? Styling.red : borderColor, width: max(canvas.scale * 0.25, 6.0))
        .offset(x: canvas.drag.location.x, y: canvas.drag.location.y)
    }
    
    func GetDragGesture() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture().onChanged { gesture in
            canvas.drag.update(gesture, false);
            // clamp to source image size
            let clampSize: CGSize = source.image.size.sub(canvas.size.mul(canvas.scale)); 
            canvas.drag.clamp(CGPoint.zero, clampSize.cgPoint());
        }
        .onEnded { gesture in          
            canvas.drag.update(gesture, true);
            // clamp to source image size
            let clampSize: CGSize = source.image.size.sub(canvas.size.mul(canvas.scale)); 
            canvas.drag.clamp(CGPoint.zero, clampSize.cgPoint());        
            _ = canvas.Analyse(source, state.palette)
        }
    }
    
}



