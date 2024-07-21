//
//  HttpRequestDto.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
struct HttpRequest {
    let method: String
    let url: String
    let path: String
    let headers: [String: String]
    let query: [String: String]
    let host: String
    let port: Int
    let scheme: String
    let body: RequestBody?
    let content: Data?
    let fullURL: String
    let timestampStart: TimeInterval
    let timestampEnd: TimeInterval
    let cookies: [String: String]
    let sslState: SSLState
}
