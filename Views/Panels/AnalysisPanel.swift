import SwiftUI
//import simd;
import SwiftPG_Palettes

struct AnalysisPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    let source: ArtSource;
    let canvas: ArtCanvas;
    
    @State var showColors: Bool = false;
    @State var showTiles: Bool = false;
    @State var selectedPlate: Int2 = Int2(x: 0, y: 0);
    
    var body: some View {
        GroupBox(label: Text("Instructions").font(Styling.title2Font), content: { })
        GuideText(text: "Some details about your generated brick art. You can also export the instructions to PDF")
        RoundedPanel(content: {
            CanvasDetailHeader(canvas: canvas).padding(.horizontal, 12).padding(.vertical, 6);
            
            ExportMenu() {
                AnalysisPDFView(source: source, canvas: canvas, palette: state.palette, outWidth: 1280)
            }
        }, orientation: .horizonal)
        
        GuideText(text: "Your interactive instructions for every plate with the required bricks and colors")
        GroupBox(content: {
            HStack {
                Text("Plates")
                Spacer()
                Button("Preview", action: { showTiles = true })
            }
        })
        .sheet(isPresented: $showTiles, content: {
            PlatesPreviewSheet(isOpen: $showTiles, canvas: canvas, selection: $selectedPlate)
                .environmentObject(state)
        })
        
        
        GuideText(text: "Your full list of colors and number of bricks needed for your brick art.")
        GroupBox(content: {
            HStack {
                Text("All Colors")
                Spacer()
                Toggle(showColors ? "Hide" : "Show", isOn: $showColors).toggleStyle(.button)
            }
        })
        if (showColors) {
            RoundedPanel(content: {
                AnalysisPanel.getColorListView(canvas: canvas, palette: state.palette).padding(.horizontal, 6)
            }, orientation: .vertical)
        }
    }
    
    public static func getColorListView(canvas: ArtCanvas, palette: Palette, isWide: Bool = false) -> some View {
        guard let analysis = canvas.analysis else { return RootView.anyEmpty; }
        return AnyView( ColorSwatchList(mappedColorsWithCount: analysis.colorInfo.mappedColorCounts, palette: palette, isWide: isWide))
    }
    
}


