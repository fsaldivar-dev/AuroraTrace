//
//  AuroraBridgeSocket.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Network
import Foundation

final class AuroraBridgeSocket: ServerSocket {
    
    private let port: NWEndpoint.Port
    private let listener: NWListener
    private var onReceiveMessage: (@MainActor (Result<Data, any Error>) async -> Void)?
    private var onConnectionStatusChange: ((ConnectionStatus) -> Void)?
    private var getResponse: (() -> Data)?
    private var connections: [NWConnection] = []
    private let queue = DispatchQueue(label: "com.auroratrace.socket", qos: .utility)
    
    var isRunning: Bool = false
    
    init(port: UInt16 = 65432) throws {
        self.port = NWEndpoint.Port(rawValue: port)!
        self.listener = try NWListener(using: .tcp, on: self.port)
    }
    
    func start() throws {
        listener.newConnectionHandler = { [weak self] newConnection in
            guard let self = self else { return }
            self.handleNewConnection(newConnection)
        }
        listener.stateUpdateHandler = { [weak self] state in
            self?.handleListenerState(state)
        }
        listener.start(queue: queue)
        isRunning = true
        onConnectionStatusChange?(.connecting)
    }
    
    @discardableResult
    func receive(status completion: ((ConnectionStatus) -> Void)?) -> Self {
        onConnectionStatusChange = completion
        return self
    }
    
    @discardableResult
    func receive(message completion: @MainActor @escaping (Result<Data, any Error>) async -> Void) -> Self {
        onReceiveMessage = completion
        return self
    }
    
    func send(message data: @escaping () -> Data) {
        getResponse = data
    }
    
    func stop() {
        listener.cancel()
        connections.forEach { $0.cancel() }
        connections.removeAll()
        isRunning = false
        onConnectionStatusChange?(.disconnected)
    }
    
    private func handleNewConnection(_ connection: NWConnection) {
        connections.append(connection)
        connection.start(queue: queue)
        receive(on: connection)
    }
    
    private func handleListenerState(_ state: NWListener.State) {
        switch state {
        case .ready:
            print("Server listening on port \(port)")
            onConnectionStatusChange?(.connected)
        case .failed(let error):
            print("Server failed with error: \(error)")
            onConnectionStatusChange?(.error(error))
        default:
            break
        }
    }
    
    private func receive(on connection: NWConnection) {
        connection.receive(minimumIncompleteLength: 1, maximumLength: 65536) { [weak self] (data, _, isComplete, error) in
            Task(priority: .high) { [weak self] in
                guard let self = self else { return }
                if let data = data, !data.isEmpty {
                    await self.onReceiveMessage?(.success(data))
                    
                    self.sendResponse(to: connection, message: data)
                } else {
                    if let error = error {
                        await self.onReceiveMessage?(.failure(error))
                        connection.cancel()
                    } else if isComplete {
                        connection.cancel()
                    } else {
                        self.receive(on: connection)
                    }
                }
            }
            
        }
    }
    
    private func sendResponse(to connection: NWConnection, message: Data) {
        guard let data = getResponse?() else {
            connection.cancel()
            return
        }
        connection.send(content: data, completion: .contentProcessed({ error in
            if let error = error {
                print("Error sending response: \(error)")
                connection.cancel()
            } else {
                print("Response sent successfully")
                connection.cancel()
            }
        }))
    }
}
