// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Predicate",
    products: [
        .library(name: "Predicate", targets: [ "Predicate" ]),
    ],
    targets: [
        .target(name: "Predicate", dependencies: [ ]),
        .testTarget(name: "PredicateTests", dependencies: [ "Predicate" ]),
    ]
)
