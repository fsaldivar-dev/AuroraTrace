//
//  SocketMessageDto.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
struct SocketMessageDto: Decodable {
    @DynamicSerialized(items: HttpRequestDto.self)
    private(set) var content: DynamicDecodable!
}
