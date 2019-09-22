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
class FilePickerState: ObservableObject, Identifiable {
    let id = UUID()     // swiftlint:disable:this identifier_name

    @Published
    var urls: [URL]?

    var documentTypes: [String] = []
    var pickerMode: UIDocumentPickerMode

    init(
        utis: [String] = ["public.item"],
        mode: UIDocumentPickerMode = .open
    ) {
        documentTypes = utis
        pickerMode = mode
    }
}
