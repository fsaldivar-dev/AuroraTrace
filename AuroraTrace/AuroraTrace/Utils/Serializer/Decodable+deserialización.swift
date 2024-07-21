//
//  Decodable+deserialización.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation

import Foundation

enum DecodableError: Error {
    case notParrse
}

extension Decodable {
    /// Decodes an instance of the conforming type from a JSON string.
    /// - Parameter jsonString: The JSON string to decode.
    /// - Returns: An instance of the conforming type.
    /// - Throws: An error if the decoding process fails.
    ///
    static func from(jsonString: String) throws -> Self {
        
        guard let jsonData = jsonString.removingEscapes().data(using: .utf8) else {
            throw NSError(domain: "Invalid JSON string", code: -1, userInfo: nil)
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Self.self, from: jsonData)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.dataCorrupted(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.keyNotFound(key, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.typeMismatch(type, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.valueNotFound(value, context)
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw error
        }
    }
    
    
    static func from(data: Data) throws -> Self {
        
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(Self.self, from: data)
        } catch let DecodingError.dataCorrupted(context) {
            print("Data corrupted: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.dataCorrupted(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.keyNotFound(key, context)
        } catch let DecodingError.typeMismatch(type, context) {
            print("Type '\(type)' mismatch: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.typeMismatch(type, context)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found: \(context.debugDescription)")
            print("CodingPath: \(context.codingPath)")
            throw DecodingError.valueNotFound(value, context)
        } catch {
            print("Decoding error: \(error.localizedDescription)")
            throw error
        }
    }
}

extension String {
    func removingEscapes() -> String {
        var unescapedString = self.replacingOccurrences(of: "\\\"", with: "\"")
        unescapedString = unescapedString.replacingOccurrences(of: "\\n", with: "\n")
        unescapedString = unescapedString.replacingOccurrences(of: "\\", with: "")
        return unescapedString
    }
}
