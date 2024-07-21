//
//  SocketMessageTypeTranformable.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
struct SocketMessageTypeTransform: Transformable {
    typealias InputType = String
    typealias OutputType = SocketMessageType
    
    static func transform(_ input: String) -> SocketMessageType {
        .init(rawValue: input) ?? .none
    }
}

extension String {
    func transform() -> SocketMessageType {
        return SocketMessageTypeTransform.transform(self)
    }
}
