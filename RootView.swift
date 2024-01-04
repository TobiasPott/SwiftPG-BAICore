import SwiftUI

struct RootView: View {
    public static let anyEmpty: AnyView = AnyView(EmptyView())
    public static let anySpacer: AnyView = AnyView(Spacer())
    
    @StateObject var state: GlobalState = GlobalState();
    @StateObject var sheets: SheetsState = SheetsState();
    @StateObject var load: LoadState = LoadState(3, 3);
    
    @StateObject var source: ArtSource = ArtSource();
    @State var canvases: Canvases = Canvases();
    
    var body: some View {
        GeometryReader { geometry in
            let isLandscape: Bool = (geometry.size.width / geometry.size.height) > 1       
            ContentView(load: load, canvases: $canvases, source: source, isWide: isLandscape)
                .frame(alignment: Alignment.topLeading)     
                .ignoresSafeArea(SafeAreaRegions.keyboard)
                .environmentObject(state)   
                .environmentObject(sheets)   
        }
    }    
}
