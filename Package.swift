// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "HexString",
    products: [
      .library(name: "HexString", targets: ["HexString"])
    ],
    targets: [
      .target(name: "HexString", path: ".", sources: ["Sources"])
    ]
)
