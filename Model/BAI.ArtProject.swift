import SwiftUI


class ArtProject : ObservableObject //, Identifiable, Codable
{
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
    
}
