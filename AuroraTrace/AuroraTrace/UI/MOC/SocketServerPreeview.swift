//
//  SocketServerPreeview.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import SwiftUI
import SwiftData

struct SocketServerPreeview: View {
    @ObservedObject private var model: SocketServerPreeviewModel = .init()
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationSplitView {
            List {
                NavigationLink(isActive: .constant(true)) {
                    VStack {
                        Text(model.messageStatus)
                            .frame(maxHeight: 100)
                        HSplitView {
                            List {
                                ForEach(model.message, id: \.self) {
                                    Text($0.description)
                                }
                            }
                            NativeTextArea(text: $model.response, placeholder: "", isEditable: true)
                        }
                    }
                    
                } label: {
                    Text("Socket Data preview")
                }
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        } detail: {
            Text("Welcome")
        }.onAppear(perform: {
            if !isLoading {
                model.start()
                isLoading.toggle()
            }
        })
    }
}


#Preview {
    SocketServerPreeview()
        .modelContainer(for: Item.self, inMemory: true)
}


final class SocketServerPreeviewModel: ObservableObject {
    @Published var messageStatus: String = ""
    @Published var message: [String] = ["1", "2"]
    @Published var response: String = "{\"Mock\": \"Messaje\"}"
    private var server: AuroraBridgeSocket!
    
    init() {
        do {
            self.server = try .init()
            messageStatus = "Socket Data preview"
        } catch {
            messageStatus = "Error concet Proxi"
        }
    }
    
    func start() {
        do {
            try server.start()
            server.receive { result in
                switch result {
                case .success(let data):
                    self.message.append(String(data: data, encoding: .utf8)!) 
                    break
                case .failure(let error):
                    break
                }
            }.send(message: {
                self.response.data(using: .utf8)!
            })
        } catch {
            
        }
    }
    
}
