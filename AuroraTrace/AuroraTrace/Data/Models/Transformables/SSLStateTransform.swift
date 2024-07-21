//
//  SSLStateTransformable.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
struct SSLStateTransform: Transformable {
    typealias InputType = String
    typealias OutputType = SSLState
    
    static func transform(_ input: String) -> SSLState {
        .init(rawValue: input) ?? .uknow
    }
}

extension String {
    func transform() -> SSLState {
        return SSLStateTransform.transform(self)
    }
}
