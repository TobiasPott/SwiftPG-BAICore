// swift-tools-version: 5.9

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "Brick Art Instructor",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "Brick Art Instructor",
            targets: ["AppModule"],
            bundleIdentifier: "de.tobiaspott.playground.brickartinstructor",
            teamIdentifier: "LR2W97LX43",
            displayVersion: "0.8.1",
            bundleVersion: "51",
            appIcon: .asset("AppIcon"),
            accentColor: .presetColor(.blue),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .fileAccess(.pictureFolder, mode: .readWrite),
                .fileAccess(.userSelectedFiles, mode: .readWrite),
                .fileAccess(.downloadsFolder, mode: .readWrite)
            ],
            appCategory: .graphicsDesign
        )
    ],
    dependencies: [
        .package(url: "https://github.com/TobiasPott/SwiftPG-CIFilters.git", "1.0.0"..<"2.0.0"),
        .package(url: "https://github.com/TobiasPott/SwiftPG-Palettes.git", "1.0.0"..<"2.0.0")
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            dependencies: [
                .product(name: "SwiftPG-CIFilters", package: "SwiftPG-CIFilters"),
                .product(name: "SwiftPG-Palettes", package: "SwiftPG-Palettes")
            ],
            path: ".",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        )
    ]
)
