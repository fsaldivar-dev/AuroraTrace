//
//  SocketMessage.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
struct SocketMessage {
    var messageType: SocketMessageType
    var content: DynamicDecodable
}
