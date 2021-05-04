//
//  FilePickerState.swift
//  
//
//  Created by Michael Salmon on 2019-09-22.
//

import Foundation
import Combine
import UIKit
import MobileCoreServices

@available(iOS 13.0, *)
/// Container for parameters for FilePickerController()
public class FilePickerState: ObservableObject, Identifiable {
    public let id = UUID()     // swiftlint:disable:this identifier_name

    /// URL's selected by UIDocumentPickerViewController
    @Published
    public var urls: [URL]? {
        didSet { urlPublisher.send(urls?[0]) }
    }

    /// UTI's of documents we are interested in
    var documentTypes: [String] = []
    /// Mode for UIDocumentPickerViewController: import, open, export or move
    var pickerMode: UIDocumentPickerMode

    /// Allow multiple selections in UIDocumentPickerViewController
    @Published
    var allowsMultipleSelection = false
    /// Setter for allowsMultipleSelection
    /// - Parameter allow: new value for allowsMultipleSelection
    @discardableResult
    public func allowMultipleSelection(_ allow: Bool) -> FilePickerState {
        allowsMultipleSelection = allow
        return self
    }

    /// Optional start directory
    @Published
    var directoryURL: URL?

    /// Show file extensions in UIDocumentPickerViewController
    @Published
    var shouldShowFileExtensions = false
    /// Setter for shouldShowFileExtensions
    /// - Parameter show: new value for shouldShowFileExtensions
    @discardableResult
    public func showFileExtensions(_ show: Bool) -> FilePickerState {
        shouldShowFileExtensions = show
        return self
    }

    /// Publisher for the selected URL. It is the first URL if multiple URL's are allowed
    public let urlPublisher = PassthroughSubject<URL, Never>()

    /// Initializer for FilePickerState
    /// - Parameter directory: start directory
    /// - Parameter utis: initial value for documentTypes
    /// - Parameter mode: initial value for pickerMode
    public init(
        _ directory: URL? = nil,
        utis: [String] = [(kUTTypeItem as String), (kUTTypeFolder as String)],
        mode: UIDocumentPickerMode = .open
    ) {
        directoryURL = directory
        documentTypes = utis
        pickerMode = mode
    }
}
