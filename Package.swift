// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "KhrysalisRuntime",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "KhrysalisRuntime",
            targets: ["KhrysalisRuntime"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "KhrysalisRuntime",
            dependencies: [],
            path: "Sources/KhrysalisRuntime",
            publicHeadersPath: "include",
        ),
        .testTarget(
            name: "KhrysalisRuntimeTests",
            dependencies: ["KhrysalisRuntime"],
        ),
    ],
)