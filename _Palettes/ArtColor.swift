import SwiftUI

public struct ArtColor : Identifiable, Hashable {
    public var id: String { name }
    public var name: String    
    public var color: MultiColor
    
    public var swuiColor: Color { color.swuiColor }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
}
