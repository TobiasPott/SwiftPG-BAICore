import SwiftUI

class SheetsState : ObservableObject, Codable {
    
    enum CodingKeys: String, CodingKey {
        case splashScreen, preferences, samples, about, sourceCode, feedback
    }
    
    @Published public var splashScreen: Bool = false;
    @Published public var preferences: Bool = true;
    @Published public var samples: Bool = false;
    @Published public var about: Bool = false;
    @Published public var sourceCode: Bool = false;
    @Published public var feedback: Bool = false;
    
    init() {
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        splashScreen = try container.decode(Bool.self, forKey: CodingKeys.splashScreen)
        preferences = try container.decode(Bool.self, forKey: CodingKeys.preferences)
        samples = try container.decode(Bool.self, forKey: CodingKeys.samples)
        about = try container.decode(Bool.self, forKey: CodingKeys.about)
        sourceCode = try container.decode(Bool.self, forKey: CodingKeys.sourceCode)
        feedback = try container.decode(Bool.self, forKey: CodingKeys.feedback)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(splashScreen, forKey: CodingKeys.splashScreen)
        try container.encode(preferences, forKey: CodingKeys.preferences)
        try container.encode(samples, forKey: CodingKeys.samples)
        try container.encode(about, forKey: CodingKeys.about)
        try container.encode(sourceCode, forKey: CodingKeys.sourceCode)
        try container.encode(feedback, forKey: CodingKeys.feedback)
    }
    
}
