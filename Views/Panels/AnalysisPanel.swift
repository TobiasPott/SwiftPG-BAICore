import SwiftUI

struct AnalysisPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    let source: ArtSource;
    let canvas: ArtCanvas;
    var isWide: Bool = false
    
    @State var showColors: Bool = false;
    @State var showTiles: Bool = false;
    @State var showPreview: Bool = false;
    @State var selectedPlate: Int2 = Int2(x: 0, y: 0);
    
    var body: some View {
        
        RoundedPanel(content: {
            HStack {
                RoundedButton(sName: "arrowshape.turn.up.left.circle.fill", trailingLabel: "Back", action: { state.setNavState(NavState.setup, true) })
                Spacer()
            }
            .font(Styling.headlineFont)
            .padding(Edge.Set.horizontal)
            .padding(Edge.Set.vertical, 8.0)
        }, orientation: PanelOrientation.vertical)
        
        
        GuideText(text: "Some details about your generated brick art. You can also export the instructions to PDF")
        RoundedPanel(content: {
            CanvasDetailHeader(canvas: canvas).padding(Edge.Set.horizontal, 12.0).padding(Edge.Set.vertical, 6.0);
//            ExportMenu(source: source, canvas: canvas, palette: state.palette, width: 1538.0)
        }, orientation: PanelOrientation.horizonal)
        
        GroupView(label: {}, content: {
            HStack {
                Text("PDF")
                Spacer()
                Button("Prepare", action: { showPreview = true })
            }
        })
        .sheet(isPresented: $showPreview, content: {
            PDFPreview(isOpen: $showPreview, canvas: canvas, source: source, width: 1280)
                .environmentObject(state)
        })
        GuideText(text: "Your interactive instructions for every plate with the required bricks and colors")
        GroupView(label: {}, content: {
            HStack {
                Text("Instructions")
                Spacer()
                Button("View", action: { showTiles = true })
            }
        })
        .sheet(isPresented: $showTiles, content: {
            PlatesPreviewSheet(isOpen: $showTiles, canvas: canvas, selection: $selectedPlate, isWide: isWide)
                .environmentObject(state)
        })
        
        
        GuideText(text: "Your full list of colors and number of bricks needed for your brick art.")
        GroupView(label: {}, content: {
            HStack {
                Text("All Colors")
                Spacer()
                Button("View", action: { showColors = true })
            }
        })
        .sheet(isPresented: $showColors, content: {
            ColorListSheet(isOpen: $showColors, canvas: canvas, isWide: isWide)
                .environmentObject(state)
        })
        
    }
}


