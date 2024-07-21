//
//  SocketMessageTranform.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
struct SocketMessageTranform: Transformable {
    typealias InputType = SocketMessageDto
    
    typealias OutputType = SocketMessage
    
    static func transform(_ input: SocketMessageDto) -> SocketMessage {
        fatalError("Disabled")
//        SocketMessage(messageType: input.messageType.transform(),
//                      content: input.content)
    }
}
