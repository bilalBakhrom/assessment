// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppAssets",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppAssets",
            targets: ["AppAssets"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation")
    ],
    targets: [
        .target(
            name: "AppAssets",
            dependencies: [
                "AppFoundation"
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "AppAssetsTests",
            dependencies: ["AppAssets"]
        ),
    ]
)
