//
//  NativeTextArea.swift
//  AuroraTrace
//
//  Created by Saldivar on 20/07/24.
//

import SwiftUI
import AppKit
#Preview(body: {
    NativeTextArea.init(text: .constant(""), placeholder: "Place")
})
import SwiftUI
import AppKit

struct NativeTextArea: NSViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var isEditable: Bool = true

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSScrollView()
        let textView = NSTextView()
        
        textView.isEditable = isEditable
        textView.isSelectable = true
        textView.allowsUndo = true
        textView.font = NSFont.systemFont(ofSize: NSFont.systemFontSize)
        textView.textColor = NSColor.textColor
        textView.delegate = context.coordinator
        
        scrollView.documentView = textView
        scrollView.hasVerticalScroller = true
        scrollView.hasHorizontalScroller = false
        
        return scrollView
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        guard let textView = nsView.documentView as? NSTextView else { return }
        
        if textView.string != text {
            textView.string = text
        }
        
        if text.isEmpty && textView.string.isEmpty {
            textView.string = placeholder
            textView.textColor = NSColor.placeholderTextColor
        } else if !text.isEmpty && textView.textColor == NSColor.placeholderTextColor {
            textView.textColor = NSColor.textColor
        }
        
        // Forzar el foco al textView
        DispatchQueue.main.async {
            nsView.window?.makeFirstResponder(textView)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: NativeTextArea

        init(_ parent: NativeTextArea) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            let newText = textView.string
            if newText != parent.placeholder {
                parent.text = newText
                textView.textColor = NSColor.textColor
            }
        }

        func textViewDidBeginEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            if textView.string == parent.placeholder {
                textView.string = ""
                textView.textColor = NSColor.textColor
            }
        }
    }
}
