//
//  AuroraBridgeSocketRepository.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
enum SocketRepositoryError: Error {
    case errorUncodingUTF8
}
class AuroraBridgeSocketRepository: SocketRepository {
    weak var delegate: SocketRepositoryDelegate?
    private let server: AuroraBridgeSocket
    
     init() throws {
        try self.server = .init()
    }

    func connect() {
        do {
            try server.start()
            server.receive { (status: ConnectionStatus) in
                print(status)
            }.receive { [weak self] (response: Result<Data, any Error>) in
                guard let self = self else {
                    return
                }
                do {
                    switch response {
                    case .success(let success):
                        
                        delegate?.didReceiveMessage(success)
                    case .failure(let failure):
                        print(failure)
                    }
                    
                } catch {
                    print(error)
                }
            }
        } catch {
            
        }
    }

    func disconnect() {
        server.stop()
    }

}
