import SwiftUI
import simd;
import SwiftPG_Palettes

struct AnalysisPDFView: View {
    
    let source: ArtSource;
    let canvas: ArtCanvas;
    let palette: Palette
    
    let outWidth: CGFloat;
    
    var body: some View {
        if(canvas.analysis != nil) {
            let analysis: AnalysisInfo = canvas.analysis!;    
            VStack {
                GroupBox(content: {
                    HStack {
                        Text("LEGO Color List for '\(canvas.name)'").font(Styling.titleFont);
                        Spacer();
                    }                
                })
                .groupBoxStyle(BlueprintGroupBoxStyle())
                .padding(.top)
                
                ForEach(0..<analysis.tileHeight, id: \.self) { y in
                    ForEach(0..<analysis.tileWidth, id: \.self) { x in
                        PlatePDFPage(source: source, canvas: canvas, palette: palette, coords: Int2(x: x, y: y))
                            .padding(.vertical)
                    }
                }
                GroupBox(content: {
                    VStack{ AnalysisPanel.getColorListView(canvas: canvas, palette: palette, isWide: true) }
                }).groupBoxStyle(BlueprintGroupBoxStyle())
                
                GroupBox(content: {
                    HStack {
                        Text("Created with Brick Art Instructor").font(Styling.captionFont).fontWeight(.bold)
                        Spacer();
                    }
                })
                .groupBoxStyle(BlueprintGroupBoxStyle())
                .padding(.bottom)
            }
            .frame(alignment: Alignment.top)
            .frame(width: outWidth)
            .padding()
            .foregroundColor(Color.white)
        } else {
            EmptyView();
        }
    }
}

struct PlatePDFPage: View {
    
    let source: ArtSource;
    let canvas: ArtCanvas;
    let palette: Palette
    
    @State var coords: Int2
    
    var body: some View {
        GroupBox("Plate (\(coords.x + 1), \(coords.y + 1))", content: {
            HStack {
                VStack(alignment: HorizontalAlignment.leading) {
                    HStack(alignment: VerticalAlignment.top) { 
                        PlatesPreviewSheet.getTilePickerView(canvas: canvas, selection: .constant(coords))
                            .frame(maxWidth: 150)
                        Spacer()
                        PlatesPreviewSheet.getTileArt(canvas: canvas, tileCoords: coords, display: .outlined)
                            .overlay(content: {
                                Grid(4, gridColor: Styling.white.opacity(0.5))
                            })      
                    }
                    .frame(height: 240)
                    PlatesPreviewSheet.getTileColorList(canvas: canvas, tileCoords: coords, palette: palette, isWide: true)
                    Spacer(minLength: 0)
                }
                .frame(maxHeight: CGFloat.infinity)
                PlatesPreviewSheet.getTileArt(canvas: canvas, tileCoords: coords, display: .outlined)
                    .overlay(content: {
                        Grid(4, gridColor: Styling.white.opacity(0.5))
                    })      
                    .mask(Styling.roundedRect)
            }
        }).groupBoxStyle(BlueprintGroupBoxStyle())
            .colorScheme(.dark)
            .preferredColorScheme(.dark)
    }
}
