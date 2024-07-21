//
//  MessageProcessingUseCase.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
final class MessageProcessingUseCase {
    private var socketRepository: SocketRepository
    
    init(socketRepository: SocketRepository) {
        self.socketRepository = socketRepository
        self.socketRepository.delegate = self
    }
    
    func execute() {
        socketRepository.connect()
    }

    func stop() {
        socketRepository.disconnect()
    }
}

extension MessageProcessingUseCase: SocketRepositoryDelegate {
    func didReceiveMessage(_ message: Data) {
        print("Received update: \(message)")
        
        do {
            let messageResponse: SocketMessageDto = try .from(data: message)
            print("Message result \(dump(messageResponse))")
        } catch {
            print("Error Message Invalid: \(message)")
        }
    }
}

