//
//  TimeIntervalTransform.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation

struct TimeIntervalTransform: Transformable {
    typealias InputType = String
    typealias OutputType = TimeInterval
    
    static func transform(_ input: String) -> TimeInterval {
        return TimeInterval(input) ?? 0
    }
}

extension String {
    func transform() -> TimeInterval {
        return TimeIntervalTransform.transform(self)
    }
}
