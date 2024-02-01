// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppSettings",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppSettings",
            targets: ["AppSettings"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation"),
        .package(path: "../AppModels")
    ],
    targets: [
        .target(
            name: "AppSettings",
            dependencies: [
                "AppFoundation",
                "AppModels"
            ]
        ),
        .testTarget(
            name: "AppSettingsTests",
            dependencies: ["AppSettings"]
        ),
    ]
)
