import SwiftUI
import UniformTypeIdentifiers

struct SourceLayer<Content: View>: View {
    @EnvironmentObject var state: GlobalState
    
    @ObservedObject var load: LoadState;
    @ObservedObject var source: ArtSource;
    @Binding var canvases: Canvases
    @ViewBuilder let overlayContent: () -> Content
    
    @State var openMenu: Bool = false
    @State var openSamples: Bool = false
    @State var openFile: Bool = false
    
    var body: some View {
        // ToDo: Fix source view to prioritize load.image when it is set over source
        //       ponder if this is correct and works out
        ZStack {
            ZStack {
                ZStack() {
                    BlueprintGrid(baseSpacing: 64.0, lineWidth: 0.75).scaleEffect(12.0, anchor: UnitPoint.center)
                    if (source.isImageSet) {
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
                .scaleEffect(state.zoom.scale / 100.0, anchor: UnitPoint.center)
                .gesture(GetDragGesture(), enabled: source.isImageSet && !state.srcDragLocked)
                .gesture(GetZoomGesture(), enabled: source.isImageSet && !state.srcZoomLocked)
            }
            .offset(x: state.drag.fixedLocation.x, y: state.drag.fixedLocation.y)
            
            if (state.drag.active) {
                source.image.swuiImage
                    .scaleEffect(state.zoom.scale / 100.0, anchor: UnitPoint.center)
                    .offset(x: state.drag.location.x, y: state.drag.location.y)
                    .opacity(0.75)
            }
        }
    }
    
    func GetZoomGesture() -> _EndedGesture<_ChangedGesture<MagnificationGesture>> {
        return MagnificationGesture()
            .onChanged { magValue in
                state.zoom.update(magValue)
            }.onEnded { magValue in
                state.zoom.update(magValue, true)
                state.zoom.clamp(10.0, 199.0)
            }
    }
    
    func GetDragGesture() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        return DragGesture().onChanged { gesture in
            state.drag.update(gesture, false);
        }
        .onEnded { gesture in          
            state.drag.update(gesture, true);
        }
    }
    
    
    var emptyOverlayContent: some View {
        Group { 
            Styling.roundedRect.foregroundColor(Styling.black.opacity(0.25))
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
                    openMenu.toggle()
                }, label: {
                    ZStack {
                        if (load.isImageSet) {
                            Styling.gray
                            load.image.swuiImage.rs()
                            
                            RoundedButton(systemName: "arrowshape.right.circle.fill", size: 42.0, action: { 
                                LoadPanel.StartProject(state, load, source, $canvases)
                            })
                            .frameStretch(Alignment.bottom).padding(Edge.Set.bottom)
                        } else {
                            Text("Tap to select a picture")
                                .font(Styling.title2Font).bold()
                                .foregroundColor(Color.primary)
                                .frameStretch(Alignment.bottom)
                                .padding(Edge.Set.bottom)
                        }
                    }
                    .confirmationDialog("Select image from...", isPresented: $openMenu, actions: {
                        Button(action: { openFile.toggle(); }, 
                               label: { Label("Select from Files", systemImage: "folder") })
                        Button(action: { openSamples.toggle(); }, 
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

