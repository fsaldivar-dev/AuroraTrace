//
//  MessageProcessingUseCase.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
final class MessageProcessingUseCase {
    private var socketRepository: SocketRepository
    private var httpRequestCallBacks: [@MainActor (HttpRequest) async -> Void] = []
    
    init(socketRepository: SocketRepository) {
        self.socketRepository = socketRepository
        self.socketRepository.delegate = self
    }
    
    @discardableResult
    func execute() -> Self {
        socketRepository.connect()
        return self
    }
    
    @discardableResult
    func suscribe(on complete: @escaping (HttpRequest) -> Void) -> Self {
        httpRequestCallBacks.append(complete)
        return self
    }
    
    func stop() {
        socketRepository.disconnect()
    }
}

extension MessageProcessingUseCase: SocketRepositoryDelegate {
    
    @MainActor
    func didReceiveMessage(_ message: Data) async {
        print("Received update: \(message)")
        
        do {
            let socketMessage: SocketMessageDto = try .from(data: message)
            switch socketMessage.content.value {
            case let request as HttpRequestDto:
                for item in httpRequestCallBacks {
                    await item(request.transform())
                }
                break
            default:
                break
            }
            
        } catch {
            print("Error Message Invalid: \(message)")
        }
    }
}

