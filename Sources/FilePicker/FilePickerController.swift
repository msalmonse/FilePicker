//
//  FilePickerController.swift
//  
//
//  Created by Michael Salmon on 2019-09-22.
//

import Foundation
import Combine
import SwiftUI
import UIKit
import UniformTypeIdentifiers

@available(iOS 14.0, *)
public struct FilePickerController: UIViewControllerRepresentable {
    @ObservedObject
    var state: FilePickerState

    let doDismiss: (() -> Void)?

    /// Wrapper for UIDocumentPickerViewController
    /// - Parameter state: FilePickerState - parameters for UIDocumentPickerViewController
    /// - Parameter doDismiss: Optional closure to run to close the controller

    public init(_ state: FilePickerState, _ doDismiss: (() -> Void)? = nil) {
        self.state = state
        self.doDismiss = doDismiss
    }

    func dismiss() {
        state.directoryURL?.stopAccessingSecurityScopedResource()
        if doDismiss != nil { doDismiss!() }
    }

    public func makeCoordinator() -> FilePickerController.Coordinator {
        Coordinator(self)
    }

    public func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let controller = UIDocumentPickerViewController(
            forOpeningContentTypes: state.documentTypes,
            asCopy: state.copyContents
        )
        controller.delegate = context.coordinator
        controller.allowsMultipleSelection = state.allowsMultipleSelection
        _ = state.directoryURL?.startAccessingSecurityScopedResource()
        controller.directoryURL = state.directoryURL
        controller.shouldShowFileExtensions = state.shouldShowFileExtensions

        return controller
    }

    public func updateUIViewController(
        _ controller: UIDocumentPickerViewController,
        context: Context
    ) {
        controller.allowsMultipleSelection = state.allowsMultipleSelection
        controller.shouldShowFileExtensions = state.shouldShowFileExtensions
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
            if let url = urls.first {
                _ = url.startAccessingSecurityScopedResource()
                parent.state.urlPublisher.send(url)
            }
            parent.dismiss()
        }
    }
}
