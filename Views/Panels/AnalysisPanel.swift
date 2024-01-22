import SwiftUI
import UniformTypeIdentifiers

struct AnalysisPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    let project: ArtProject;
    let source: ArtSource;
    let canvas: ArtCanvas;
    var isWide: Bool = false
    
    @State var showColors: Bool = false;
    @State var showTiles: Bool = false;
    @State var showPreview: Bool = false;
    @State var selectedPlate: Int2 = Int2(x: 0, y: 0);
    
    @State private var exportProject: Bool = false
    @State private var projectFile: ProjectFile? = nil
    
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
            HStack(alignment: VerticalAlignment.top) {
                Text("Export")
                Spacer()
                VStack(alignment: HorizontalAlignment.trailing) {
                    
                    Button("Project", action: {
                        projectFile = ProjectFile(project: project)
                        exportProject = exportProject.not
                    })
                    Divider().frame(maxWidth: 40.0)
                    Button("PDF", action: { showPreview = true })
                }
                .fileExporter(isPresented: $exportProject, document: projectFile, contentType: UTType.json, defaultFilename: "Project.baiproj", onCompletion: { result in
                })
            }
            Divider()
            HStack(alignment: VerticalAlignment.top) {
                Text("View")
                Spacer()
                VStack(alignment: HorizontalAlignment.trailing) {
                    GuideText(text: "Your interactive instructions for every plate with the required bricks and colors")
                    Button("Instructions", action: { showTiles = true })
                    Divider().frame(maxWidth: 90.0)
                    GuideText(text: "Your full list of colors and number of bricks needed for your brick art.")
                    Button("Colors", action: { showColors = true })
                }
            }
        })
        .sheet(isPresented: $showPreview, content: {
            PDFPreview(isOpen: $showPreview, canvas: canvas, source: source, width: 1280)
                .environmentObject(state)
        })
        .sheet(isPresented: $showTiles, content: {
            PlatesPreviewSheet(isOpen: $showTiles, canvas: canvas, selection: $selectedPlate, isWide: isWide)
                .environmentObject(state)
        })
        .sheet(isPresented: $showColors, content: {
            ColorListSheet(isOpen: $showColors, canvas: canvas, isWide: isWide)
                .environmentObject(state)
        })
        
    }
}


