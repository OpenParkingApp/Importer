// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "OpenParkingImporter",
    products: [
        .library(
            name: "OpenParkingImporter",
            targets: ["OpenParkingImporter"]),
    ],
    dependencies: [
        .package(path: "../OpenParkingBase"),
        .package(path: "../Dresden"),
        .package(path: "../Basel"),
        .package(path: "../DeutscheBahn"),
    ],
    targets: [
        .target(
            name: "OpenParkingImporter",
            dependencies: [
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
