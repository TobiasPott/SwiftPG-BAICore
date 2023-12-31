import SwiftUI

struct RootView: View {
    public static let anyEmpty: AnyView = AnyView(EmptyView())
    public static let anySpacer: AnyView = AnyView(Spacer())
    
    @StateObject var state: AppState = AppState();
    @State var canvases: Canvases = Canvases();
    
    @StateObject var source: ArtSource = ArtSource();
    @StateObject var load: LoadInfo = LoadInfo(3, 3);
    
    var body: some View {
        ContentView(load: load, canvases: $canvases, source: source)
            .frame(alignment: Alignment.topLeading)     
            .environmentObject(state)   
        
    }    
}
