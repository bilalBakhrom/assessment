// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppNetwork",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppNetwork",
            targets: ["AppNetwork"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation"),
        .package(url: "https://github.com/bilalBakhrom/NetworkFoundation", .upToNextMajor(from: "1.2.0")),
    ],
    targets: [
        .target(
            name: "AppNetwork",
            dependencies: [
                "AppFoundation",
                "NetworkFoundation"
            ]
        ),
        .testTarget(
            name: "AppNetworkTests",
            dependencies: ["AppNetwork"]
        ),
    ]
)
