import SwiftUI
import UniformTypeIdentifiers

struct LoadPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var load: LoadState;
    @ObservedObject var project: ArtProject
    @Binding var canvases: Canvases;
    @ObservedObject var source: ArtSource;
    
    @State private var openFile: Bool = false;
    @State private var openSamples: Bool = false;
    
    @State private var importProject: Bool = false
    
    var body: some View {
        let hasCanvas = project.canvases.items.count > 0
        if (hasCanvas) {
            RoundedPanel(content: {
                GuideText(text: "Continue with your existing canvas.").padding([Edge.Set.horizontal, Edge.Set.top])
                HStack {
                    Spacer()
                    RoundedButton(sName: "arrowshape.turn.up.right.circle.fill", leadingLabel: "Continue", action: { state.setNavState(NavState.setup, true) })
                }
                .font(Styling.headlineFont)
                .padding(Edge.Set.horizontal)
                .padding(Edge.Set.vertical, 8.0)
            }, orientation: PanelOrientation.vertical)
        } else {
            GroupView(label: {
                HStack {
                    Text("Make your Brick Art").font(Styling.title2Font)
                    Spacer()
                }
            }, content: {
                GuideText(text: "Import a project you saved to disk in a previous session.")
                Button(action: {
                    importProject = importProject.not
                }, label: {
                    HStack {
                        Text("Import Project")
                        Spacer()
                        Image(systemName: "square.and.arrow.down")
                    }
                })
                .padding(Edge.Set.top, 6)
                .fileImporter(isPresented: $importProject, allowedContentTypes: [UTType.json], onCompletion: { result in
                    switch result {
                    case .success(let file):
                        ArtProject.importFrom(file: file, outProject: project, outState: state, outLoad: load)
                    case .failure(let error):
                        print("Error file import ...")
                        print(error.localizedDescription)
                    }
                })
            })
        }
        if (state.userMode != UserMode.advanced) {
            GroupView(label: {
                HStack {
                    Text("New Canvas")
                    if (load.isImageSet) {
                        Spacer()
                        RoundedButton(sName: "arrowshape.right.circle.fill", leadingLabel: "Create", action: { startProject() })
                            .font(Styling.headlineFont)
                            .padding(Edge.Set.vertical, 8.0)
                    }
                }
                
            }, content: {
                
                GuideText(text: "Select a picture or photo. Import it from your files or use a sample picture.")
                HStack(alignment: VerticalAlignment.top) { selectFileMenu }
                
                GuideText(text: "Choose your layout between 'landscape', 'square' and 'portrait'.")
                HStack() { layoutMenu }
                
                GuideText(text: "Choose the level of details for your art between 'low', 'medium' and 'high'.")
                HStack() { detailsMenu }
                
                GuideText(text: "Select the color palette you want to use. The preview will show you the colors included in each palette and your brick art will be limited to those colors.")
                HStack() { paletteMenu }
                
            })
        } else {
            GroupView(label: { Text("Advanced") }, content: {
                HStack(alignment: VerticalAlignment.top) { selectFileMenu }
                HStack() { paletteMenu }
            })
            
        }
    }
    
    var selectFileMenu: some View {
        Group {
            Text("Image").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Divider()
            Spacer()
            Menu(content: {
                Button(action: { openFile = openFile.not }, 
                       label: { Label("Select from Files", systemImage: "folder") })
                Divider();
                Button(action: { openSamples = openSamples.not }, 
                       label: { Label("Select from Samples", systemImage: "photo.on.rectangle.angled") })
            }, label: {
                HStack() {
                    Text("Select")
                        .frame(maxHeight: 26.0)
                    if (load.isImageSet) {
                        load.image.swuiImage.rs()
                            .frame(maxHeight: 64.0)
                            .mask(Styling.roundedRectHalf)
                            .padding(Edge.Set.leading, 6.0)
                    } 
                }.padding(Edge.Set.trailing, 6.0)
            })
        }
        .fileImporter(isPresented: $openFile, allowedContentTypes: [UTType.image]) { result in load.importImage(result: result) }
        .sheet(isPresented: $openSamples, content: {
            SamplesSheet(isOpen: $openSamples, onSelect: { image in load.set(image) })
        })
        
    }
    var detailsMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Details").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Divider()
            Spacer()
            HStack(alignment: VerticalAlignment.top) {
                RoundedStateButton(sName: "square", action: {
                    load.setDetails(LoadDetails.low)
                }, state: load.isDetail(LoadDetails.low), stateColor: Styling.gray, background: Styling.clear)
                RoundedStateButton(sName: "square.grid.2x2", action: {
                    load.setDetails(LoadDetails.medium)
                }, state: load.isDetail(LoadDetails.medium), stateColor: Styling.gray, background: Styling.clear)
                RoundedStateButton(sName: "square.grid.3x3", action: {
                    load.setDetails(LoadDetails.high)
                }, state: load.isDetail(LoadDetails.high), stateColor: Styling.gray, background: Styling.clear)
            }
        }
    }
    var layoutMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Layout").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Divider()
            Spacer()
            HStack(alignment: VerticalAlignment.top) {
                RoundedStateButton(sName: "rectangle.ratio.16.to.9", action: {
                    load.setLayout(LoadLayout.landscape)
                }, state: load.isLayout(LoadLayout.landscape), stateColor: Styling.gray, background: Styling.clear)
                RoundedStateButton(sName: "square", action: {
                    load.setLayout(LoadLayout.square)
                }, state: load.isLayout(LoadLayout.square), stateColor: Styling.gray, background: Styling.clear)
                RoundedStateButton(sName: "rectangle.ratio.9.to.16", action: {
                    load.setLayout(LoadLayout.portrait)
                }, state: load.isLayout(LoadLayout.portrait), stateColor: Styling.gray, background: Styling.clear)
            }
        }
    }
    
    var dimensionsMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Plates").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Divider()
            Spacer()
            VStack(spacing: 0.0) {
                HStack {
                    Text("X")
                    Spacer()
                    Picker("X", selection: $load.width, content: {
                        ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                    })
                }
                HStack {
                    Text("Y")
                    Spacer()
                    Picker("Y", selection: $load.height, content: {
                        ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                    })
                }
            }.padding(Edge.Set.top, -6.0)
        }
    }
    var paletteMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Palette").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Divider()
            Spacer()
            VStack(alignment: HorizontalAlignment.trailing) {
                PalettePicker(selection: $load.builtInPalette)
                PaletteRowPreview(palette: load.palette, size: 12.0)
            }
        }.onChange(of: load.builtInPalette, perform: { value in
            load.palette = Palette.getPalette(load.builtInPalette)
        }) 
    }
    
    func startProject() {
        LoadPanel.StartProject(state, load, project, source, $canvases)
    }
    
    static func StartProject(_ state: GlobalState, _ load: LoadState, _ project: ArtProject, _ source: ArtSource, _ canvases : Binding<Canvases> ) {
        state.reset()
        source.reset()
        canvases.wrappedValue.reset()
        // set palette from load info
        project.builtInPalette = load.builtInPalette;
        state.palette = load.palette
        if (load.isImageSet) {
            source.setImage(image: load.image)
            if (state.userMode != UserMode.advanced) {
                let canvas = load.getCanvas(refSize: source.image.size)
                canvases.wrappedValue.append(canvas)
                state.canvas = canvas
            }
            state.setNavState(NavState.setup, true);
        }
        // reset load info after loading
        //        load.reset()
    }
}
