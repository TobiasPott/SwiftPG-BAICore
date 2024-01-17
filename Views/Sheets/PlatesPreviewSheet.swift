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
            GroupView(label: { Text("Preview") }, content: {
                ScrollView(content: {
                    VStack(alignment: HorizontalAlignment.center) {
                        GuideText(text: "Select the plate you want to preview and show the color list for.")
                        HStack(alignment: VerticalAlignment.top) {
                            
                            PlatePicker(canvas: canvas, selection: $selection)
                                .frameRow(200.0, Alignment.leading)
                            Spacer()
                            PlateArt(canvas: canvas, tileCoords: selection, display: BrickOutlineMode.outlined)
                                .overlay(content: { Grid(4.0, gridColor: Styling.white.opacity(0.5)) })      
                        }
                        PlateColorList(canvas: canvas, tileCoords: selection, palette: state.palette, isWide: isWide)
                    }
                })
            })
            HStack { Spacer()
                Button("Close", action: { isOpen = isOpen.not })    
            }.frameStretch(Alignment.topTrailing).padding()
        }.padding()
    }
    
}

struct PlatePicker: View {
    let canvas: ArtCanvas
    @Binding var selection: Int2
    
    var body: some View {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty; }
        
        return AnyView(ZStack {
            analysis.image.swuiImage.interpolation(Image.Interpolation.none).rs(fit: true)
            VStack(spacing: 0.0) {
                ForEach(0..<analysis.tileHeight, id: \.self) { y in
                    HStack(spacing: 0.0) { 
                        ForEach(0..<analysis.tileWidth, id: \.self) { x in
                            let coords: Int2 = Int2(x: x, y: y);
                            let isSelected: Bool = $selection.wrappedValue == coords;
                            
                            Button(action: {
                                $selection.wrappedValue = coords;
                            }, label: {
                                Rectangle()
                                    .foregroundColor(isSelected ? Styling.clear : Styling.black.opacity(0.2))
                                    .aspectRatio(1.0, contentMode: ContentMode.fit)
                                    .border(isSelected ? Styling.white : Styling.black, width: 1.0)
                            })
                        }
                    }
                }
            }
        })
    }
}

struct PlateArt: View {
    let canvas: ArtCanvas
    let tileCoords: Int2
    var display: BrickOutlineMode = BrickOutlineMode.none
    
    var body: some View {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty }
        
        return AnyView(VStack {
            let xOffset = tileCoords.x * 16
            let yOffset = tileCoords.y * 16
            let rowLength = analysis.tileWidth * 16
            BrickTileView(colorInfo: analysis.colorInfo, display: display, xOffset: xOffset, yOffset: yOffset, rowLength: rowLength)
                .overlay(content: {
                    Grid(4.0, gridColor: Styling.white.opacity(0.5))
                })      
                .aspectRatio(1.0, contentMode: ContentMode.fit)
            Spacer()
        })
        
    }
}

struct PlateColorList: View {
    let canvas: ArtCanvas
    let tileCoords: Int2
    let palette: Palette
    let isWide: Bool
    
    var body: some View {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty }
        
        let tIndex = tileCoords.y * canvas.tileWidth + tileCoords.x;
        return AnyView(ColorSwatchList(colorsWithCount: analysis.plates[tIndex].mappedColorCounts, palette: palette, isWide: isWide))
        
    }
}

