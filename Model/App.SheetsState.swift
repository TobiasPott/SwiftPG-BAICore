import SwiftUI

class SheetsState : ObservableObject {
    
    @Published public var preferences: Bool = false;
    @Published public var samples: Bool = false;
    @Published public var about: Bool = false;
    @Published public var sourceCode: Bool = false;
    @Published public var feedback: Bool = false;
}
