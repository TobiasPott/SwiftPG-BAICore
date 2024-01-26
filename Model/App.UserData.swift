import SwiftUI

public struct IO {
    public static let keyInventoriesSystem: String = "/sys/inventories";
    public static let keyInventoriesUser: String = "/usr/inventories";    
    public static let keyInventoryBase: String = "userInventory_";
    public static let keyActiveInventory: String = "/user/inventory/active";
}

public struct UserData {
    
    public static func activeInventory() -> String { return string(forKey: IO.keyActiveInventory, "Default") }
    public static func activeInventory(_ name: String) { set(name, forKey: IO.keyActiveInventory) }
    
    public static func userInventories() -> [String] { return stringArray(forKey: IO.keyInventoriesUser) }
    public static func userInventories(_ value: [String]) { set(value, forKey: IO.keyInventoriesUser) }
    
    public static func systemInventories() -> [String] { return stringArray(forKey: IO.keyInventoriesSystem) }
    public static func systemInventories(_ value: [String]) { set(value, forKey: IO.keyInventoriesSystem) }
    
    
    
    public static func set(_ value: String, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    public static func set(_ value: [String], forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    public static func set(_ value: Bool, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    public static func string(forKey: String, _ defaultTo: String = "") -> String {
        return UserDefaults.standard.string(forKey: forKey) ?? defaultTo
    }
    public static func stringArray(forKey: String, _ defaultTo: [String] = []) -> [String]  {
        return UserDefaults.standard.stringArray(forKey: forKey) ?? defaultTo
    }
    public static func bool(forKey: String) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
}
