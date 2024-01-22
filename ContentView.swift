import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @EnvironmentObject var state: GlobalState
    @EnvironmentObject var gestures: GestureState
    @EnvironmentObject var sheets: SheetsState;
    
    @ObservedObject var load: LoadState;

    @ObservedObject var project: ArtProject;
    @Binding var canvases: Canvases;
    @ObservedObject var source: ArtSource;
    
    var isWide: Bool = false
    
    var body: some View {
        ZStack {
            RoundedPanel(content: {
                BlueprintPanel(project: project, canvases: $canvases, source: source)
                    .environmentObject(load)
                    .frame(maxHeight: isWide ? CGFloat.infinity : 380.0)
                ZStack {
                    VStack {
                        MenuToolbar(project: project, isImageSet: source.isImageSet, onLoad: { }, onSave: { }, onClear: { reset(); })
                            .environmentObject(load)
                            .padding(Edge.Set.horizontal)
                            .padding(Edge.Set.top, 6.0)
                        contentPanel
                    }
                    .frameRow(800.0, Alignment.center)
                    
                }
                .frame(alignment: Alignment.center)
                .sheet(isPresented: $sheets.about, content: { 
                    AboutSheet(isOpen: $sheets.about) 
                })
                .sheet(isPresented: $sheets.sourceCode, content: { 
                    SourceCodeSheet(isOpen: $sheets.sourceCode) 
                })
                .sheet(isPresented: $sheets.feedback, content: { 
                    FeedbackSheet(isOpen: $sheets.feedback) 
                })
                .sheet(isPresented: $sheets.preferences, content: {
                    PreferencesSheet(isOpen: $sheets.preferences, project: project)
                        .environmentObject(state)
                        .onDisappear(perform: {
                            if (state.canvas != nil) {
                                _ = state.canvas?.AnalyseAsync(source, state.palette)
                            }
                        })
                })
                
            }, orientation: isWide ? PanelOrientation.horizonal : PanelOrientation.vertical, padding: 0.0, background: Styling.clear)
            
            if (sheets.splashScreen) {
                SplashScreenPanel(isOpen: $sheets.splashScreen, isWide: isWide)
            }
        }
        
    }
    
    
    var loadPanel: some View {
        VStack() { 
            VStack { LoadPanel(load: load, project: project, canvases: $canvases, source: source) }.padding(Edge.Set.bottom)
            Spacer()
        }
    }
    var setupPanel: some View {
        VStack() {
            GuideText(text: "On the blueprint panel you can use the slider on the left/top to zoom in and out and the slider on the right/bottom to scale your canvas. You can drag and move the canvas to your desired place.")
                .padding(Edge.Set.top, 6.0)
            if (state.userMode == UserMode.advanced) {
                VStack { SourceFilterListPanel(source: source) }.padding(Edge.Set.bottom)
                VStack { CanvasesListPanel(source: source, canvases: $canvases) }.padding(Edge.Set.bottom)
            }
            if (state.canvas != nil) {
                VStack { CanvasPanel(source: source, canvas: state.canvas!) }.padding(Edge.Set.bottom)
            } else if(state.userMode == UserMode.guided) {
                VStack { CanvasesListPanel(source: source, canvases: $canvases) }.padding(Edge.Set.bottom)
            }
            Spacer() 
        }
    }
    var analysisPanel: some View {
        guard let canvas = state.canvas else { return RootView.anyEmpty  }
        return AnyView(AnalysisPanel(project: project, source: source, canvas: canvas, isWide: isWide))
    }
    
    func reset() {
        canvases.reset();
        source.reset()
        load.reset()
        state.reset()
        gestures.reset()
    }
    
    
    var contentPanel: some View {
        ScrollView(content: {
            switch state.navState {
            case NavState.load: 
                loadPanel.padding(Edge.Set.horizontal)
            case NavState.setup:
                setupPanel.padding(Edge.Set.horizontal)
            case NavState.analysis:
                analysisPanel.padding(Edge.Set.horizontal)
            }
        })
    }
}
