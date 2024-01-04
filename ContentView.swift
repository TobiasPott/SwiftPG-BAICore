import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @EnvironmentObject var state: GlobalState
    
    @ObservedObject var load: LoadState;
    @Binding var canvases: Canvases;
    @ObservedObject var source: ArtSource;
    
    @State private var image: PImage?
    var isWide: Bool = false
    
    var body: some View {
        ZStack {
            RoundedPanel(content: {
                BlueprintPanel(canvases: $canvases, source: source)
                    .environmentObject(load)
                    .frame(maxHeight: isWide ? CGFloat.infinity : 380)
                ZStack {
                    VStack {
                        MenuToolbar(isImageSet: source.isImageSet, onLoad: { loadAppState() }, onSave: { saveAppState() }, onClear: { reset(); })
                            .padding(Edge.Set.horizontal)
                            .padding(Edge.Set.top, 6)
                        contentPanel
                    }
                    // ToDo: Add different maxWidth for maxOS high res
                    .frameRow(800, Alignment.center)
                }
                .frame(alignment: Alignment.center)
                
            }, orientation: isWide ? PanelOrientation.horizonal : PanelOrientation.vertical, padding: 0, background: Styling.clear)
            
            if (state.showSplashScreen) {
                SplashScreenPanel(isOpen: $state.showSplashScreen, isWide: isWide)
            }
        }
        
    }
    
    
    var loadPanel: some View {
        VStack() { 
            VStack { LoadPanel(load: load, canvases: $canvases, source: source) }.padding(Edge.Set.bottom)
            Spacer()
        }
    }
    var setupPanel: some View {
        VStack() {
            GuideText(text: "On the blueprint panel you can use the slider on the left/top to zoom in and out and the slider on the right/bottom to scale your canvas. You can drag and move the canvas to your desired place.")
                .padding(Edge.Set.top, 6)
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
        return AnyView(AnalysisPanel(source: source, canvas: canvas, isWide: isWide))
    }
    
    func reset() {
        canvases.reset();
        source.reset()
        load.reset()
        state.reset()
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
    
    func saveAppState() -> Void {
        UserData.lastCanvases = canvases.asJSONString();
        UserData.lastSource = source.asJSONString();
    }
    func loadAppState() -> Void {
        do {
            let canvases = try UserData.lastCanvases.decode(model: Canvases.self) as! Canvases
            self.canvases.reset(canvases)
            print("Decoded Canvases: \(canvases.asJSONString())")
            
            let source = try UserData.lastSource.decode(model: ArtSource.self) as! ArtSource
            self.source.reset(source)
            print("Decoded Source: \(source.asJSONString())")
        } catch { print(error.localizedDescription) }
        
    }
    
}
