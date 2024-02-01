// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppColors",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppColors",
            targets: ["AppColors"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation")
    ],
    targets: [
        .target(
            name: "AppColors",
            dependencies: [
                "AppFoundation"
            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "AppColorsTests",
            dependencies: ["AppColors"]
        ),
    ]
)
