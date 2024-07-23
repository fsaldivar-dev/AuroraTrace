//
//  SocketRepositoryDelegate.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation
protocol SocketRepositoryDelegate: AnyObject {
    
    @MainActor
    func didReceiveMessage(_ message: Data) async
}
