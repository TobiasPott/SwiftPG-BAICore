import SwiftUI

public struct IO {
    public static let keyLastCanvases: String = "lastCanvases";
    public static let keyLastSource: String = "lastSource";    
    public static let keyLastState: String = "lastSource";
    public static let keyShowSplash: String = "lastShowSplash";
    
    public static let keyInventory: String = "userInventory";
}

public struct UserData {
    public static var lastCanvases: String {
        get { return UserData.string(forKey: IO.keyLastCanvases, "{}") }
        set { UserData.set(newValue, forKey: IO.keyLastCanvases) }
    }
    public static var lastSource: String {
        get { return UserData.string(forKey: IO.keyLastSource, "{}") }
        set { UserData.set(newValue, forKey: IO.keyLastSource) }
    }
    public static var inventory: ArtInventory {
        get { 
            let jsonData = Data(UserData.string(forKey: IO.keyInventory, "{}").utf8)
            do {
                return try ArtInventory.fromJson(jsonData: jsonData) as! ArtInventory
            } catch {
                return ArtInventory(name: "My Inventory")
            }
        }
        set { UserData.set(newValue.asJSONString(), forKey: IO.keyInventory) }
    }
    
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
