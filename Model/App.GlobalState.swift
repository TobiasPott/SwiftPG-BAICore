import SwiftUI

public enum NavState: Int, Equatable, Codable {
    case load, setup, analysis
}
public enum UserMode: Int, Equatable, Codable {
    case guided, simple, advanced
}
public enum BrickOutlineMode: Int {
    case none, outlined
}

class GlobalState : ObservableObject
{
    @Published var showSplashScreen: Bool = true;
    @Published var showProgress: Bool = false;
    @Published var userMode: UserMode = UserMode.simple;   
    @Published var navState: NavState = NavState.load;
    @Published var prevNavState: NavState = NavState.load;
    
    @Published var builtInPalette: BuiltInPalette = BuiltInPalette.legoReduced
    @Published var palette: Palette = ArtPalette.reduced
    @Published var inventory: ArtInventory = UserData.inventory
    @Published var canvas: ArtCanvas? = nil;
    
    @Published public var srcDragLocked: Bool = false;
    @Published public var srcZoomLocked: Bool = false;
    @Published var drag: DragInfo = DragInfo();
    @Published var zoom: ZoomInfo = ZoomInfo(scale: 30.0, lastScale: 30.0);
    
    @Published var brickOutline: BrickOutlineMode = BrickOutlineMode.outlined;
    @Published var brickZoom: ZoomInfo = ZoomInfo(scale: 0.75, lastScale: 0.75);
    @Published var brickDrag: DragInfo = DragInfo();
    
    
    
    init() {
        
    }
    
    func setNavState(_ newNavState: NavState, _ keepCanvas: Bool = true) -> Void {
        if (self.navState != newNavState) {
            self.prevNavState = self.navState
            self.navState = newNavState;
            if (!keepCanvas) { 
                self.canvas = nil;
            }
        }
    }
    func isNavState(_ state: NavState) -> Bool {
        return self.navState == state;
    }
    func wasNavState(_ state: NavState) -> Bool {
        return self.prevNavState == state;
    }
    func isNavState(_ states: [NavState]) -> Bool {
        return states.contains(where: { state in
            return state == self.navState
        })
    }
    func wasNavState(_ states: [NavState]) -> Bool {
        return states.contains(where: { state in
            return state == self.prevNavState
        })
    }
    
    func reset() {
        drag = DragInfo()
        zoom = ZoomInfo()
        srcDragLocked = false;
        srcZoomLocked = false;
        
        canvas = nil;
        navState = NavState.load
    }
}
