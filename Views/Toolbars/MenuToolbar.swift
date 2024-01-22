import SwiftUI
import UniformTypeIdentifiers

struct MenuToolbar: View {
    @EnvironmentObject var state: GlobalState;
    @EnvironmentObject var load: LoadState;
    @EnvironmentObject var sheets: SheetsState;
    
    @ObservedObject var project: ArtProject;
    var isImageSet: Bool = false;
    var onLoad: () -> Void = {};
    var onSave: () -> Void = {};
    var onClear: () -> Void = {};
    
    
    @State private var importProject: Bool = false
    @State private var exportProject: Bool = false
    @State private var projectFile: ProjectFile? = nil
    
    var body: some View {
        HStack {
            
            Menu(content: {
                
                Button("Import Project", systemImage: "square.and.arrow.down", action: {
                    importProject = importProject.not })
                Button("Export Project", systemImage: "square.and.arrow.up", action: {
                    projectFile = ProjectFile(project: project)
                    exportProject = exportProject.not
                })
                
                Divider()
                Button("Clear Project", systemImage: "trash", role: .destructive, action: onClear)
                Divider()
                Button("Preferences...", systemImage: "gearshape.2", action: { sheets.preferences = sheets.preferences.not })
                Divider()
            }, label: {
                RoundedButton(sName: "ellipsis.circle", action: { })
            })
            
            Spacer()
            Divider()
            let isStateLoad = state.isNavState(NavState.load)
            RoundedImage(sName: "photo.badge.plus.fill" , foreground: isStateLoad ? Styling.white : Styling.gray, background: Styling.clear)
            
            let isStateSetup = state.isNavState(NavState.setup)
            RoundedImage(sName:  "rectangle.3.offgrid.fill", foreground: isStateSetup ? Styling.white : Styling.gray, background: Styling.clear)
            
            let isStateAnalysis = state.isNavState(NavState.analysis)
            RoundedImage(sName: "list.bullet.rectangle.fill" , foreground: isStateAnalysis ? Styling.white : Styling.gray, background: Styling.clear)
            Divider()
            Spacer()                
            
            // about menu
            Menu(content: {
                Button("About", systemImage: "info.square", action: {
                    sheets.about = sheets.about.not })
                Button("Source Code", systemImage: "terminal", action: {
                    sheets.sourceCode = sheets.sourceCode.not })
                Button("Feedback", systemImage: "bubble.left.and.exclamationmark.bubble.right", action: {
                    sheets.feedback = sheets.feedback.not })
                // guide 'toggle'
                Button("Guide", systemImage: state.userMode == UserMode.guided ? "questionmark.square.fill" :  "questionmark.square", action: {
                    state.userMode = state.userMode == UserMode.guided ? UserMode.simple : UserMode.guided;
                })
            }, label: {
                RoundedButton(sName: "info.square", action: { })
            })
        }
        .fileExporter(isPresented: $exportProject, document: projectFile, contentType: UTType.json, defaultFilename: "Project.baiproj", onCompletion: { result in
        })
        .fileImporter(isPresented: $importProject, allowedContentTypes: [UTType.json], onCompletion: { result in
            switch result {
            case .success(let file):
                ArtProject.importFrom(file: file, outProject: project, outState: state, outLoad: load)
            case .failure(let error):
                print("Error file import ...")
                print(error.localizedDescription)
            }
        })
        .frame(maxHeight: 32.0)
    }
    
    
}
