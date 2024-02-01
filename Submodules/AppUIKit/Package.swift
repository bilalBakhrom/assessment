// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppUIKit",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppUIKit",
            targets: ["AppUIKit"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation"),
        .package(path: "../AppAssets"),
        .package(path: "../AppColors"),
        .package(path: "../AppSettings"),
        .package(path: "../AppModels")
    ],
    targets: [
        .target(
            name: "AppUIKit",
            dependencies: [
                "AppFoundation",
                "AppAssets",
                "AppColors",
                "AppSettings",
                "AppModels"
            ]
        ),
        .testTarget(
            name: "AppUIKitTests",
            dependencies: ["AppUIKit"]
        ),
    ]
)
