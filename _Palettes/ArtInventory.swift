import SwiftUI

public class ArtInventory: ObservableObject, Codable, Identifiable, Hashable {
    private enum CodingKeys: String, CodingKey {
        case name, items, isEditable
    }
    
    public static let empty: ArtInventory = ArtInventory(name: "Empty", items: [], isEditable: false)
    
    
    public var id: String { name }
    @Published public var name: String    
    @Published public var items: [Item]
    @Published public var isEditable: Bool = true
    
    init(name: String, items: [Item] = [], isEditable: Bool = true) {
        self.name = name
        self.items = items
        self.isEditable = isEditable
    }
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        items = try container.decode([Item].self, forKey: CodingKeys.items)
        isEditable = try container.decode(Bool.self, forKey: CodingKeys.isEditable)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: CodingKeys.name)
        try container.encode(items, forKey: CodingKeys.items)
        try container.encode(isEditable, forKey: CodingKeys.isEditable)
    }
    
    public static func ==(lhs: ArtInventory, rhs: ArtInventory) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public func contains(_ name: String) -> Bool {
        for i in 0..<items.count {
            if (items[i].name == name) { return true; }
        }
        return false;
    }
    public func load(_ from: ArtInventory) {
        name = from.name
        items.removeAll(keepingCapacity: false)
        items.append(contentsOf: from.items)
        isEditable = from.isEditable
    }
    public func load(_ from: Palette) {
        items.removeAll(keepingCapacity: true)
        for i in 0..<from.count {
            items.append(Item(from.artColors[i].name, 0))
        }
    }
    public func unload() {
        name = "Empty"
        items.removeAll(keepingCapacity: false)
        isEditable = false
    }
    public func add(_ from: ArtInventory) {
        for i in 0..<from.items.count {
            let fromItem = from.items[i]
            let index = items.firstIndex(of: Item(fromItem.name, 0)) ?? -1
            if (index >= 0) {
                items[index].quantity += fromItem.quantity
            } else {
                items.append(fromItem)
            }
            // ToDo: check why using a 'add' does not update UI when only changing quantities
        }
    }
    
    
    public struct Item : Codable, Identifiable, Hashable {
        private enum CodingKeys: String, CodingKey {
            case name, quantity
        }
        
        public var id: String { name }
        public var name: String    
        public var quantity: Int
        
        init(_ name: String, _ quantity: Int) {
            self.name = name;
            self.quantity = quantity;
        }   
        public func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(quantity)
        }
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            name = try container.decode(String.self, forKey: CodingKeys.name)
            quantity = try container.decode(Int.self, forKey: CodingKeys.quantity)
        }
        public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(name, forKey: CodingKeys.name)
            try container.encode(quantity, forKey: CodingKeys.quantity)
        }
        
        public static func ==(lhs: Item, rhs: Item) -> Bool {
            return lhs.id == rhs.id
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
//
//public extension ArtInventory.Item {
//    
//    convenience init(_ name: String, _ quantity: Int) {
//        
//        self.name = name;
//        self.quantity = quantity;
//    }   
//}

public extension Palette {
    func makeInventory() -> ArtInventory {
        let inventory = ArtInventory(name: "Inventory of \(self.name)")
        for i in 0..<self.artColors.count {
            inventory.items.append(ArtInventory.Item(self.artColors[i].name, 0))
        }
        return inventory
    }
}
