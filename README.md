# Nuke Alamofire Plugin

<p align="left">
<a href="https://cocoapods.org"><img src="https://img.shields.io/cocoapods/v/Nuke-Alamofire-Plugin.svg"></a>
<img src="https://img.shields.io/badge/supports-Swift%20Package%20Manager%2C%20CocoaPods%2C%20Carthage-green.svg">
</p>

[Alamofire](https://github.com/Alamofire/Alamofire) plugin for [Nuke](https://github.com/kean/Nuke) that allows you to use Alamofire for networking.

## Usage

The plugin adds a `DataLoader` class that uses `Alamofire.Session` for networking.

```swift
let pipeline = ImagePipeline {
    $0.dataLoader = NukeAlamofirePlugin.AlamofireDataLoader()
    $0.imageCache = ImageCache.shared
}

ImagePipeline.shared = pipeline
```

## Installation

Please follow the [Installation Guide](https://github.com/kean/Nuke-Alamofire-Plugin/blob/master/Documentation/Guides/Installation%20Guide.md)

## Minimum Requirements

| Nuke Alamofire Plugin            | Swift                 | Xcode                | Platforms                                          |
|----------------------------------|-----------------------|----------------------|----------------------------------------------------|
| Nuke Alamofire Plugin 5.0      | Swift 5.1       | Xcode 11.0      | iOS 11.0 / watchOS 4.0 / macOS 10.13 / tvOS 11.0  |
| Nuke Alamofire Plugin 4.3        | Swift 5.0            | Xcode 11.0            | iOS 10.0 / macOS 10.12 / watchOS 3.0 / tvOS 10.0   |
| Nuke Alamofire Plugin 4.2        | Swift 4.2 – 5.0       | Xcode 10.1 – 10.2    | iOS 10.0 / macOS 10.12 / watchOS 3.0 / tvOS 10.0   |
| Nuke Alamofire Plugin 4.1        | Swift 4.0 – 4.2       | Xcode 9.2 – 10.1     | iOS 9.0 / macOS 10.11 / watchOS 2.0 / tvOS 9.0     | 

## Dependencies

- [Nuke 9](https://github.com/kean/Nuke)
- [Alamofire 5](https://github.com/Alamofire/Alamofire)

## License

Nuke Alamofire Plugin is available under the MIT license. See the LICENSE file for more info.
