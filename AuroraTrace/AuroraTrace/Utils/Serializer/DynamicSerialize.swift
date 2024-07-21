//
//  DynamicSerialize.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation

enum DynamicDecodableError: LocalizedError {
    case notRegister(String)
    case notDecoding(String, Error)
    case errorParse(Decodable.Type, Decodable)
    var errorDescription: String? {
        switch self {
        case .notRegister(let decodable):
            return "Objetct \(String(describing: decodable)) not register "
        case .notDecoding(let decodable, let error):
            return "Objetct \(String(describing: decodable)) not register \n desc: \(error.localizedDescription)"
        case .errorParse(let from, let to):
            return "Error in parse function, \(from) not is \(to)"
        }
    }
}

class DynamicDecodable: Decodable {
    private static var registry: [String: Decodable.Type] = [:]
    var type: String
    var value: Decodable
    
    static func register<T: Decodable>(decodableType: T.Type) {
        let key = String(describing: decodableType)
        registry[key] = decodableType
    }
    
    required init(from decoder: Decoder) throws {
        print("Starting to decode DynamicDecodable")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let typeKey = try container.decode(String.self, forKey: .type)
        
        guard let type = DynamicDecodable.registry[typeKey] else {
            throw DecodingError.dataCorruptedError(forKey: .type, in: container, debugDescription: "Unknown type key: \(typeKey)")
        }
        self.type = typeKey
        value = try type.init(from: decoder)

        print("Finished decoding DynamicDecodable")
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case value
    }
}


extension DynamicDecodable {
    func cast<T: Decodable>(to type: T.Type = T.self) throws -> T {
        guard let castedValue = self.value as? T else {
            throw DynamicDecodableError.errorParse(type, self.value)
        }
        return castedValue
    }
}

@propertyWrapper
struct SerializedArray: Decodable {
    var wrappedValue: [DynamicDecodable] = []
    
    init(items: Decodable.Type ...) {
        for item in items {
            DynamicDecodable.register(decodableType: item)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode([DynamicDecodable].self)
    }
}

@propertyWrapper
struct DynamicSerialized: Decodable {
    var wrappedValue: DynamicDecodable!
    
    init(items: Decodable.Type ...) {
        for item in items {
            DynamicDecodable.register(decodableType: item)
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(DynamicDecodable.self)
    }
}
