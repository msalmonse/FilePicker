//
//  FilePickerController.swift
//  
//
//  Created by Michael Salmon on 2019-09-22.
//

import Foundation
import SwiftUI
import UIKit

// wrapper for UIDocumentPickerViewController

@available(iOS 13.0, *)
public struct FilePickerController: UIViewControllerRepresentable {
    @ObservedObject
    public var state: FilePickerState

    public func makeCoordinator() -> FilePickerController.Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(
            documentTypes: state.documentTypes,
            in: state.pickerMode
        )
        controller.delegate = context.coordinator

        return controller
    }

    public func updateUIViewController(
        _ controller: UIDocumentPickerViewController,
        context: Context
    ) {
        return
    }

    public class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePickerController

        init(_ controller: FilePickerController) {
            self.parent = controller
        }

        public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.state.urls = nil
        }

        public func documentPicker(
            _ controller: UIDocumentPickerViewController,
            didPickDocumentsAt urls: [URL]
        ) {
            parent.state.urls = urls
        }
    }
}
