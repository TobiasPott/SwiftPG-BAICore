import SwiftUI

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
        ZStack {
            ZStack {
                ZStack() {
                    BlueprintGrid(baseSpacing: 64, lineWidth: 0.75).scaleEffect(12, anchor: .center)
                    if (source.isImageSet) {
                        source.image.swuiImage.overlay(content: { overlayContent() })
                    } else {
                        ZStack {   
                            Styling.appIcon.swuiImage
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frameSquare(256)
                                .overlay(content: { emptyOverlayContent })   
                                .mask(Styling.roundedRect)
                                .shadow(color: Styling.black.opacity(0.75), radius: 32)
                            
                        }.scaleEffect(4)
                    }
                }       
                .scaleEffect(state.zoom.scale / 100, anchor: .center)
                .gesture(GetDragGesture(), enabled: source.isImageSet && !state.srcDragLocked)
                .gesture(GetZoomGesture(), enabled: source.isImageSet && !state.srcZoomLocked)
            }
            .offset(x: state.drag.fixedLocation.x, y: state.drag.fixedLocation.y)
            
            if (state.drag.active) {
                source.image.swuiImage
                    .scaleEffect(state.zoom.scale / 100, anchor: .center)
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
                state.zoom.clamp(10, 199)
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
                            Styling.blueprintColor
                            load.image.swuiImage.rs()
                            
                            RoundedButton(systemName: "arrowshape.right.circle.fill", size: 42, action: { 
                                LoadPanel.StartProject(state, load, source, $canvases)
                            })
                            .frameStretch(Alignment.bottom).padding(.bottom)
                        } else {
                            Text("Tap to select a picture")
                                .font(Styling.title2Font).bold()
                                .foregroundColor(.primary)
                                .frameStretch(Alignment.bottom).padding(.bottom)
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
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.image]) { result in load.importImage(result: result) }
        .sheet(isPresented: $openSamples, content: {
            SamplesSheet(isOpen: $openSamples, onSelect: { image in load.set(image) })
        })
        
    }
    
}

