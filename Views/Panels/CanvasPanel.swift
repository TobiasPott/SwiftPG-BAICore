import SwiftUI

struct CanvasPanel: View {
    
    static let sizes: [Int] = [1, 2, 3, 4]
    
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var source: ArtSource;
    @ObservedObject var canvas: ArtCanvas;
    
    @State var editName: Bool = false;
    
    var body: some View {
        
        RoundedPanel(content: {
            HStack {
                RoundedButton(sName: "arrowshape.left.circle.fill", size: 42.0, action: { state.setNavState(NavState.load, true) })
                Text("Back")
                Spacer()
                Text("Analyze")
                RoundedButton(sName: "arrowshape.right.circle.fill", size: 42.0, action: { 
                    _ = canvas.AnalyseAsync(source, state.palette);
                    state.setNavState(NavState.analysis, true)
                })
            }.padding(Edge.Set.horizontal).padding(Edge.Set.vertical, 8.0)
        }, orientation: PanelOrientation.vertical)
        
        GroupBox(content: {
            GuideText(text: "You can give your canvas a custom name.")
            Highlight(content: {
                TextField(canvas.name, text: $canvas.name)                
            }, color: .secondary, useCaption: false, systemName: "e.circle")
        })        
        .onAppear(perform: {
            if(canvas.analysis == nil) {
                _ = canvas.AnalyseAsync(source, state.palette)
            }
        })
        
        GuideText(text: "A small preview of the estimated colors and resolution and the used setup of the canvas.")
        HStack(alignment: VerticalAlignment.center) {
            detailPanel
//                .frame(maxHeight: CGFloat.infinity)
            VStack {
                if(canvas.analysis != nil) {
                    let img = canvas.analysis?.image;
                    img?.swuiImage
                        .interpolation(Image.Interpolation.none).resizable()
                        .frame(maxHeight: 320.0)
                        .scaledToFit()
                        .frame(maxWidth: CGFloat.infinity)
                        .mask(Styling.roundedRect)
                }
                else
                {
                    SNImage.questionmarkApp.rs(fit: true)
                        .frameMax(32.0, Alignment.center)
                        .frame(maxWidth: CGFloat.infinity)
                }
            }
        }
        
    }
    var detailPanel: some View {
        GroupBox(content: {
            VStack {
                LabelledText(label: "Width", text: "\(Int(canvas.tileWidth))", alignment: VerticalAlignment.top)
                    .padding(Edge.Set.top, 6.0)
                LabelledText(label: "Height", text: "\(Int(canvas.tileHeight))", alignment: VerticalAlignment.top)
                    .padding(Edge.Set.top, 6.0)
                
                
                LabelledText(label: "Dimensions", text: "\(Int(canvas.size.width)) x \(Int(canvas.size.height))", alignment: VerticalAlignment.top)
                    .padding(Edge.Set.top, 6.0)
                LabelledText(label: "Bricks", text: "\(Int(canvas.size.width * canvas.size.height))", alignment: VerticalAlignment.top)
                    .padding(Edge.Set.top, 6.0)
                Divider()
                
                LabelledText(label: "Colors", text: "\(Int(canvas.analysis?.colorInfo.uniqueColors ?? 0))", alignment: VerticalAlignment.top)
                    .padding(Edge.Set.top, 6.0)
//                
//                let colors: Dictionary<MultiColor, Int> = canvas.analysis?.colorInfo.mappedColorCounts ?? [:]
//                
//                LazyVGrid(columns: [GridItem(GridItem.Size.adaptive(minimum: size, maximum: size), spacing: 2.0)]) {
//                    
//                    ForEach(colors) { kv in
//                        
//                        palette.artColors[i].swuiColor.frameSquare(size)
//                            .mask(Styling.roundedRectHalf)
//                    }
//                }
//                
                Spacer()
            }
        })
        .font(Styling.caption2Font)
    }
}

struct CanvasHeader: View {
    @ObservedObject var source: ArtSource;
    @ObservedObject var canvas: ArtCanvas;
    var isSelectable: Bool = true;
    var selected: Bool = false
    
    var body: some View {
        HStack{
            if(isSelectable) {
                if (selected) { SNImage.circleInsetFilled }
                else { SNImage.circle }
            }
            VStack(alignment: HorizontalAlignment.leading) {
                Text("\(canvas.name)")
                Text("(\(canvas.tileWidth)x\(canvas.tileHeight))")
                    .font(Styling.caption2Font)
            }
            Spacer()
            RoundedStateButton(sName: "lock.fill", size: 26.0, action: { canvas.isLocked = canvas.isLocked.not; }, state: canvas.isLocked, stateColor: Styling.red, background: Styling.gray, padding: 8.0)
        }
    }
}

struct CanvasDetailHeader: View {
    @ObservedObject var canvas: ArtCanvas;
    
    var body: some View {
        HStack{
            VStack(alignment: HorizontalAlignment.leading) {
                Text("\(canvas.name)")
                Text("\(canvas.tileWidth) x \(canvas.tileHeight) tiles" +
                     "\n\(canvas.tileWidth * 16) x \(canvas.tileHeight * 16) bricks")
                .font(Styling.caption2Font)
                getAnalysisView()
            }
            Spacer()
        }
    }
    
    func getAnalysisView() -> some View {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty }
        return AnyView(Text("\(analysis.colorInfo.uniqueColors) unique colors")
            .font(Styling.caption2Font))
    }
}
