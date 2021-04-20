// swift-tools-version:5.4

import PackageDescription

let package = Package(
    name: "swift-hex-string",
    platforms: [
        .macOS(.v10_10),
        .iOS(.v8),
        .watchOS(.v3),
        .tvOS(.v9),
    ],
    products: [
            .library(name: "HexString", targets: ["HexString"]),
        ],
    dependencies: [

    ],
    targets: [
        .target(name: "HexString"),
        .testTarget(name: "HexStringTests", dependencies: ["HexString"]),
    ]
)
