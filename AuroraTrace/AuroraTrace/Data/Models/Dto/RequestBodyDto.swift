//
//  RequestBodyDto.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import Foundation

enum RequestBodyDto: Codable {
    case dictionary([String: AnyCodable])
    case array([String])
    case string(String)
    case data(Data)
    case empty
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if container.decodeNil() {
            self = .empty
        } else if let dictionary = try? container.decode([String: AnyCodable].self) {
            self = .dictionary(dictionary)
        } else if let array = try? container.decode([String].self) {
            self = .array(array)
        } else if let string = try? container.decode(String.self) {
            self = .string(string)
        } else if let data = try? container.decode(Data.self) {
            self = .data(data)
        } else {
            self = .empty
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        
        switch self {
        case .dictionary(let dictionary):
            try container.encode(dictionary)
        case .array(let array):
            try container.encode(array)
        case .string(let string):
            try container.encode(string)
        case .data(let data):
            try container.encode(data)
        case .empty:
            try container.encodeNil()
        }
    }
}

