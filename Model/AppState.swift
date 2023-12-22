import SwiftUI
import SwiftPG_Palettes


public enum NavState: Equatable, Codable {
    case load, setup, analysis
}
public enum UserMode: Equatable, Codable {
    case guided, simple, advanced
}
class AppState : ObservableObject
{
    @Published var showSplashScreen: Bool = true;
    @Published var userMode: UserMode = .simple;   
    @Published var navState: NavState = .load;

    @Published var builtInPalette: BuiltInPalette = .legoSimple
    @Published var palette: Palette = Lego.simple
    
    
    @Published var canvas: CanvasInfo? = nil;
    
    @Published public var srcDragLocked: Bool = false;
    @Published public var srcZoomLocked: Bool = false;
    @Published var drag: DragInfo = DragInfo();
    @Published var zoom: ZoomInfo = ZoomInfo(scale: 30, lastScale: 30);

    
    init() {
        
    }
    
    func setNavState(_ newNavState: NavState, _ keepCanvas: Bool = true) -> Void {
        self.navState = newNavState;
        if (!keepCanvas) { 
            self.canvas = nil;
        }
    }
    func isNavState(_ state: NavState) -> Bool {
        return self.navState == state;
    }
    func isNavState(_ states: [NavState]) -> Bool {
        return states.contains(where: { state in
            return state == self.navState
        })
    }
    
    func reset() {
        drag = DragInfo()
        zoom = ZoomInfo()
        srcDragLocked = false;
        srcZoomLocked = false;
        
        canvas = nil;
        navState = .load
    }
}
