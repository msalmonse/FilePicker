//
//  FilePickerState.swift
//  
//
//  Created by Michael Salmon on 2019-09-22.
//

import Foundation
import Combine
import UIKit

@available(iOS 13.0, *)
public class FilePickerState: ObservableObject, Identifiable {
    public let id = UUID()     // swiftlint:disable:this identifier_name

    @Published
    public var urls: [URL]?

    var documentTypes: [String] = []
    var pickerMode: UIDocumentPickerMode

    @Published
    var allowsMultipleSelection = false
    public func allowMultipleSelection(_ allow: Bool) -> FilePickerState {
        allowsMultipleSelection = allow
        return self
    }

    @Published
    var directoryURL: URL?

    public let urlPublisher = PassthroughSubject<URL, Never>()

    public init(
        _ directory: URL? = nil,
        utis: [String] = ["public.item"],
        mode: UIDocumentPickerMode = .open
    ) {
        directoryURL = directory
        documentTypes = utis
        pickerMode = mode
    }
}
