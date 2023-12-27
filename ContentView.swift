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
//                                .padding(.top, isLandscape ? 12 : 0)
                            
                            ScrollView(content: {
                                getContentView().padding(.horizontal)
                            })
                        }
                        .frame(maxWidth: 700, alignment: .center)
                    }
                    .mask(Rectangle())
                    .frame(maxWidth: 700, alignment: .center)
                    
                }, orientation: isLandscape ? .horizonal : .vertical, padding: 0, background: .clear)
                
                if (state.showSplashScreen) {
                    BlueprintGrid(baseSpacing: 64, lineWidth: isLandscape ? 1.5 : 0.75)
                        .task(priority: .medium, delayCover)
                        .zIndex(1)
                        .scaleEffect(isLandscape ? 2.76 : 4.8)
                        .transition(.move(edge: isLandscape ? .leading : .top))
                        .overlay(content: {
                            GroupBox(content: {
                                Button(action: {
                                    withAnimation {
                                        state.showSplashScreen.toggle()
                                    }
                                }, label: {
                                    VStack{
                                        Styling.appIcon.swuiImage
                                            .rs(fit: true)
                                            .mask(Styling.roundedRect)
                                            .shadow(color: .black.opacity(0.75), radius: 10)
                                        Text("Open Brick Art Instructor").font(Styling.titleFont)
                                        Text("(will continue in 30s)").font(.caption2)
                                    }
                                    .frame(maxWidth: 300, alignment: .center)
                                })
                                
                            })
                            .padding()
                        })
                }
            }
        }
    }
    @Sendable private func delayCover() async {
        // Delay of 7.5 seconds (1 second = 1_000_000_000 nanoseconds)
        try? await Task.sleep(nanoseconds: 30_000_000_000)
        withAnimation {
            state.showSplashScreen = false
        }
    }
    
    func reset() {
        canvases.reset();
        source.reset()
        load.reset()
        state.reset()
    }
    
    func getContentView() -> some View {
        switch state.navState {
        case .load: 
            return AnyView(VStack() { 
                VStack { LoadPanel(load: load, canvases: $canvases, source: source) }.padding(.bottom)
                Spacer()
            })
        case .setup:
            return AnyView(VStack() {
                GroupBox(label: Text("Setup your canvas").font(Styling.title2Font), content: {
                    GuideText(text: "On the blueprint panel you can use the slider on the left/top to zoom in and out and the slider on the right/bottom to scale your canvas. You can drag and move the canvas to your desired place.")
                })
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
            })
        case .analysis:
            guard let canvas = state.canvas else { return RootView.anyEmpty }
            return AnyView(AnalysisPanel(source: source, canvas: canvas))
        }
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
