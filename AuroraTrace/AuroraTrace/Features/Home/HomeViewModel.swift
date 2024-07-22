//
//  HomeViewModel.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import SwiftUI

final class HomeViewModel: ObservableObject {
    @Published var tableView: AuroraTableView.AuroraTableViewModel
    private var messageProcesssingCase: MessageProcessingUseCase
    
    init(tableView: AuroraTableView.AuroraTableViewModel,
         messageProcesssingCase: MessageProcessingUseCase) {
        self.tableView = tableView
        self.messageProcesssingCase = messageProcesssingCase
    }
    
    func initialize() {
        
        messageProcesssingCase
            .suscribe { [weak self] request in
                guard let self = self else { return}
                self.tableView.items.append(request.transform())
                
            }.execute()
    }
    
    deinit {
        messageProcesssingCase.stop()
    }
}
