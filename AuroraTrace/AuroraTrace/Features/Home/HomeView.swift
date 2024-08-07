//
//  HomeView.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import SwiftUI

struct HomeView: View {
    @StateObject var model: HomeViewModel
    @State var isLoading: Bool = false
    
    init(model: HomeViewModel) {
        self._model = StateObject.init(wrappedValue: model)
    }
    
    var body: some View {
        HSplitView(content: {      
            AuroraTableView(viewModel: $model.tableView)
        }).onAppear(perform: {
            if !isLoading {
                isLoading.toggle()
                model.initialize()
            }
        })
        
    }
    
}

#Preview {
    HomeView(model: .init(tableView: .init(),
                          messageProcesssingCase: .init(socketRepository: try! AuroraBridgeSocketRepository())))
}
