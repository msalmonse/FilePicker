//
//  FilePickerState.swift
//  
//
//  Created by Michael Salmon on 2019-09-22.
//

import Foundation
import Combine

#if canImport(UIKit)

class FilePickerState: ObservableObject, Identifiable {
    let id = UUID()     // swiftlint:disable:this identifier_name

    @Published
    var urls: [URL]?

    var documentTypes: [String] = []
    var pickerMode: UIDoc
}

#endif
