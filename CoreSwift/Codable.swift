import SwiftUI

public extension Encodable {
    func asJSONString() -> String {
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = JSONEncoder.OutputFormatting.prettyPrinted;
        jsonEncoder.dataEncodingStrategy = JSONEncoder.DataEncodingStrategy.base64;
        let jsonResultData = try! jsonEncoder.encode(self)
        let jsonString = String(data: jsonResultData, encoding: String.Encoding.utf8)
        return jsonString ?? "";
    }
}

public extension Decodable {
    static func fromJson(jsonData: Data) throws -> Decodable {
//    init(jsonData: Data) throws {
        return try JSONDecoder().decode(Self.self, from: jsonData)
    }
}
