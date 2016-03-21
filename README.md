<p align="center"><img src="https://cloud.githubusercontent.com/assets/1567433/13918338/f8670eea-ef7f-11e5-814d-f15bdfd6b2c0.png" height="180"/>

<p align="center">
<a href="https://cocoapods.org"><img src="https://img.shields.io/cocoapods/v/Nuke-Alamofire-Plugin.svg"></a>
<a href="https://github.com/Carthage/Carthage"><img src="https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat"></a>
</p>

[Alamofire](https://github.com/Alamofire/Alamofire) plugin for [Nuke](https://github.com/kean/Nuke) that allows you to use Alamofire for networking.

## Usage

#### Create Image Manager

```swift
let dataLoader: ImageDataLoading = AlamofireImageDataLoader(manager: <#AlamofireManager#>)
let decoder: ImageDecoding = <#decoder#>
let cache: ImageMemoryCaching = <#cache#>

let configuration = ImageManagerConfiguration(dataLoader: dataLoader, decoder: decoder, cache: cache)
ImageManager.shared = ImageManager(configuration: configuration)
```

#### Image Data Loader

```swift
// Create with shared Alamofire.Manager
let _ = AlamofireImageDataLoader()

// Create with concrete Alamofire.Manager
let _ = AlamofireImageDataLoader(manager: <#AlamofireManager#>)

// Create with NSURLSessionConfiguration
let _ = AlamofireImageDataLoader(configuration: <#NSURLSessionConfiguration#>)
```

## Considerations

`AlamofireImageDataLoader` disables `startRequestsImmediately` option of an `Alamofire.Manager` that it was initialized with.

## Installation

### [CocoaPods](http://cocoapods.org)

To install plugin add a dependency to your Podfile:

```ruby
# source 'https://github.com/CocoaPods/Specs.git'
# use_frameworks!
# platform :ios, "8.0" / :watchos, "2.0" / :osx, "10.9" / :tvos, "9.0"

pod "Nuke-Alamofire-Plugin"
```

### [Carthage](https://github.com/Carthage/Carthage)

To install plugin add a dependency to your Cartfile:

```
github "kean/Nuke-Alamofire-Plugin"
```

## Requirements
- iOS 8.0+ / watchOS 2.0+ / OS X 10.9+
- Xcode 7.0+, Swift 2.0+

## Contacts

<a href="https://github.com/kean">
<img src="https://cloud.githubusercontent.com/assets/1567433/6521218/9c7e2502-c378-11e4-9431-c7255cf39577.png" height="44" hspace="2"/>
</a>
<a href="https://twitter.com/a_grebenyuk">
<img src="https://cloud.githubusercontent.com/assets/1567433/6521243/fb085da4-c378-11e4-973e-1eeeac4b5ba5.png" height="44" hspace="2"/>
</a>
<a href="https://www.linkedin.com/pub/alexander-grebenyuk/83/b43/3a0">
<img src="https://cloud.githubusercontent.com/assets/1567433/6521256/20247bc2-c379-11e4-8e9e-417123debb8c.png" height="44" hspace="2"/>
</a>

## License

Nuke is available under the MIT license. See the LICENSE file for more info.
