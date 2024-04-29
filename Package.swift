// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "wishkit-ios",
    platforms: [
        .macOS(.v12),
        .iOS(.v14)
    ],
    products: [
        .library(name: "WishKit", targets: ["WishKit"])
    ],
    dependencies: [
        .package(name: "wishkit-ios-shared", path: "../wishkit-ios-shared")
    ],
    targets: [
        .target(name: "WishKit", dependencies: [
            .product(name: "WishKitShared", package: "wishkit-ios-shared")
        ]),
        .testTarget(name: "WishKitTests", dependencies: [.target(name: "WishKit")]),
    ]
)
