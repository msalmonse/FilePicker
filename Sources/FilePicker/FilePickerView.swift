//
//  FilePickerView.swift
//  
//
//  Created by Michael Salmon on 2019-09-23.
//

import Foundation
import SwiftUI

@available(iOS 13.0, *)
struct FilePickerView: View {
    @ObservedObject
    var state: FilePickerState
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    func doDismiss() {
        mode.wrappedValue.dismiss()
    }

    var body: some View {
        FilePickerController(state, { self.doDismiss() })
    }
}
