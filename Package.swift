// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Nuke Alamofire Plugin",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4)
    ],
    products: [
        .library(name: "NukeAlamofirePlugin", targets: ["NukeAlamofirePlugin"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/kean/Nuke.git",
            from: "10.0.0"
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
