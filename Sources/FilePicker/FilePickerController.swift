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

    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    func dismiss() { mode.wrappedValue.dismiss() }

    public init(_ state: FilePickerState) {
        self.state = state
    }

    public func makeCoordinator() -> FilePickerController.Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(
            documentTypes: state.documentTypes,
            in: state.pickerMode
        )
        controller.delegate = context.coordinator
        controller.allowsMultipleSelection = state.allowsMultipleSelection
        controller.directoryURL = state.directoryURL

        return controller
    }

    public func updateUIViewController(
        _ controller: UIDocumentPickerViewController,
        context: Context
    ) {
        controller.allowsMultipleSelection = state.allowsMultipleSelection
        return
    }

    public class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: FilePickerController

        init(_ controller: FilePickerController) {
            self.parent = controller
        }

        public func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.state.urls = nil
            parent.dismiss()
        }

        public func documentPicker(
            _ controller: UIDocumentPickerViewController,
            didPickDocumentsAt urls: [URL]
        ) {
            parent.state.urls = urls
            parent.dismiss()
        }
    }
}
