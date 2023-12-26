import SwiftUI
import PhotosUI

struct LoadPanel: View {
    @EnvironmentObject var state: AppState;
    
    @ObservedObject var load: LoadInfo;
    @Binding var canvases: Canvases;
    @ObservedObject var source: SourceInfo;
    
    @State private var openFile: Bool = false;
    @State private var openSamples: Bool = false;
    
    var body: some View {
        
        GroupBox(label: Text("Create your Brick Art").font(Styling.title2Font), content: { })
        Picker(selection: $state.userMode, content: {
            Label("Guided", systemImage: "info.bubble").tag(UserMode.guided)
            Label("Simple", systemImage: "rectangle").tag(UserMode.simple)
            Label("Advanced", systemImage: "rectangle.on.rectangle.badge.gearshape").tag(UserMode.advanced)
        }, label: { }).pickerStyle(.segmented)
        
        if (state.userMode != .advanced) {
            GroupBox(label: Text("Guided").font(Styling.title2Font), content: {
                GuideText(text: "Select a picture or photo. Import it from your files or use a sample picture.")
                HStack { menu; Spacer(); }
                
                GuideText(text: "Select your dimensions. The dimensions are measured in plates and each plate is 16*16 bricks in size.")
                HStack {
                    Text("Dimensions")
                    Spacer()
                    CompactIconPicker(value: $load.width, systemName: "arrow.left.and.right", content: {
                        ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                    })
                    CompactIconPicker(value: $load.height, systemName: "arrow.up.and.down", content: {
                        ForEach(CanvasPanel.sizes, id: \.self) { i in Text("\(i)").tag(i) }
                    })
                }
            })
        } else {
            GroupBox(label: Text("Advanced").font(Styling.title2Font), content: {
                HStack { menu; Spacer(); }
            })
            
        }
        if (load.isImageSet) {
            GuideText(text: "Continue to setup your canvas.")
                .padding(.horizontal).padding(.top, 6)
            HStack {
                Spacer()
                RoundedButton(systemName: "arrowshape.right.circle.fill", action: {
                    startProject() 
                })
            }
        }
    }
    
    var menu: some View {
        Menu(content: {
            Button(action: { 
                openFile = true; 
            }, label: { 
                HStack { Text("Select from Files"); Spacer(); SNImage.folder; 
                } 
            })
            Divider();
            Button(action: { openSamples = true; }, 
                   label: { HStack { Text("Select from Samples"); Spacer(); SNImage.folder;
            } 
            })
            Divider();
        }, label: {
            HStack(alignment: .top) {
                Text("Select image...")
                Spacer()
                load.image.swuiImage.rs(fit: true)
                    .background(SNImage.magnifyingglassCircle)
                    .frame(maxHeight: load.isImageSet ? 96 : 18)      
            }
        })
        .fileImporter(isPresented: $openFile, allowedContentTypes: [.image]) { result in fileImport(result: result) }
        .sheet(isPresented: $openSamples, content: {
            SamplesSheet(isOpen: $openSamples, onSelect: { image in load.set(image) })
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
