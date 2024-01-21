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
    
    @Published var userMode: UserMode = UserMode.simple;   
    @Published var navState: NavState = NavState.load;
    
    @Published var builtInPalette: BuiltInPalette = BuiltInPalette.legoReduced
    @Published var palette: Palette = ArtPalette.reduced
    @Published var inventory: ArtInventory = UserData.inventory
    @Published var canvas: ArtCanvas? = nil;
    
    
    @Published var drag: DragInfo = DragInfo();
    @Published var zoom: ZoomInfo = ZoomInfo(scale: Defaults.zoomScaleArt, lastScale: Defaults.zoomScaleArt);
    
    @Published var brickOutline: BrickOutlineMode = BrickOutlineMode.outlined;
    @Published var brickZoom: ZoomInfo = ZoomInfo(scale: 0.75, lastScale: 0.75);
    @Published var brickDrag: DragInfo = DragInfo();
    
    init() {
        
    }
    
    func setNavState(_ newNavState: NavState, _ keepCanvas: Bool = true) -> Void {
        if (self.navState != newNavState) {
            self.navState = newNavState;
            if (!keepCanvas) { 
                self.canvas = nil;
            }
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
        drag.enabled = true;
        zoom.enabled = true;
        
        canvas = nil;
        navState = NavState.load
    }
}
