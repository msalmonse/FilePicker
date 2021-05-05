// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FilePicker",
    products: [
        .library(
            name: "FilePicker",
            targets: ["FilePicker"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "FilePicker",
            dependencies: []),
        .testTarget(
            name: "FilePickerTests",
            dependencies: ["FilePicker"]),
    ]
)
