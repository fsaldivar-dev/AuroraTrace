//
//  SocketRepository.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation

protocol SocketRepository {
    var delegate: SocketRepositoryDelegate? { get set }
    func connect()
    func disconnect()
}
