import SwiftUI

struct CanvasesLayer: View {
    
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;    
    
    var borderColor: Color = .white;
    
    var body: some View {
        ZStack(alignment: .topLeading) { 
            ForEach(canvases.items) {canvas in
                CanvasLayer(canvas: canvas, source: source, borderColor: borderColor)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}
