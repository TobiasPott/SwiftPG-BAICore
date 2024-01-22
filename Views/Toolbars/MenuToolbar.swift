import SwiftUI
import UniformTypeIdentifiers

struct MenuToolbar: View {
    @EnvironmentObject var state: GlobalState;
    @EnvironmentObject var sheets: SheetsState;
    
    @ObservedObject var project: ArtProject;
    var isImageSet: Bool = false;
    var onLoad: () -> Void = {};
    var onSave: () -> Void = {};
    var onClear: () -> Void = {};
    
    @State private var preExportProject: Bool = false
    @State private var exportProject: Bool = false
    
    @State private var preImportProject: Bool = false
    @State private var importProject: Bool = false
    @State private var projectFile: ProjectFile? = nil
    
    var body: some View {
        HStack {
            
            Menu(content: {
                Button("Import Project", systemImage: "square.and.arrow.down", action: {
                    preImportProject = preImportProject.not })
                Button("Export Project", systemImage: "square.and.arrow.up", action: {
                    projectFile = ProjectFile(project: project)
                    preExportProject = preExportProject.not
                })
                Divider()
                Button("Clear Project", systemImage: "trash", role: .destructive, action: onClear)
                Divider()
                Button("Preferences...", systemImage: "gearshape.2", action: { sheets.preferences = sheets.preferences.not })
                Divider()
                //                Menu(content: {
                //                    UserModePicker(userMode: $state.userMode)
                //                }, label: {
                //                    Button("Mode", systemImage: "ellipsis", action: { })
                //                })
            }, label: {
                RoundedButton(sName: "ellipsis.circle", action: { })
            })
            Spacer()
            Divider()
            
            let isStateLoad = state.isNavState(NavState.load)
            RoundedImage(sName: "plus.square.fill" , foreground: isStateLoad ? Styling.white : Styling.gray, background: Styling.clear)
            
            let isStateSetup = state.isNavState(NavState.setup)
            RoundedImage(sName:  "photo.stack.fill", foreground: isStateSetup ? Styling.white : Styling.gray, background: Styling.clear)
            
            let isStateAnalysis = state.isNavState(NavState.analysis)
            RoundedImage(sName: "square.grid.3x3.fill" , foreground: isStateAnalysis ? Styling.white : Styling.gray, background: Styling.clear)
            Divider()
            //            }
            Spacer()                
            
            
            Menu(content: {
                Button("About", systemImage: "info.square.fill", action: {
                    sheets.about = sheets.about.not })
                Button("Source Code", systemImage: "terminal.fill", action: {
                    sheets.sourceCode = sheets.sourceCode.not })
                Button("Feedback", systemImage: "bubble.left.and.exclamationmark.bubble.right.fill", action: {
                    sheets.feedback = sheets.feedback.not })
            }, label: {
                RoundedButton(sName: "info.circle", action: { })
            })
        }
        
        .alert("Export a project will include a copy of your source image. Be considerate when sharing your projects.", isPresented: $preExportProject, actions: {
            Button("Ok", action: { exportProject = exportProject.not }) 
            Button("Cancel", role: ButtonRole.cancel, action: {})
        })
        .fileExporter(isPresented: $exportProject, document: projectFile, contentType: UTType.json, defaultFilename: "Project.baiproj", onCompletion: { result in
        })
        
        .alert("Importing a project will clear all progress. Please be careful and save your progress", isPresented: $preImportProject, actions: {
            Button("Ok", action: { importProject = importProject.not }) 
            Button("Cancel", role: ButtonRole.cancel, action: {})
        })
        .fileImporter(isPresented: $importProject, allowedContentTypes: [UTType.json], onCompletion: { result in
            switch result {
            case .success(let file):
                //                print(file.absoluteString)
                
                guard file.startAccessingSecurityScopedResource() else { return }
                do {
                    let contents = try String(contentsOf: file)
                    //                    DispatchQueue.main.async {  
                    do {
                        //                        print(contents)
                        let impProj = try ArtProject.fromJson(jsonData: Data(contents.utf8)) as! ArtProject
                        self.project.load(from: impProj);
                        
                        //                        print("\(self.project.canvases.items.count) => \(impProj.canvases.items.count)")
                        if (self.project.canvases.items.count > 0) {
                            state.canvas = self.project.canvases.items[0]
                            _ = state.canvas?.Analyse(self.project.source, state.palette)
                        }
                        // change to setup state and keep canvas if user is still in load state
                        if (state.canvas != nil) { state.setNavState(NavState.setup, true) }
                        
                    } catch {
                        print("Error converting json...")
                        print(error.localizedDescription)
                    }
                    //                    }   
                } catch {
                    print("Error reading file...")
                    print(error.localizedDescription)
                }
                
                file.stopAccessingSecurityScopedResource()
                //                
            case .failure(let error):
                
                print("Error file import ...")
                print(error.localizedDescription)
            }
        })
        
        .frame(maxHeight: 32.0)
    }
}
