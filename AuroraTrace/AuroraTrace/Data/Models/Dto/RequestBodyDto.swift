//
//  RequestBodyDto.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import Foundation
enum RequestBodyDto: Codable {
    case dictionary([String: AnyCodable])
    case string(String)
    case data(Data)
    case empty

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let dict = try? container.decode([String: AnyCodable].self) {
            self = .dictionary(dict)
        } else if let str = try? container.decode(String.self) {
            self = .string(str)
        } else if let data = try? container.decode(Data.self) {
            self = .data(data)
        } else if container.decodeNil() {
            self = .empty
        } else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode request body")
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .dictionary(let dict):
            try container.encode(dict)
        case .string(let str):
            try container.encode(str)
        case .data(let data):
            try container.encode(data)
        case .empty:
            try container.encodeNil()
        }
    }
}
