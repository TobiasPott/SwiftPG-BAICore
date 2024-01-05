import SwiftUI

public struct Filters : Codable {
    
    private enum CodingKeys: String, CodingKey {
        case items
    }
    
    public var items: [Filter];
    
    public var count: Int { items.count }
    
    public init() {
        items = []
    }
    public init(_ initItems: [Filter]) {
        items = []
        items.append(contentsOf: initItems);
    }
    
    public subscript (index: Int) -> Filter {
        get { return items[index] }
        set(value) { items[index] = value }
    }
    public mutating func append(_ newElement: Filter) {
        self.items.append(newElement)
    }
    public mutating func append(other: Filters) {
        self.items.append(contentsOf: other.items)
    }
    public mutating func remove(at: Int) {
        self.items.remove(at: at)
    }
    public mutating func remove(atOffsets: IndexSet) {
        self.items.remove(atOffsets: atOffsets)
    }
    public mutating func reset() {
        items = []
    }
    
}
