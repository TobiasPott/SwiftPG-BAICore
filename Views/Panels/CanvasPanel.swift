import SwiftUI

struct CanvasPanel: View {
    
    static let sizes: [Int] = [1, 2, 3, 4]
    
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var source: SourceInfo;
    @ObservedObject var canvas: CanvasInfo;
    
    @State var editName: Bool = false;
    
    var body: some View {
        
        GroupBox(content: {
            GuideText(text: "You can give your canvas a custom name.")
            Highlight(content: {
                TextField(canvas.name, text: $canvas.name)                
            }, color: .secondary, useCaption: false, systemName: "e.circle")
            
        })        
        .onAppear(perform: {
            if(canvas.analysis == nil) {
                _ = canvas.Analyse(source, state.palette)
            }
        })
        
        GuideText(text: "A small preview of the estimated colors and resolution and the used setup of the canvas.")
        HStack(alignment: .center) {
            getControlsView()
                .frame(width: 120)
                .frame(maxHeight: .infinity)
            VStack {
                if(canvas.analysis != nil) {
                    let img = canvas.analysis?.image;
                    img?.swuiImage
                        .interpolation(.none).resizable()
                        .frame(maxHeight: 320)
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .mask(Styling.roundedRect)
                }
                else
                {
                    SNImage.questionmarkApp.rs(fit: true)
                        .frame(maxWidth: 32, maxHeight: 32, alignment: .center)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        HStack {
            RoundedButton(systemName: "trash.circle", action: { 
                _ = canvas.DiscardAnalysis();
            }, background: canvas.analysis == nil ? Styling.buttonColor : Styling.red).disabled(canvas.analysis == nil)
            RoundedButton(systemName: "arrow.counterclockwise.circle", action: { 
                _ = canvas.Analyse(source, state.palette);
            })
            Spacer()
            if(canvas.analysis != nil) {
                // gear.circle
                RoundedButton(systemName: "arrowshape.right.circle.fill", action: { 
                    state.setNavState(.analysis, true); 
                })
            }
        }
        
    }
    func getControlsView() -> some View {
        GroupBox(content: {
            VStack {
                CompactIconPicker(value: $canvas.tileWidth, systemName: "arrow.left.and.right", autoExpand: true, content: {
                    ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                }).disabled(true)
                CompactIconPicker(value: $canvas.tileHeight, systemName: "arrow.up.and.down", autoExpand: true, content: {
                    ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                }).disabled(true)
                
                LabelledText(label: "Dimensions", text: "\(Int(canvas.size.width)) x \(Int(canvas.size.height))", alignment: .top)
                    .padding(.top, 6)
                LabelledText(label: "Bricks", text: "\(Int(canvas.size.width * canvas.size.height))", alignment: .top)
                    .padding(.top, 6)
                Spacer()
            }
        })
        .font(Styling.caption2Font)
    }
}

struct CanvasHeader: View {
    @ObservedObject var source: SourceInfo;
    @ObservedObject var canvas: CanvasInfo;
    var isSelectable: Bool = true;
    var selected: Bool = false
    
    var body: some View {
        HStack{
            if(isSelectable) {
                if (selected) { SNImage.circleInsetFilled }
                else { SNImage.circle }
            }
            VStack(alignment: .leading) {
                Text("\(canvas.name)")
                Text("(\(canvas.tileWidth)x\(canvas.tileHeight))")
                    .font(Styling.caption2Font)
            }
            Spacer()
            RoundedStateButton(systemName: "lock.fill", size: 26, action: { canvas.isLocked.toggle(); }, state: canvas.isLocked, stateColor: Styling.red, background: Styling.gray, padding: 8.0)
        }
    }
}

struct CanvasDetailHeader: View {
    @ObservedObject var canvas: CanvasInfo;
    
    var body: some View {
        HStack{
            VStack(alignment: .leading) {
                Text("\(canvas.name)")
                Text("\(canvas.tileWidth) x \(canvas.tileHeight) tiles" +
                     "\n\(canvas.tileWidth*16) x \(canvas.tileHeight*16) bricks")
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
