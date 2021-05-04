//
//  FilePickerState.swift
//  
//
//  Created by Michael Salmon on 2019-09-22.
//

import Foundation
import Combine
import UIKit
import UniformTypeIdentifiers

@available(iOS 14.0, *)
/// Container for parameters for FilePickerController()
public class FilePickerState: ObservableObject, Identifiable {
    public let id = UUID()     // swiftlint:disable:this identifier_name

    /// URL's selected by UIDocumentPickerViewController
    @Published
    public var urls: [URL]?

    /// UTI's of documents we are interested in
    var documentTypes: [UTType] = []

    /// Copy contents
    var copyContents: Bool

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
    /// send() is called in FilePickerController
    public let urlPublisher = PassthroughSubject<URL, Never>()

    /// Initializer for FilePickerState
    /// - Parameter directory: start directory
    /// - Parameter utis: initial value for documentTypes
    public init(
        _ directory: URL? = nil,
        utis: [UTType] = [.item],
        asCopy: Bool = false
    ) {
        directoryURL = directory
        documentTypes = utis
        copyContents = asCopy
    }
}
