//
//  RequestBody.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import Foundation
enum RequestBody: Codable {
    case dictionary([String: AnyCodable])
    case string(String)
    case data(Data)
    case empty
    
}
