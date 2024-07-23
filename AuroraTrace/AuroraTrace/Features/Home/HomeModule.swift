//
//  HomeModule.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import SwiftUI

struct HomeModule {
    
    static func build() -> any View {
        do {
            let auroraBridgeSocketRepository = try AuroraBridgeSocketRepository()
            let messageProcesssingCase = MessageProcessingUseCase(socketRepository: auroraBridgeSocketRepository)
            let homeViewModel = HomeViewModel(tableView: .init(), messageProcesssingCase: messageProcesssingCase)
            return HomeView(model: homeViewModel)
        } catch {
            print(error.localizedDescription)
        }
        return EmptyView()
    }
}
