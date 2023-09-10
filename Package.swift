// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Fraction",
    products: [
        .library(
            name: "Fraction",
            targets: ["Fraction"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Fraction",
            dependencies: []),
        .testTarget(
            name: "FractionTests",
            dependencies: ["Fraction"]),
    ]
)
