import SwiftUI
import UniformTypeIdentifiers

struct ContentView: View {
    @EnvironmentObject var state: AppState
    
    @ObservedObject var load: LoadInfo;
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;
    
    @State private var image: PImage?
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape: Bool = (geometry.size.width / geometry.size.height) > 1
            
            ZStack {
                RoundedPanel(content: {
                    BlueprintPanel(canvases: $canvases, source: source, isLandscape: isLandscape)
                        .frame(maxHeight: isLandscape ? .infinity : 380)
                    ZStack {
                        VStack {
                            MenuToolbar(isImageSet: source.isImageSet, onLoad: { loadAppState() }, onSave: { saveAppState() }, onClear: { reset(); })
                                .padding([.leading, .top, .trailing])
                            contentPanel
                        }
                        .frame(maxWidth: 800, alignment: .center)
                    }
                    .frame(alignment: .center)
                    
                }, orientation: isLandscape ? .horizonal : .vertical, padding: 0, background: .clear)
                
                if (state.showSplashScreen) {
                    SplashScreenPanel(isOpen: $state.showSplashScreen, isLandscape: isLandscape)
                }
            }
        }
    }
    
    
    var loadPanel: some View {
        VStack() { 
            VStack { LoadPanel(load: load, canvases: $canvases, source: source) }.padding(.bottom)
            Spacer()
        }
    }
    var setupPanel: some View {
        VStack() {
            GuideText(text: "On the blueprint panel you can use the slider on the left/top to zoom in and out and the slider on the right/bottom to scale your canvas. You can drag and move the canvas to your desired place.")
                .padding(.top, 6)
            if (state.userMode == .advanced) {
                VStack { SourceFilterListPanel(source: source) }.padding(.bottom)
                VStack { CanvasesListPanel(source: source, canvases: $canvases) }.padding(.bottom)
            }
            if (state.canvas != nil) {
                VStack { CanvasPanel(source: source, canvas: state.canvas!) }.padding(.bottom)
            } else if(state.userMode == .guided) {
                VStack { CanvasesListPanel(source: source, canvases: $canvases) }.padding(.bottom)
            }
            Spacer() 
        }
    }
    var analysisPanel: some View {
        guard let canvas = state.canvas else { return RootView.anyEmpty  }
        return AnyView(AnalysisPanel(source: source, canvas: canvas))
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
            case .load: 
                loadPanel.padding(.horizontal)
            case .setup:
                setupPanel.padding(.horizontal)
            case .analysis:
                analysisPanel.padding(.horizontal)
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
            
            let source = try UserData.lastSource.decode(model: SourceInfo.self) as! SourceInfo
            self.source.reset(source)
            print("Decoded Source: \(source.asJSONString())")
        } catch { print(error.localizedDescription) }
        
    }
    
}
