import SwiftUI

struct AnalysisPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    let source: ArtSource;
    let canvas: ArtCanvas;
    var isWide: Bool = false
    
    @State var showColors: Bool = false;
    @State var showTiles: Bool = false;
    @State var selectedPlate: Int2 = Int2(x: 0, y: 0);
    
    var body: some View {
        
        RoundedPanel(content: {
            HStack {
                RoundedButton(sName: "arrowshape.left.circle.fill", size: 42.0, action: { state.setNavState(NavState.setup, true) })
                Text("Back")
                Spacer()
            }.padding(Edge.Set.horizontal).padding(Edge.Set.vertical, 8.0)
        }, orientation: PanelOrientation.vertical)
        
        
        GuideText(text: "Some details about your generated brick art. You can also export the instructions to PDF")
        RoundedPanel(content: {
            CanvasDetailHeader(canvas: canvas).padding(Edge.Set.horizontal, 12.0).padding(Edge.Set.vertical, 6.0);
            ExportMenu(source: source, canvas: canvas, palette: state.palette, width: 1538.0)
        }, orientation: PanelOrientation.horizonal)
        
        GuideText(text: "Your interactive instructions for every plate with the required bricks and colors")
        GroupBox(content: {
            HStack {
                Text("Plates")
                Spacer()
                Button("Preview", action: { showTiles = true })
            }
        })
        .sheet(isPresented: $showTiles, content: {
            PlatesPreviewSheet(isOpen: $showTiles, canvas: canvas, selection: $selectedPlate, isWide: isWide)
                .environmentObject(state)
        })
        
        
        GuideText(text: "Your full list of colors and number of bricks needed for your brick art.")
        GroupBox(content: {
            HStack {
                Text("All Colors")
                Spacer()
                Toggle(showColors ? "Hide" : "Show", isOn: $showColors).toggleStyle(ButtonToggleStyle())
            }
        })
        if (showColors) {
            RoundedPanel(content: {
                ColorSwatchList(colorsWithCount: canvas.analysis!.colorInfo.mappedColorCounts, palette: state.palette, isWide: isWide)
            }, orientation: PanelOrientation.vertical)
        }
    }
}


