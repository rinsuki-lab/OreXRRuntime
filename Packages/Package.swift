// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "Packages",
    platforms: [.macOS(.v15)],
    products: [
        .library(name: "OreXRMacros", targets: ["OreXRMacros"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-syntax.git", from: "600.0.0-latest"),
    ],
    targets: [
        .target(name: "OreXRMacros", dependencies: ["OreXRMacrosImpl"]),
        .macro(name: "OreXRMacrosImpl", dependencies: [
            .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
            .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
        ]),
    ]
)
