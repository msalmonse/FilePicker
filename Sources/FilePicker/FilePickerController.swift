//
//  FilePickerController.swift
//  
//
//  Created by Michael Salmon on 2019-09-22.
//

import Foundation

#if canImport(UIKit)
import SwiftUI
import UIKit

// wrapper for UIDocumentPickerViewController

struct FilePickerController: UIViewControllerRepresentable {
    @ObservedObject
    var state: FilePickerState

    func makeCoordinator() -> FilePickerController.Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(
            documentTypes: state.documentTypes,
            in: state.pickerMode
        )
        controller.delegate = context.coordinator

        return controller
    }

    func updateUIViewController(
        _ controller: UIDocumentPickerViewController,
        context: Context
    ) {
        return
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePickerController

        init(_ controller: FilePickerController) {
            self.parent = controller
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.state.urls = nil
        }

        func documentPicker(
            _ controller: UIDocumentPickerViewController,
            didPickDocumentsAt urls: [URL]
        ) {
            parent.state.urls = urls
        }
    }
}

#endif
