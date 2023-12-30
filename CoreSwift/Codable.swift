import SwiftUI

extension Encodable {
    func asJSONString() -> String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted;
        jsonEncoder.dataEncodingStrategy = .base64;
        let jsonResultData = try! jsonEncoder.encode(self)
        let jsonString = String(data: jsonResultData, encoding: .utf8)
        return jsonString ?? "";
    }
}

extension Decodable {
    init(jsonData: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }
}
