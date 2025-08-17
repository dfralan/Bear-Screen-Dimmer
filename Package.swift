// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "BearScreenDimmer",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(
            name: "BearScreenDimmer",
            targets: ["TransparentOverlay"]
        )
    ],
    targets: [
        .executableTarget(
            name: "TransparentOverlay",
            path: ".",
            exclude: ["README.md"],
            sources: ["TransparentOverlayApp.swift", "AppDelegate.swift", "OverlayContentView.swift"],
            resources: [.process("bear-icon.icns")]
        )
    ]
)
