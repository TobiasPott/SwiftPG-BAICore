import SwiftUI

public struct ArtInventory : Identifiable, Hashable {
    
    public var id: String { name }
    public var name: String    
    public var items: [Item] = []
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    
    public struct Item : Codable, Identifiable, Hashable {
        public var id: String { name }
        public var name: String    
        
        public var total: Int
        public var used: Int
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(total)
            hasher.combine(used)
        }
    }
    
}
