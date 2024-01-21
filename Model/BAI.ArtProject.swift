import SwiftUI

class ArtProject : ObservableObject, Codable {

    private enum CodingKeys: String, CodingKey {
        case source, canvases, sheets
    }
    
    // art data
    @Published var source: ArtSource
    @Published var canvases: Canvases 
    
    // states
    @Published var sheets: SheetsState
    

    init() {
        source = ArtSource()
        canvases = Canvases()
        sheets = SheetsState()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        source = try container.decode(ArtSource.self, forKey: CodingKeys.source)
        canvases = try container.decode(Canvases.self, forKey: CodingKeys.canvases)

        sheets = try container.decode(SheetsState.self, forKey: CodingKeys.sheets)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(source, forKey: CodingKeys.source)
        try container.encode(canvases, forKey: CodingKeys.canvases)

        try container.encode(sheets, forKey: CodingKeys.sheets)        
    }
    
}
