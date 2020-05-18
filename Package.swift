// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "OpenParkingImporter",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "OpenParkingImporter",
            targets: ["OpenParkingImporter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/postgres-nio", from: "1.1.0"),
        .package(url: "https://github.com/OpenParkingApp/OpenParkingBase.git", .branch("master")),
        .package(name: "OpenParkingDresden", url: "https://github.com/OpenParkingApp/Dresden.git", .branch("master")),
        .package(name: "OpenParkingBasel", url: "https://github.com/OpenParkingApp/Basel.git", .branch("master")),
        .package(name: "OpenParkingDeutscheBahn", url: "https://github.com/OpenParkingApp/DeutscheBahn.git", .branch("master")),
    ],
    targets: [
        .target(
            name: "OpenParkingImporter",
            dependencies: [
                .product(name: "PostgresNIO", package: "postgres-nio"),
                "OpenParkingBase",
                "OpenParkingDresden",
                "OpenParkingBasel",
                "OpenParkingDeutscheBahn",
            ]),
        .target(
            name: "opimporter",
            dependencies: ["OpenParkingImporter"]),
        .testTarget(
            name: "OpenParkingImporterTests",
            dependencies: ["OpenParkingImporter"]),
    ]
)
