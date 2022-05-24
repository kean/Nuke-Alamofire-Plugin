# Nuke Alamofire Plugin

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

Please use Swift Package Manager to install it.

## Minimum Requirements

| Nuke Alamofire Plugin            | Swift                 | Xcode                | Platforms                                          |
|----------------------------------|-----------------------|----------------------|----------------------------------------------------|
| Nuke Alamofire Plugin 6.1      | Swift 5.3       | Xcode 12.0      | iOS 12.0 / watchOS 5.0 / macOS 10.14 / tvOS 12.0  |
| Nuke Alamofire Plugin 6.0      | Swift 5.3       | Xcode 12.0      | iOS 11.0 / watchOS 4.0 / macOS 10.13 / tvOS 11.0  |
| Nuke Alamofire Plugin 5.0      | Swift 5.1       | Xcode 11.0      | iOS 11.0 / watchOS 4.0 / macOS 10.13 / tvOS 11.0  | 

## Dependencies

- [Nuke 10](https://github.com/kean/Nuke)
- [Alamofire 5](https://github.com/Alamofire/Alamofire)

## License

Nuke Alamofire Plugin is available under the MIT license. See the LICENSE file for more info.
