//
//  AuroraTableView.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import AppKit
import SwiftUI

// MARK: - Model Definitions
extension AuroraTableView {
    struct AuroraTableViewModel: Equatable {
        var items: [AuroraTableRowModel] = []
    }
    
    struct AuroraTableRowModel: Identifiable, Equatable {
        let id: String
        let url: String
        let client: String
        let method: String
        let status: String
        let code: String
        let time: String
        let duration: String
        let ssl: String
    }
}

extension String {
    func contains(of str: String) -> Bool {
        self.lowercased().contains(str.lowercased())
    }
}

struct AuroraTableView: View {
    @Binding var viewModel: AuroraTableView.AuroraTableViewModel
    @State private var scrollTarget: String?
    @State private var selection: String? = nil
    @State private var filterText: String = ""

    var filteredItems: [AuroraTableView.AuroraTableRowModel] {
        if filterText.isEmpty {
            return viewModel.items
        } else {
            return viewModel.items.filter { $0.url.contains(of: filterText) || $0.client.contains(of: filterText) || $0.method.contains(of: filterText) || $0.status.contains(of: filterText) || $0.code.contains(of: filterText) || $0.time.contains(of: filterText) || $0.duration.contains(of: filterText) || $0.ssl.contains(of: filterText) }
        }
    }

    var body: some View {
        VStack {
            TextField("Filter", text: $filterText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            GeometryReader { contentProxy in
                ScrollViewReader { proxy in
                    ScrollView {
                        Table(filteredItems, selection: $selection) {
                            TableColumn("URL", value: \.url)
                            TableColumn("Client", value: \.client)
                            TableColumn("Method", value: \.method)
                            TableColumn("Status", value: \.status)
                            TableColumn("Code", value: \.code)
                            TableColumn("Time", value: \.time)
                            TableColumn("Duration", value: \.duration)
                            TableColumn("SSL", value: \.ssl)
                        }
                        .frame(height: contentProxy.size.height)
                        .onChange(of: viewModel.items) { old, newItems in
                            if let lastId = newItems.last?.id, selection == nil {
                                scrollTarget = lastId
                            }
                        }
                    }
                    .onChange(of: scrollTarget) { old, target in
                        if let target = target {
                            withAnimation {
                                proxy.scrollTo(target, anchor: .bottomLeading)
                            }
                        }
                    }
                }
            }
        }
    }
}

