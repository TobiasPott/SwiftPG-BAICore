import SwiftUI
import simd;
import SwiftPG_Palettes

struct PlatesPreviewSheet: View {
    @EnvironmentObject var state: AppState;
    
    @Binding var isOpen: Bool
    @ObservedObject var canvas: CanvasInfo;
    
    @Binding var selection: Int2
    
    var body: some View {
        ZStack {
            GroupBox(label: Text("Preview"), content: {
                ScrollView(content: {
                    VStack(alignment: .center) {
                        HStack(alignment: .top) { 
                            PlatesPreviewSheet.getTilePickerView(canvas: canvas, selection: $selection)
                                .frame(maxWidth: 200, alignment: .leading)
                            Spacer()
                            PlatesPreviewSheet.getTileArt(canvas: canvas, tileCoords: selection, display: .detailed)
                                .overlay(content: { Grid(4, gridColor: .white.opacity(0.5)) })      
                        }
                        PlatesPreviewSheet.getTileColorList(canvas: canvas, tileCoords: selection, palette: state.palette)
                    }
                })
            })
            HStack { Spacer()
                Button("Close", action: { isOpen.toggle() })    
            }.frameInfinity(.topTrailing).padding()
        }.padding()
    }
    
    public static func getTilePickerView(canvas: CanvasInfo, selection: Binding<Int2>) -> some View {
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
                                    .foregroundColor(isSelected ? .clear : .black.opacity(0.2))
                                    .aspectRatio(1.0, contentMode: .fit)
                                    .border(isSelected ? .white : .black, width: 1.0)
                            })
                        }
                    }
                }
            }
        })
    }
    public static func getTileArt(canvas: CanvasInfo, tileCoords: Int2, display: BrickArtDisplay = .flat) -> AnyView {
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
    
    public static func getTileColorList(canvas: CanvasInfo, tileCoords: Int2, palette: Palette) -> AnyView {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty; }
        
        let tIndex = tileCoords.y * canvas.tileWidth + tileCoords.x;
        return AnyView(
            ColorSwatchList(mappedColorsWithCount: analysis.tileInfos[tIndex].mappedColorCounts, palette: palette)
        )
    }
}


