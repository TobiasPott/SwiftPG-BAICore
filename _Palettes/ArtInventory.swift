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
        
        public var quantity: Int
        
        public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(quantity)
        }
    }
}

public extension ArtInventory.Item {
    
    init(_ name: String, _ quantity: Int) {
        self.name = name;
        self.quantity = quantity;
    }
}
