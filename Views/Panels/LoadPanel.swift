import SwiftUI
import SwiftPG_Palettes

struct LoadPanel: View {
    @EnvironmentObject var state: GlobalState;
    
    @ObservedObject var load: LoadState;
    @Binding var canvases: Canvases;
    @ObservedObject var source: ArtSource;
    
    @State private var openFile: Bool = false;
    @State private var openSamples: Bool = false;
    
    
    var body: some View {
        
        GroupBox(label: Text("Create your Brick Art").font(Styling.title2Font), content: { })
        
        UserModePicker(userMode: $state.userMode)
            .pickerStyle(.segmented)
        GuideText(text: "Choose your app mode, 'Guided' shows help info about your options and interaction with the app.\n'Simple' is meant to create a single instruction from your picture.\n'Advanced' enables additional options like image filters and multiple canvases.")
        
        if (load.isImageSet) {
            RoundedPanel(content: {
                GuideText(text: "Continue to setup your canvas.").padding([.horizontal, .top])
                HStack {
                    Spacer()
                    Text("Create")
                    RoundedButton(systemName: "arrowshape.right.circle.fill", size: 42, action: { startProject() })
                }.padding(.horizontal).padding(.vertical, 8)
            }, orientation: PanelOrientation.vertical)
        }
        if (state.userMode != .advanced) {
            GroupBox(label: Text("Quick Setup").font(Styling.title2Font), content: {
                GuideText(text: "Select a picture or photo. Import it from your files or use a sample picture.")
                HStack(alignment: VerticalAlignment.top) { selectFileMenu }
                
                GuideText(text: "Select your dimensions. The dimensions are measured in plates and each plate is 16*16 bricks in size.")
                HStack() { dimensionsMenu }
                
                GuideText(text: "Select the color palette you want to use. The preview will show you the colors included in each palette and your brick art will be limited to those colors.")
                HStack() { paletteMenu }
            })
        } else {
            GroupBox(label: Text("Advanced").font(Styling.title2Font), content: {
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
                Button(action: { openFile.toggle(); }, 
                       label: { Label("Select from Files", systemImage: "folder") })
                Divider();
                Button(action: { openSamples.toggle(); }, 
                       label: { Label("Select from Samples", systemImage: "photo.on.rectangle.angled") })
            }, label: {
                HStack() {
                    SNImage.magnifyingglassCircle.rs(fit: true)
                        .frame(maxHeight: 26)
                    if (load.isImageSet) {
                        load.image.swuiImage.rs()
                            .frame(maxHeight: 64)
                            .mask(Styling.roundedRectHalf)
                            .padding(.leading, 6)
                    } 
                }.padding(.trailing, 6)
            })
        }
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.image]) { result in fileImport(result: result) }
        .sheet(isPresented: $openSamples, content: {
            SamplesSheet(isOpen: $openSamples, onSelect: { image in load.set(image) })
        })
        
    }
    
    var dimensionsMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Plates").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Divider()
            Spacer()
            VStack(spacing: 0) {
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
            }.padding(.top, -6)
        }
    }
    var paletteMenu: some View {
        HStack(alignment: VerticalAlignment.top) {
            Text("Palette").frame(width: Styling.labelWidth, alignment: Alignment.leading)
            Divider()
            Spacer()
            VStack(alignment: HorizontalAlignment.trailing) {
                PalettePicker(selection: $load.builtInPalette)
                    .padding(.vertical, -6)
                PaletteRowPreview(palette: load.palette, size: 12)
            }
        }.onChange(of: load.builtInPalette, perform: { value in
            load.palette = Palette.getPalette(load.builtInPalette)
        }) 
    }
    
    func fileImport(result: Result<URL, Error>) -> Void {
        do {
            let fileUrl = try result.get()
            print(fileUrl)
            
            guard fileUrl.startAccessingSecurityScopedResource() else { return }
            if let imageData = try? Data(contentsOf: fileUrl),
               let image = PImage(data: imageData) {
                load.set(image)
            }
            fileUrl.stopAccessingSecurityScopedResource()
            
        } catch {
            
            print ("Error reading file from disk.")
            print (error.localizedDescription)
        }
    }
    
    func startProject() {
        state.reset()
        source.reset()
        canvases.reset()
        // set palette from load info
        state.builtInPalette = load.builtInPalette;
        state.palette = load.palette
        if (load.isImageSet) {
            source.setImage(image: load.image)
            if (state.userMode != .advanced) {
                let canvas = load.getCanvas(refSize: source.image.size)
                canvases.append(canvas)
                state.canvas = canvas
            }
            state.setNavState(.setup, true);
        }
        // reset load info after loading
        //        load.reset()
    }
}
