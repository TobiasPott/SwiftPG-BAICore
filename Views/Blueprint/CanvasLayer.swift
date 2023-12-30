import SwiftUI

struct CanvasLayer: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var canvas: CanvasInfo;
    @ObservedObject var source: SourceInfo;
    
    var borderColor: Color = Color.white;
    
    var body: some View {
        let canSize: CGSize = canvas.size.mul(canvas.scale) 
        ZStack() {
            getCanvasView(location: canvas.drag.fixedLocation, gridColor: Color.black, tileColor: Color.white)
                .gesture(GetDragGesture(), enabled: !canvas.isLocked)
                .frame(width: canSize.width, height: canSize.height)
            if (canvas.drag.active) {
                getCanvasView(location: canvas.drag.location, gridColor: Color.green, tileColor: Color.white)
                    .frame(width: canSize.width, height: canSize.height)
            }
        }
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
    
    
    func getCanvasView(location: CGPoint, gridColor: Color, tileColor: Color) -> some View {
        ZStack() {
            Color.black.opacity(0.01)
            Grid(cols: CGFloat(canvas.tileWidth) * 16, rows: CGFloat(canvas.tileHeight) * 16, gridColor: gridColor)
            Grid(cols: CGFloat(canvas.tileWidth), rows: CGFloat(canvas.tileHeight), gridColor: tileColor, lineWidth: 3.0)
        }
        .overlay(content: {
            if(canvas.isLocked) {
                SNImage.lockFill
                    .rs().padding()
                    .foregroundColor(Color.red).frame(maxWidth: 16 * canvas.scale, maxHeight: 16 * canvas.scale)
            }
        })
        .border(borderColor, width: max(canvas.scale * 0.25, 6.0))
        .offset(x: location.x, y: location.y)
    }
    
}



