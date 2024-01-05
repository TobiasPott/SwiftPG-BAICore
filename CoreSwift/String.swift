import SwiftUI

extension String {
    
    func decode<T>(model: T.Type) throws -> Decodable where T: Decodable  {
        let data = Data(self.utf8)
        let decodableType = model as Decodable.Type;
        if let myStruct = try? decodableType.fromJson(jsonData: data) {
            return myStruct
        } else {
            throw JSONDecodingError.decodeFailed
        }
    }
}
enum JSONDecodingError: Error {
    case decodeFailed
}
