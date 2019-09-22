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

    public init(
        utis: [String] = ["public.item"],
        mode: UIDocumentPickerMode = .open
    ) {
        documentTypes = utis
        pickerMode = mode
    }
}
