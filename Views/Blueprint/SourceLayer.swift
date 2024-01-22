import SwiftUI
import UniformTypeIdentifiers

struct SourceLayer<Content: View>: View {
    @EnvironmentObject var state: GlobalState
    @EnvironmentObject var gestures: GestureState
    
    @ObservedObject var load: LoadState;
    @ObservedObject var source: ArtSource;
    @Binding var canvases: Canvases
    @ViewBuilder let overlayContent: () -> Content
    
    @State var openMenu: Bool = false
    @State var openSamples: Bool = false
    @State var openFile: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack() {
                    BlueprintGrid(baseSpacing: 64.0, lineWidth: 0.75).scaleEffect(12.0, anchor: UnitPoint.center)
                    if (!state.isNavState(NavState.load) && source.isImageSet) {
                        source.image.swuiImage.overlay(content: { overlayContent() })
                    } else {
                        ZStack {   
                            Styling.appIcon.swuiImage
                                .resizable()
                                .aspectRatio(contentMode: ContentMode.fill)
                                .frameSquare(256.0)
                                .overlay(content: { emptyOverlayContent })   
                                .mask(Styling.roundedRect)
                                .shadow(color: Styling.black.opacity(0.75), radius: 32.0)
                            
                        }.scaleEffect(4.0)
                    }
                }       
                .scaleEffect(gestures.srcZoom.scale / 100.0)
                .gesture(GetDragGesture(), enabled: source.isImageSet && gestures.srcDrag.enabled)
                .gesture(GetZoomGesture(), enabled: source.isImageSet && gestures.srcZoom.enabled)
            }
            .offset(x: gestures.srcDrag.fixedLocation.x, y: gestures.srcDrag.fixedLocation.y)
            
            if (gestures.srcDrag.active) {
                source.image.swuiImage
                    .scaleEffect(gestures.srcZoom.scale / 100.0)
                    .offset(x: gestures.srcDrag.location.x, y: gestures.srcDrag.location.y)
                    .opacity(0.75)
            }
        }
    }
    
    func GetZoomGesture() -> _EndedGesture<_ChangedGesture<MagnificationGesture>> {
        return MagnificationGesture()
            .onChanged { magValue in
                gestures.srcZoom.update(magValue)
            }.onEnded { magValue in
                gestures.srcZoom.update(magValue, true)
                gestures.srcZoom.clamp(10.0, 199.0)
            }
    }
    
    func GetDragGesture() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture().onChanged { gesture in
            gestures.srcDrag.update(gesture, false);
        }
        .onEnded { gesture in          
            gestures.srcDrag.update(gesture, true);
        }
    }
    
    
    var emptyOverlayContent: some View {
        Group { 
            selectFileMenu
                .frameStretch(Alignment.center)
            Styling.roundedRect.stroke(Styling.black.opacity(0.9), lineWidth: 2.0)
            Styling.roundedRect.stroke(Styling.black.opacity(0.5), lineWidth: 6.0)
        }
    }
    
    var selectFileMenu: some View {
        Group {
            VStack {
                Button(action: {
                    openMenu = openMenu.not
                }, label: {
                    ZStack {
                        if (load.isImageSet) {
                            Styling.gray
                            load.image.swuiImage.rs()
                                .overlay(content: {
                                    Grid(cols: CGFloat(load.width), rows: CGFloat(load.height), gridColor: Styling.white).aspectRatio(load.aspect, contentMode: .fit)
                                })
                            Button("", systemImage: "trash", action: {
                                withAnimation { load.set(Defaults.image) }
                            })
                            .modifier(ShadowOutline())
                            .frameStretch(Alignment.topTrailing)
                            .padding(Edge.Set.trailing)
                            .padding(Edge.Set.top)
                            
                            Text("Tap to pick another")
                                .modifier(ShadowText())
                                .frameStretch(Alignment.bottom)
                                .padding(Edge.Set.bottom)
                        } else {
                            Text("Tap to select a picture")
                                .modifier(ShadowText())
                                .frameStretch(Alignment.bottom)
                                .padding(Edge.Set.bottom)
                        }
                    }
                    .confirmationDialog("Select image from...", isPresented: $openMenu, actions: {
                        Button(action: { openFile = openFile.not }, 
                               label: { Label("Select from Files", systemImage: "folder") })
                        Button(action: { openSamples = openSamples.not }, 
                               label: { Label("Select from Samples", systemImage: "photo.on.rectangle.angled") })
                    })
                    .foregroundColor(Styling.accent)
                })
                
            }
        }
        .fileImporter(isPresented: $openFile, allowedContentTypes: [UTType.image]) { result in load.importImage(result: result) }
        .sheet(isPresented: $openSamples, content: {
            SamplesSheet(isOpen: $openSamples, onSelect: { image in load.set(image) })
        })
        
    }
    
}

