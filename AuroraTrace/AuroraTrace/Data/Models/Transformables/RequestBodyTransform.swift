//
//  RequestBody.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import Foundation
struct RequestBodyTransform: Transformable {
    typealias InputType = RequestBodyDto
    
    typealias OutputType = RequestBody
    
    static func transform(_ input: RequestBodyDto) -> RequestBody {
        switch input {
        case .dictionary(let dictionary):
            return .dictionary(dictionary)
        case .string(let string):
            return .string(string)
        case .data(let data):
            return .data(data)
        case .empty:
            return .empty
        case .array(let array):
            return .array(array)
        }
    }
}

extension RequestBodyDto {
    func transfrom() -> RequestBody {
        RequestBodyTransform.transform(self)
    }
}
