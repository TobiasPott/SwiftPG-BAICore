import SwiftUI
import UniformTypeIdentifiers

struct ExportProjectButton: View {
    
    @Binding var showAlert: Bool
    @Binding var showExport: Bool
    
    @State private var projectFile: ProjectFile? = nil
    let project: ArtProject
    
    var body: some View {
//        Button("Import Project", systemImage: "square.and.arrow.down", action: {
//            showAlert = showAlert.not })
        Button("Export Project", systemImage: "square.and.arrow.up", action: {
            projectFile = ProjectFile(project: project)
            showExport = showExport.not
        })
        .fileExporter(isPresented: $showExport, document: projectFile, contentType: UTType.json, defaultFilename: "Project.baiproj", onCompletion: { result in
        })
    
    }
}
