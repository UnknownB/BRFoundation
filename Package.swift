// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BRFoundation",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "BRFoundation",
            targets: ["BRFoundation"]),
    ],
    dependencies: [
        .package(url: "https://github.com/UnknownB/BRMacros", branch: "main")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "BRFoundation", dependencies: ["BRMacros"]),
        .testTarget(
            name: "BRFoundationTests",
            dependencies: ["BRFoundation"]),
    ]
)
