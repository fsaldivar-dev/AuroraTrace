//
//  HttpRequestDto.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
struct HttpRequest {
    var id: String
    var method: String
    var url: String
    var path: String
    var headers: [String: String]
    var query: [String: String]
    var host: String
    var port: Int
    var scheme: String
    var body: RequestBody?
    var content: Data?
    var fullURL: String
    var timestampStart: TimeInterval
    var timestampEnd: TimeInterval
    var cookies: [String: String]
    var sslState: SSLState
}
