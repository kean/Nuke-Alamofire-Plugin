// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "Nuke Alamofire Plugin",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(name: "NukeAlamofirePlugin", targets: ["NukeAlamofirePlugin"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/kean/Nuke.git",
            from: "12.0.0"
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire.git",
            from: "5.0.0"
        )
    ],
    targets: [
        .target(name: "NukeAlamofirePlugin", dependencies: ["Nuke", "Alamofire"], path: "Source")
    ]
)
