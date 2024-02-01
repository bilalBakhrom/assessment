// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppModels",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppModels",
            targets: ["AppModels"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation"),
        .package(path: "../AppAssets"),
        .package(path: "../AppNetwork"),
    ],
    targets: [
        .target(
            name: "AppModels",
            dependencies: [
                "AppFoundation",
                "AppAssets",
                "AppNetwork"
            ]
        ),
        .testTarget(
            name: "AppModelsTests",
            dependencies: ["AppModels"]
        ),
    ]
)
