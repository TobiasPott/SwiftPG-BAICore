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
    
    @Published var brickOutline: BrickOutlineMode = BrickOutlineMode.outlined;
    
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
        canvas = nil;
        navState = NavState.load
    }
}
