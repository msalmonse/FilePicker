//
//  FilePickerView.swift
//  
//
//  Created by Michael Salmon on 2019-09-23.
//

import Foundation
import SwiftUI

@available(iOS 14.0, *)
/// View to show FilePickerController and allow dismisal
/// - Parameter state: state for FilePickerController
public struct FilePickerView: View {
    @ObservedObject
    var state: FilePickerState
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    public init(_ state: FilePickerState) {
        self.state = state
    }

    func doDismiss() {
        mode.wrappedValue.dismiss()
    }

    public var body: some View {
        FilePickerController(state, { self.doDismiss() })
    }
}
