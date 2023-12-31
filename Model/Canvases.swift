import SwiftUI

struct Canvases : Codable {
    private enum CodingKeys: String, CodingKey {
        case items
    }
    
    var items: [ArtCanvas];
    
    
    init() {
        items = []
    }
    init(_ initItems: [ArtCanvas]) {
        items = []
        items.append(contentsOf: initItems);
    }
    
    subscript (index: Int) -> ArtCanvas {
        get { return items[index] }
        set(value) { items[index] = value }
    }
    mutating func append(_ newElement: ArtCanvas) {
        self.items.append(newElement)
    }
    mutating func append(other: Canvases) {
        self.items.append(contentsOf: other.items)
    }
    mutating func remove(at: Int) {
        self.items.remove(at: at)
    }
    mutating func remove(atOffsets: IndexSet) {
        self.items.remove(atOffsets: atOffsets)
    }
    mutating func reset(_ to: [ArtCanvas] = []) {
        items.removeAll()
        items.append(contentsOf: to)
    }
    mutating func reset(_ to: Canvases) {
        items.removeAll()
        items.append(contentsOf: to.items)
    }
    
}
