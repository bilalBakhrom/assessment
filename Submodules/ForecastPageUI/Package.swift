// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ForecastPageUI",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "ForecastPageUI",
            targets: ["ForecastPageUI"]
        ),
    ],
    dependencies: [
        .package(path: "../AppFoundation"),
        .package(path: "../AppAssets"),
        .package(path: "../AppColors"),
        .package(path: "../AppSettings"),
        .package(path: "../AppModels"),
        .package(path: "../AppNetwork")
    ],
    targets: [
        .target(
            name: "ForecastPageUI",
            dependencies: [
                "AppFoundation",
                "AppAssets",
                "AppColors",
                "AppSettings",
                "AppModels",
                "AppNetwork"
            ]
        ),
        .testTarget(
            name: "ForecastPageUITests",
            dependencies: ["ForecastPageUI"]
        ),
    ]
)
