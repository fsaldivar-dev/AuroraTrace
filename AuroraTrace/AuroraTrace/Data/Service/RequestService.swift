//
//  RequestService.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import Foundation

@MainActor
final class RequestService: ObservableObject {
    @Published var request: [HttpRequest] = []
}
