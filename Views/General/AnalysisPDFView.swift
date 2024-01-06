import SwiftUI
import simd;

struct AnalysisPDFView: View {
    
    let source: ArtSource;
    let canvas: ArtCanvas;
    let palette: Palette
    
    let outWidth: CGFloat;
    
    var body: some View {
        if(canvas.analysis != nil) {
            let analysis: ArtAnalysis = canvas.analysis!;    
            VStack {
                GroupBox(content: {
                    HStack {
                        Text("LEGO Color List for '\(canvas.name)'").font(Styling.titleFont);
                        Spacer();
                    }                
                })
                .groupBoxStyle(BlueprintGroupBoxStyle())
                .padding(Edge.Set.top)
                
                ForEach(0..<analysis.tileHeight, id: \.self) { y in
                    ForEach(0..<analysis.tileWidth, id: \.self) { x in
                        PlatePDFPage(source: source, canvas: canvas, palette: palette, coords: Int2(x: x, y: y))
                            .padding(Edge.Set.vertical)
                    }
                }
                
                GroupBox(content: {
                    VStack{
                        HStack {
                            Text("You need the following colors").font(Styling.headlineFont)
                            Spacer();
                        }                
                        ColorSwatchList(colorsWithCount: canvas.analysis!.colorInfo.mappedColorCounts, palette: palette, isWide: true) 
                    }
                }).groupBoxStyle(BlueprintGroupBoxStyle())
                
                GroupBox(content: {
                    HStack {
                        Text("Created with Brick Art Instructor").font(Styling.captionFont).fontWeight(Font.Weight.bold)
                        Spacer();
                    }
                })
                .groupBoxStyle(BlueprintGroupBoxStyle())
                .padding(Edge.Set.bottom)
            }
            .frame(alignment: Alignment.top)
            .frame(width: outWidth)
            .padding()
            .foregroundColor(Styling.white)
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
                            .frame(maxWidth: 150.0)
                        Spacer()
                        PlatesPreviewSheet.getTileArt(canvas: canvas, tileCoords: coords, display: BrickOutlineMode.outlined)
                            .overlay(content: {
                                Grid(4.0, gridColor: Styling.white.opacity(0.5))
                            })      
                    }
                    .frame(height: 240.0)
                    PlatesPreviewSheet.getTileColorList(canvas: canvas, tileCoords: coords, palette: palette, isWide: true)
                    RootView.spacerZeroLength
                }
                .frame(maxHeight: CGFloat.infinity)
                PlatesPreviewSheet.getTileArt(canvas: canvas, tileCoords: coords, display: BrickOutlineMode.outlined)
                    .overlay(content: {
                        Grid(4.0, gridColor: Styling.white.opacity(0.5))
                    })      
                    .mask(Styling.roundedRect)
            }
        }).groupBoxStyle(BlueprintGroupBoxStyle())
            .colorScheme(ColorScheme.dark)
            .preferredColorScheme(ColorScheme.dark)
    }
}
