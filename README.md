# FilePicker

Wrapper for [`UIDocumentPickerViewController`](https://developer.apple.com/documentation/uikit/uidocumentpickerviewcontroller)

Updated for iOS 14, currently works though not well.

My testbed `ContentView`:

``` swift
struct ContentView: View {
    @ObservedObject
    var state = FilePickerState().showFileExtensions(true)
    @State
    var path = "Not Set"
    @State
    var showPicker = false
    @State
    var multi = false

    var body: some View {
        VStack {
            Button("Pick file") {
                self.showPicker = true
            }
            .sheet(isPresented: self.$showPicker) {
                FilePickerView(state, showToggles: true)
            }
            Text("Path: \(path)")
                .onReceive(state.urlPublisher, perform: { self.path = $0.path })
        }
    }
}
```
