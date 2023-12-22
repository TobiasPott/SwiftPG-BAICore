import SwiftUI
import Foundation

public extension BinaryFloatingPoint {
    func clamped(to range: ClosedRange<Self>) -> Self {
        clamped(lowerBound: range.lowerBound, upperBound: range.upperBound)
    }
    
    func clamped(lowerBound: Self, upperBound: Self) -> Self {
        var copy = self
        copy.clamp(lowerBound: lowerBound, upperBound: upperBound)
        return copy
    }
    
    mutating func clamp(to range: ClosedRange<Self>) {
        clamp(lowerBound: range.lowerBound, upperBound: range.upperBound)
    }
    
    mutating func clamp(lowerBound: Self, upperBound: Self) {
        self = min(upperBound, max(lowerBound, self))
    }
}
public extension BinaryInteger {
    func clamped(to range: ClosedRange<Self>) -> Self {
        clamped(lowerBound: range.lowerBound, upperBound: range.upperBound)
    }
    
    func clamped(lowerBound: Self, upperBound: Self) -> Self {
        var copy = self
        copy.clamp(lowerBound: lowerBound, upperBound: upperBound)
        return copy
    }
    
    mutating func clamp(to range: ClosedRange<Self>) {
        clamp(lowerBound: range.lowerBound, upperBound: range.upperBound)
    }
    
    mutating func clamp(lowerBound: Self, upperBound: Self) {
        self = min(upperBound, max(lowerBound, self))
    }
}

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

extension String {
    
    func decode<T>(model: T.Type) throws -> Decodable where T: Decodable  {
        let data = Data(self.utf8)
        let decodableType = model as Decodable.Type;
        if let myStruct = try? decodableType.init(jsonData: data) {
            return myStruct
        } else {
            throw JSONDecodingError.decodeFailed
        }
    }
}

enum JSONDecodingError: Error {
    case decodeFailed
}
