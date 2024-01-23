import SwiftUI

public struct ArtInventory: Codable, Identifiable, Hashable {
    
    public var id: String { name }
    public var name: String    
    public var items: [Item] = []
    public var isEditable: Bool = true
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public func contains(_ name: String) -> Bool {
        for i in 0..<items.count {
            if (items[i].name == name) { return true; }
        }
        return false;
    }
    mutating public func load(_ from: Palette) {
        items.removeAll(keepingCapacity: true)
        for i in 0..<from.count {
            items.append(Item(from.artColors[i].name, 0))
        }
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
    
    
    public static func inventory(_ name: String) -> ArtInventory {
        let jsonData = Data(UserData.string(forKey: IO.keyInventoryBase + name, "{}").utf8)
        do {
            return try ArtInventory.fromJson(jsonData: jsonData) as! ArtInventory
        } catch {
            return inventory(IO.keyInventoryBase + name, inventory: ArtInventory(name: name))
        }
    }
    public static func inventory(_ name: String, inventory: ArtInventory) -> ArtInventory {
        UserData.set(inventory.asJSONString(), forKey: IO.keyInventoryBase + name)
        return inventory
    }
    
}

public extension ArtInventory.Item {
    
    init(_ name: String, _ quantity: Int) {
        self.name = name;
        self.quantity = quantity;
    }
}

public extension Palette {
    func makeInventory() -> ArtInventory {
        var inventory = ArtInventory(name: "Inventory of \(self.name)")
        for i in 0..<self.artColors.count {
            inventory.items.append(ArtInventory.Item(self.artColors[i].name, 0))
        }
        return inventory
    }
}
