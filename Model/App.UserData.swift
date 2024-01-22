import SwiftUI

public struct IO {
    public static let keyLastCanvases: String = "lastCanvases";
    public static let keyLastSource: String = "lastSource";    
    public static let keyLastState: String = "lastSource";
    public static let keyShowSplash: String = "lastShowSplash";
    
    public static let keyInventory: String = "userInventory";
    
    public static let keyInventoryBase: String = "userInventory_";
}

public struct UserData {
    
    
    public static func set(_ value: String, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    public static func set(_ value: Bool, forKey: String) {
        UserDefaults.standard.set(value, forKey: forKey)
    }
    public static func string(forKey: String, _ defaultTo: String = "") -> String {
        return UserDefaults.standard.string(forKey: forKey) ?? defaultTo
    }
    public static func bool(forKey: String, _ defaultTo: Bool = false) -> Bool {
        return UserDefaults.standard.bool(forKey: forKey)
    }
    
}
