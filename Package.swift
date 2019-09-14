// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "OpenParkingImporter",
    platforms: [
        .macOS(.v10_12),
    ],
    products: [
        .library(
            name: "OpenParkingImporter",
            targets: ["OpenParkingImporter"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/postgres-nio", from: "1.0.0-alpha"),
        .package(path: "../OpenParkingBase"),
        .package(path: "../Dresden"),
        .package(path: "../Basel"),
        .package(path: "../DeutscheBahn"),
    ],
    targets: [
        .target(
            name: "OpenParkingImporter",
            dependencies: [
                "PostgresNIO",
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
