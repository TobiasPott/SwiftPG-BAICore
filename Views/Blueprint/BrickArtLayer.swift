import SwiftUI

struct BrickArtLayer: View {
    @EnvironmentObject var state: GlobalState
    
    let analysis: ArtAnalysis;
    
    @Binding var drag: DragInfo
    @Binding var zoom: ZoomInfo
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                ZStack{
                    BlueprintGrid(baseSpacing: 32).scaleEffect(16.0)
                    BrickCanvasView(analysis: analysis, display: state.brickOutline)
                        .overlay(content: {
                            Grid(cols: floor(analysis.size.width / 16), rows: floor(analysis.size.height / 16), gridColor: Styling.white)
                        })
                }
                .scaleEffect(zoom.scale, anchor: .center)
                .frameMax(geometry.size)
                
            }
            .gesture(GetDragGesture(), enabled: true)
            .gesture(GetZoomGesture(), enabled: true)
            .offset(x: drag.fixedLocation.x, y: drag.fixedLocation.y)  
            
            if (drag.active) {
                BrickCanvasView(analysis: analysis, display: .none)
                    .scaleEffect(zoom.scale, anchor: .center)
                    .frameMax(geometry.size)
                    .offset(drag.location.cgSize())
            }
        })
        .frame(maxWidth: 800)
    }
    func GetZoomGesture() -> _EndedGesture<_ChangedGesture<MagnificationGesture>> {
        return MagnificationGesture()
            .onChanged { magValue in
                zoom.update(magValue)
            }.onEnded { magValue in
                zoom.update(magValue, true)
                zoom.clamp(0.2, 40.0)
            }
    }
    func GetDragGesture() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture().onChanged { gesture in
            drag.update(gesture, false);
        }
        .onEnded { gesture in          
            drag.update(gesture, true);
        }
    }
}

struct BrickCanvasView: View {
    
    let analysis: ArtAnalysis
    var display: BrickOutlineMode = .none;
    
    var body: some View {
        let spacing: CGFloat = 0.0;
        
        ZStack {
            VStack(spacing: spacing) {
                ForEach(0..<Int(analysis.tileHeight), id: \.self) { y in 
                    HStack(spacing: spacing) {
                        ForEach(0..<Int(analysis.tileWidth), id: \.self) { x in
                            let index = y * analysis.tileWidth + x;
                            BrickTileView(colorInfo: analysis.tileInfos[index], display: display)                            
                        }
                    }                    
                }
            }
        }
    }
    
    
}
struct BrickTileView: View {
    static let initalOutlineResourceName: String = "Outlines_16x16_Square";
    static let outline: PImage = PImage(imageLiteralResourceName: BrickTileView.initalOutlineResourceName)
    
    
    let colorInfo: ArtColors
    var display: BrickOutlineMode = .none;
    
    var xOffset: Int = 0;
    var yOffset: Int = 0;
    var rowLength: Int = 16;
    
    var body: some View {
        let spacing: CGFloat = 0.0;
        
        ZStack {
            VStack(spacing: spacing) {
                ForEach(0..<16, id: \.self) { y in
                    let baseIndex = (yOffset + y) * rowLength + xOffset; 
                    HStack(spacing: spacing) {
                        ForEach(0..<16, id: \.self) { x in
                            let index = baseIndex + Int(x);
                            if (index < colorInfo.colors.count) {
                                colorInfo.colors[index].swuiColor
                                    .aspectRatio(1.0, contentMode: .fill)
                                
                            }
                            
                        }
                    }                    
                }
            }
            if (display == .outlined) {
                BrickPlateOutlines()
            }
        }
    }
    
}

struct BrickArtOutlines: View {
    var repeatX: Int = 1
    var repeatY: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<repeatY, id: \.self) { y in 
                HStack(spacing: 0) {
                    ForEach(0..<repeatX, id: \.self) { x in
                        BrickPlateOutlines()
                    }
                }                    
            }
        }
    }
}
struct BrickPlateOutlines: View {
    
    var body: some View {
        BrickTileView.outline.swuiImage.resizable()
            .colorMultiply(.yellow.opacity(0.75)).blendMode(.difference)        
    }
    
}
