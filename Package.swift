// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Nuke Alamofire Plugin",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3)
    ],
    products: [
        .library(name: "NukeAlamofirePlugin", targets: ["NukeAlamofirePlugin"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/kean/Nuke.git",
            from: "8.0.0"
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            from: "4.8.0"
        )
    ],
    targets: [
        .target(name: "NukeAlamofirePlugin", dependencies: ["Nuke", "Alamofire"], path: "Source")
    ]
)
