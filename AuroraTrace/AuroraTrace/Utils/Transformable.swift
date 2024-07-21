//
//  Transformable.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
protocol Transformable {
    associatedtype InputType
    associatedtype OutputType
    
    /// Transforms an object of type `InputType` to `OutputType`.
    /// - Parameter input: The object to be transformed.
    /// - Returns: The transformed object.
    static func transform(_ input: InputType) -> OutputType
}
