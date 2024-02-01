// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCoreData",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppCoreData",
            targets: ["AppCoreData"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation"),
        .package(path: "../AppModels")
    ],
    targets: [
        .target(
            name: "AppCoreData",
            dependencies: [
                "AppFoundation",
                "AppModels"
            ]
        ),
        .testTarget(
            name: "AppCoreDataTests",
            dependencies: ["AppCoreData"]
        ),
    ]
)
