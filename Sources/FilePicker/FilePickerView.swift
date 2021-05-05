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
    let toggles: Bool

    public init(_ state: FilePickerState, toggles: Bool = false) {
        self.state = state
        self.toggles = toggles
    }

    func doDismiss() {
        mode.wrappedValue.dismiss()
    }

    public var body: some View {
        FilePickerController(state, { self.doDismiss() })
        VStack {
            FilePickerController(state, { self.doDismiss() })
            if toggles {
                HStack(spacing: 50) {
                    Spacer(minLength: 50)
                    Toggle("File Extensions?", isOn: $state.shouldShowFileExtensions)
                    Toggle("Multi selections?", isOn: $state.allowsMultipleSelection)
                    Spacer(minLength: 50)
                }
            }
        }
    }
}
