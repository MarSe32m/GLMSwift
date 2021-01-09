// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GLMSwift",
    products: [
        .library(name: "GLMSwift", targets: ["GLMSwift"]),
    ],
    dependencies: [],
    targets: [.target(name: "GLMSwift")
    ]
)
