import SwiftUI

struct CanvasesLayer: View {
    
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;    
    
    var borderColor: Color = Styling.white;
    
    var body: some View {
        ZStack(alignment: Alignment.topLeading) { 
            ForEach(canvases.items) {canvas in
                CanvasLayer(canvas: canvas, source: source, borderColor: borderColor)
            }
        }
        .frameStretch(Alignment.topLeading)
    }
}
