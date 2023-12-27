import SwiftUI

struct CanvasPanel: View {
    
    static let sizes: [Int] = [1, 2, 3, 4, 5]
    
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var source: SourceInfo;
    @ObservedObject var canvas: CanvasInfo;
    
    @State var editName: Bool = false;
    
    var body: some View {
        
        GroupBox(label: Text("Setup").font(Styling.title2Font), content: {
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
        Divider()
        HStack {
            RoundedButton(systemName: "trash.circle", action: { 
                _ = canvas.DiscardAnalysis();
            }, background: canvas.analysis == nil ? Styling.buttonColor : .red).disabled(canvas.analysis == nil)
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
        Divider()
        
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
        .font(.system(size: 12))
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
                Text("(\(canvas.tileWidth)x\(canvas.tileHeight))").font(.system(size: 10))
            }
            Spacer()
            RoundedStateButton(systemName: "lock.fill", size: 26, action: { canvas.isLocked.toggle(); }, state: canvas.isLocked, stateColor: .red, background: .gray, padding: 8.0)
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
                .font(.system(size: 10))
                getAnalysisView()
            }
            Spacer()
        }
    }
    
    func getAnalysisView() -> some View {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty }
        return AnyView(Text("\(analysis.colorInfo.uniqueColors) unique colors")
            .font(.system(size: 10)))
    }
}
