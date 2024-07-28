// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "SQLite.swift",
    platforms: [
        .iOS(.v12),
        .macOS(.v10_13),
        .watchOS(.v4),
        .tvOS(.v12),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "SQLite",
            type: .`dynamic`, 
            targets: ["SQLite"]
        )
    ],
    targets: [
        .target(
            name: "SQLite",
            dependencies: ["SQLiteC"],            
            exclude: [
                "Info.plist"
            ],                              
            swiftSettings: [
                .define("SQLITE_SWIFT_STANDALONE")
            ]
        ),
        .target(
            name: "SQLiteC",
            dependencies: []
        ),
        .testTarget(
            name: "SQLiteTests",
            dependencies: [
                "SQLite"
            ],
            path: "Tests/SQLiteTests",
            exclude: [
                "Info.plist"
            ],
            resources: [
                .copy("Resources")
            ]
        )
    ]
)

#if os(Linux)
package.dependencies = [
    .package(url: "https://github.com/stephencelis/CSQLite.git", from: "0.0.3")
]
package.targets.first?.dependencies += [
    .product(name: "CSQLite", package: "CSQLite")
]
#endif