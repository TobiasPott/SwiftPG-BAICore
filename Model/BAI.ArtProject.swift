import SwiftUI
import UniformTypeIdentifiers

class ArtProject : ObservableObject, Codable {
    
    private enum CodingKeys: String, CodingKey {
        case builtInPalette, outline, source, canvases, sheets
    }
    
    // art data
    @Published var builtInPalette: BuiltInPalette = BuiltInPalette.legoReduced
    @Published var outline: BrickOutlineMode = BrickOutlineMode.outlined;
    
    @Published var source: ArtSource
    @Published var canvases: Canvases 
    
    // states
    @Published var sheets: SheetsState
    
    
    init() {
        source = ArtSource()
        canvases = Canvases()
        sheets = SheetsState()
        
        builtInPalette = BuiltInPalette.legoReduced
        outline = BrickOutlineMode.outlined
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        outline = try container.decode(BrickOutlineMode.self, forKey: CodingKeys.outline)
        
        source = try container.decode(ArtSource.self, forKey: CodingKeys.source)
        canvases = try container.decode(Canvases.self, forKey: CodingKeys.canvases)
        
        sheets = try container.decode(SheetsState.self, forKey: CodingKeys.sheets)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(outline, forKey: CodingKeys.outline)
        
        try container.encode(source, forKey: CodingKeys.source)
        try container.encode(canvases, forKey: CodingKeys.canvases)
        
        try container.encode(sheets, forKey: CodingKeys.sheets)        
    }
    
    func load(from: ArtProject) {
        self.outline = from.outline;
        
        self.builtInPalette = from.builtInPalette;
        self.source.reset(from.source)
        self.canvases.reset(from.canvases)
        self.sheets = from.sheets
        
    }
    
    
    static func importFrom(file: URL, outProject: ArtProject, outState: GlobalState, outLoad: LoadState) {
        guard file.startAccessingSecurityScopedResource() else { return }
        do {
            let contents = try String(contentsOf: file)  
            do {
                let impProj = try ArtProject.fromJson(jsonData: Data(contents.utf8)) as! ArtProject
                outProject.load(from: impProj);
                // set project image into load state (allows user to return to setup page and change canvas properties)
                outLoad.set(outProject.source.originalImage)
                outLoad.builtInPalette = outProject.builtInPalette
                outLoad.palette = Palette.getPalette(outProject.builtInPalette)
                
                if (outProject.canvases.items.count > 0) {
                    outState.canvas = outProject.canvases.items[0]
                    _ = outState.canvas?.Analyse(outProject.source, outState.palette)
                }
                if (outState.canvas != nil) { outState.setNavState(NavState.setup, true) }
            } catch {
                print("Error converting json...")
                print(error.localizedDescription)
            }   
        } catch {
            print("Error reading file...")
            print(error.localizedDescription)
        }
        
        file.stopAccessingSecurityScopedResource()
    }
    
}

struct ProjectFile: FileDocument {
    static let baiprojType = UTType(exportedAs: "de.tobiaspott.brickartinstructor.baiproj", conformingTo: UTType.json)
    
    // tell the system we support only plain text
    static var readableContentTypes = [UTType.json, ProjectFile.baiprojType]
    
    // by default our document is empty
    var jsonString: String
    
    // a simple initializer that creates new, empty documents
    init(project: ArtProject) {
        jsonString = project.asJSONString()
    }
    
    // this initializer loads data that has been saved previously
    init(configuration: ReadConfiguration) throws {
        if let data = configuration.file.regularFileContents {
            jsonString = String(data: data, encoding: .utf8) ?? ""
        } else {
            throw CocoaError(.fileReadCorruptFile)
        }
    }
    
    // this will be called when the system wants to write our data to disk
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = jsonString.data(using: .utf8) ?? Data()
        return FileWrapper(regularFileWithContents: data)
    }
}
