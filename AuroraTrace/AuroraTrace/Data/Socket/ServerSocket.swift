//
//  ServerSocketContract.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation

protocol ServerSocket: AnyObject {
    init(port: UInt16) throws
    var isRunning: Bool { get }
    func start() throws
    func stop()
    func receive(message completion: @MainActor @escaping (Result<Data, any Error>) async -> Void) -> Self
    func send(message data: @escaping () -> Data)
    func receive(status completion: ((ConnectionStatus) -> Void)?) -> Self
}

enum ConnectionStatus {
    case disconnected
    case connecting
    case connected
    case error(Error)
}
