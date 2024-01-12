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
            displayVersion: "0.11.2",
            bundleVersion: "80",
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
                .fileAccess(.userSelectedFiles, mode: .readWrite)
            ],
            appCategory: .graphicsDesign
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            swiftSettings: [
                .enableUpcomingFeature("BareSlashRegexLiterals")
            ]
        )
    ]
)
