import SwiftUI

struct RootView: View {
    public static let anyEmpty: AnyView = AnyView(EmptyView())
    public static let anySpacer: AnyView = AnyView(Spacer())
    
    @StateObject var state: GlobalState = GlobalState();
    @StateObject var load: LoadState = LoadState(3, 3);
    
    @StateObject var source: ArtSource = ArtSource();
    @State var canvases: Canvases = Canvases();
    
    var body: some View {
        ContentView(load: load, canvases: $canvases, source: source)
            .frame(alignment: Alignment.topLeading)     
            .ignoresSafeArea(.keyboard)
            .environmentObject(state)   
        
    }    
}
