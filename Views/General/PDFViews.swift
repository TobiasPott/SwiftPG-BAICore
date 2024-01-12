import SwiftUI
import Foundation

struct PDFColorList: View {
    let canvas: ArtCanvas;
    let palette: Palette
    
    var body: some View {
        GroupBox(content: {
            VStack{
                HStack {
                    Text("You need the following colors").font(Styling.headlineFont)
                    Spacer();
                }                
                ColorSwatchList(colorsWithCount: canvas.analysis!.colorInfo.mappedColorCounts, palette: palette, isWide: true) 
            }
            .foregroundColor(Styling.white)
        }).groupBoxStyle(BlueprintGroupBoxStyle())
    }
}
struct PDFFooter: View {
    var body: some View {
        GroupBox(content: {
            HStack {
                let date = Date()
                // Create Date Formatter
                let dateFormatter = DateFormatter(dateFormat: "YY/MM/dd") 
                Text("Created with Brick Art Instructor - \(dateFormatter.string(from: date))").font(Styling.captionFont).fontWeight(Font.Weight.bold)
                Spacer();
            }
            .foregroundColor(Styling.white)
        }).groupBoxStyle(BlueprintGroupBoxStyle())
    }
}
struct PDFHeader: View {
    let canvas: ArtCanvas;
    var body: some View {
        GroupBox(content: {
            HStack(alignment: VerticalAlignment.top) {
                canvas.analysis?.image.swuiImage
                    .interpolation(Image.Interpolation.none)
                    .rs(fit: true)
                    .frameMax(128.0)
                    .mask(Styling.roundedRect)
                VStack(alignment: HorizontalAlignment.leading) {
                    Text("Brick Art Instructor").font(Styling.titleFont.bold())
                    Text("Instruction, Parts and Color List").font(Styling.title2Font);
                    Text("for '\(canvas.name)'").font(Styling.title2Font);
                }
                Spacer()
            }
            .foregroundColor(Styling.white)
        }).groupBoxStyle(BlueprintGroupBoxStyle())
    }
}
struct PDFPlate: View {
    let source: ArtSource;
    let canvas: ArtCanvas;
    let palette: Palette   
    let coords: Int2
    
    var body: some View {
        GroupBox("Plate (\(coords.x + 1), \(coords.y + 1))", content: {
            HStack {
                VStack(alignment: HorizontalAlignment.leading) {
                    HStack(alignment: VerticalAlignment.top) { 
                        PlatePicker(canvas: canvas, selection: .constant(coords))
                            .frame(maxWidth: 150.0)
                        Spacer()
                        PlateArt(canvas: canvas, tileCoords: coords, display: BrickOutlineMode.outlined)
                            .overlay(content: {
                                Grid(4.0, gridColor: Styling.white.opacity(0.5))
                            })      
                    }
                    .frame(height: 240.0)
                    PlateColorList(canvas: canvas, tileCoords: coords, palette: palette, isWide: true)
                    RootView.spacerZeroLength
                }
                .frame(maxHeight: CGFloat.infinity)
                
                PlateArt(canvas: canvas, tileCoords: coords, display: BrickOutlineMode.outlined)
                    .overlay(content: {
                        Grid(4.0, gridColor: Styling.white.opacity(0.5))
                    })      
                    .mask(Styling.roundedRect)
            }
        }).groupBoxStyle(BlueprintGroupBoxStyle())
            .foregroundColor(Styling.white)
        //            .colorScheme(ColorScheme.dark)
        //            .preferredColorScheme(ColorScheme.dark)
    }
}
