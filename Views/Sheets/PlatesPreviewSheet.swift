import SwiftUI
import simd;

struct PlatesPreviewSheet: View {
    @EnvironmentObject var state: GlobalState;
    
    @Binding var isOpen: Bool
    @ObservedObject var canvas: ArtCanvas;
    
    @Binding var selection: Int2
    var isWide: Bool = false 
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("Preview"), content: {
                ScrollView(content: {
                    VStack(alignment: HorizontalAlignment.center) {
                        GuideText(text: "Select the plate you want to preview and show the color list for.")
                        HStack(alignment: VerticalAlignment.top) { 
                            PlatesPreviewSheet.getTilePickerView(canvas: canvas, selection: $selection)
                                .frameRow(200, Alignment.leading)
                            Spacer()
                            PlatesPreviewSheet.getTileArt(canvas: canvas, tileCoords: selection, display: .outlined)
                                .overlay(content: { Grid(4, gridColor: Styling.white.opacity(0.5)) })      
                        }
                        PlatesPreviewSheet.getTileColorList(canvas: canvas, tileCoords: selection, palette: state.palette, isWide: isWide)
                    }
                })
            })
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameStretch(.topTrailing).padding()
        }.padding()
    }
    
    public static func getTilePickerView(canvas: ArtCanvas, selection: Binding<Int2>) -> some View {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty; }
        
        return AnyView(ZStack {
            analysis.image.swuiImage.interpolation(.none).rs(fit: true)
            VStack(spacing: 0) {
                ForEach(0..<analysis.tileHeight, id: \.self) { y in
                    HStack(spacing: 0) { 
                        ForEach(0..<analysis.tileWidth, id: \.self) { x in
                            let coords: Int2 = Int2(x: x, y: y);
                            let isSelected: Bool = selection.wrappedValue == coords;
                            Button(action: {
                                selection.wrappedValue = coords;
                            }, label: {
                                Rectangle()
                                    .foregroundColor(isSelected ? Styling.clear : Color.black.opacity(0.2))
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .border(isSelected ? Styling.white : Styling.black, width: 1.0)
                            })
                        }
                    }
                }
            }
        })
    }
    public static func getTileArt(canvas: ArtCanvas, tileCoords: Int2, display: BrickOutlineMode = .none) -> AnyView {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty; }
        
        return AnyView(
            VStack {
                let xOffset = tileCoords.x * 16
                let yOffset = tileCoords.y * 16
                let rowLength = analysis.tileWidth * 16
                BrickTileView(colorInfo: analysis.colorInfo, display: display, xOffset: xOffset, yOffset: yOffset, rowLength: rowLength)
                    .aspectRatio(1.0, contentMode: .fit)
            }
        )
    }
    
    public static func getTileColorList(canvas: ArtCanvas, tileCoords: Int2, palette: Palette, isWide: Bool) -> AnyView {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty; }
        
        let tIndex = tileCoords.y * canvas.tileWidth + tileCoords.x;
        return AnyView(
            ColorSwatchList(colorsWithCount: analysis.plates[tIndex].mappedColorCounts, palette: palette, isWide: isWide)
        )
    }
}


