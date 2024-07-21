//
//  RequestDto.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
                
struct HttpRequestDto: Codable {
    let method: String
    let url: String
    let path: String
    let headers: [String: String]
    let query: [String: String]
    let host: String
    let port: Int
    let scheme: String
    let body: RequestBodyDto
    let content: Data?
    let fullURL: String
    let timestampStart: String
    let timestampEnd: String
    let cookies: [String: String]
    let sslState: String

    enum CodingKeys: String, CodingKey {
        case method
        case url
        case path
        case headers
        case query
        case host
        case port
        case scheme
        case body
        case content
        case fullURL
        case timestampStart
        case timestampEnd
        case cookies
        case sslState = "ssl_state"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.method = try container.decode(String.self, forKey: .method)
        self.url = try container.decode(String.self, forKey: .url)
        self.path = try container.decode(String.self, forKey: .path)
        self.headers = try container.decode([String: String].self, forKey: .headers)
        self.query = try container.decode([String: String].self, forKey: .query)
        self.host = try container.decode(String.self, forKey: .host)
        self.port = try container.decode(Int.self, forKey: .port)
        self.scheme = try container.decode(String.self, forKey: .scheme)
        self.body = try container.decode(RequestBodyDto.self, forKey: .body)
        self.content = try? container.decodeIfPresent(Data.self, forKey: .content)
        self.fullURL = try container.decode(String.self, forKey: .fullURL)
        self.timestampStart = try container.decode(String.self, forKey: .timestampStart)
        self.timestampEnd = try container.decode(String.self, forKey: .timestampEnd)
        self.cookies = try container.decode([String: String].self, forKey: .cookies)
        self.sslState = try container.decode(String.self, forKey: .sslState)
    }
}
