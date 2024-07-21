//
//  AppService.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import SwiftUI

@MainActor
protocol AppService: AnyObject, ObservableObject {
    var requestService: RequestService { get set }
}


final class AuroraTraceAppService: AppService {
    @Published var requestService: RequestService = .init()
}

