//
//  AuroraTableView.swift
//  AuroraTrace
//
//  Created by Saldivar on 21/07/24.
//

import AppKit
import SwiftUI

import SwiftUI
import AppKit

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

// MARK: - AuroraTableView
struct AuroraTableView: NSViewRepresentable {
    @Binding var model: AuroraTableViewModel

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeNSView(context: Context) -> NSScrollView {
            let scrollView = NSScrollView()
            let tableView = NSTableView()

            let columns: [(String, String, CGFloat)] = [
                ("ID", "id", 100),
                ("URL", "url", 300),
                ("Client", "client", 100),
                ("Method", "method", 80),
                ("Status", "status", 80),
                ("Code", "code", 80),
                ("Time", "time", 120),
                ("Duration", "duration", 100),
                ("SSL", "ssl", 60)
            ]

            for (title, identifier, width) in columns {
                let column = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(identifier))
                column.title = title
                column.width = width
                column.minWidth = 50
                column.maxWidth = 1000
                column.isEditable = false
                tableView.addTableColumn(column)
            }

            tableView.columnAutoresizingStyle = .sequentialColumnAutoresizingStyle
            tableView.usesAutomaticRowHeights = true
            tableView.style = .fullWidth

            tableView.dataSource = context.coordinator
            tableView.delegate = context.coordinator

            scrollView.documentView = tableView
            scrollView.hasVerticalScroller = true
            
            tableView.wantsLayer = true
            tableView.layer?.isOpaque = true

            context.coordinator.tableView = tableView
            return scrollView
        }

    
    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let tableView = nsView.documentView as? NSTableView else { return }
        
        if context.coordinator.model != model {
            context.coordinator.model = model
            tableView.reloadData()
            
            if context.coordinator.shouldScrollToBottom {
                scrollToBottom(scrollView: nsView)
                context.coordinator.shouldScrollToBottom = false
            }
        }
    }
    
    private func scrollToBottom(scrollView: NSScrollView) {
        guard let documentView = scrollView.documentView else { return }
        let newOrigin = NSPoint(x: 0, y: max(0, documentView.frame.height - scrollView.contentSize.height))
        documentView.scroll(newOrigin)
    }

    // MARK: - Coordinator
    class Coordinator: NSObject, NSTableViewDataSource, NSTableViewDelegate {
        var parent: AuroraTableView
        var tableView: NSTableView!
        var model: AuroraTableViewModel
        var shouldScrollToBottom = false

        init(_ parent: AuroraTableView) {
            self.parent = parent
            self.model = parent.model
        }

        func numberOfRows(in tableView: NSTableView) -> Int {
            return model.items.count
        }

        func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
                    guard let tableColumn = tableColumn else { return nil }
                    let item = model.items[row]
                    
                    let text: String = {
                        switch tableColumn.identifier.rawValue {
                        case "id": return String(row)
                        case "url": return item.url
                        case "client": return item.client.isEmpty ? "Unknown" : item.client
                        case "method": return item.method
                        case "status": return item.status
                        case "code": return item.code
                        case "time": return item.time
                        case "duration": return item.duration
                        case "ssl": return item.ssl
                        default: return ""
                        }
                    }()

                    let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "Cell")
                    let cell: NSTextField
                    if let existingCell = tableView.makeView(withIdentifier: cellIdentifier, owner: nil) as? NSTextField {
                        cell = existingCell
                    } else {
                        cell = NSTextField(wrappingLabelWithString: "")
                        cell.identifier = cellIdentifier
                        cell.isEditable = false
                        cell.drawsBackground = false
                        cell.isBordered = false
                        cell.maximumNumberOfLines = 2
                        cell.lineBreakMode = .byTruncatingTail
                        cell.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
                    }
                    cell.stringValue = text
                    return cell
                }

        func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
            return 40 // Adjust this value as needed
        }
    }
}

// MARK: - ViewModel
class AuroraTableViewModel: ObservableObject {
    @Published var tableView = AuroraTableView.AuroraTableViewModel()
    
    func addItem(_ item: AuroraTableView.AuroraTableRowModel) {
        DispatchQueue.main.async {
            self.tableView.items.append(item)
            NotificationCenter.default.post(name: .scrollToBottom, object: nil)
        }
    }
}

extension Notification.Name {
    static let scrollToBottom = Notification.Name("scrollToBottom")
}
