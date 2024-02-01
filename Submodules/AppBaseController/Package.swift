// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppBaseController",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "AppBaseController",
            targets: ["AppBaseController"]),
    ],
    dependencies: [
        .package(path: "../AppFoundation"),
        .package(path: "../AppColors"),
        .package(path: "../AppNetwork"),
        .package(path: "../AppModels"),
        .package(path: "../AppSettings"),
    ],
    targets: [
        .target(
            name: "AppBaseController",
            dependencies: [
                "AppFoundation",
                "AppColors",
                "AppNetwork",
                "AppModels",
                "AppSettings"
            ]
        ),
        .testTarget(
            name: "AppBaseControllerTests",
            dependencies: ["AppBaseController"]
        ),
    ]
)
