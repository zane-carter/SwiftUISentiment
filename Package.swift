// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "SwiftUISentiment",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "SwiftUISentiment",
            targets: ["SwiftUISentiment"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SwiftUISentiment",
            dependencies: []),
    ]
)
