# MJiOSCore

<!--- [![CI Status](http://img.shields.io/travis/Joan Martin/MJiOSCore.svg?style=flat)](https://travis-ci.org/Joan Martin/MJiOSCore) -->
[![Version](https://img.shields.io/cocoapods/v/MJiOSCore.svg?style=flat)](http://cocoapods.org/pods/MJiOSCore)
[![License](https://img.shields.io/cocoapods/l/MJiOSCore.svg?style=flat)](http://cocoapods.org/pods/MJiOSCore)
[![Platform](https://img.shields.io/cocoapods/p/MJiOSCore.svg?style=flat)](http://cocoapods.org/pods/MJiOSCore)


## Installation

MJiOSCore is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MJiOSCore'
```

Available Subspecs:

- MJiOSCore/Tools
- MJiOSCore/MVP
- MJiOSCore/ViewControllers
- MJiOSCore/Views
- MJiOSCore/Cloudinary (Dependency on Cloudinary 1.0)
- MJiOSCore/CloudinaryHaneke (Dependency on Haneke 1.0 and Cloudinary 1.0)

Note that the default pod MJiOSCore has as default subspecs Tools, MVP, ViewControllers and Views. To install the Cloudinary and CloudinaryHaneke subspecs you must reference directly as:

```ruby
pod 'MJiOSCore/Cloudinary'
```
and/or
```ruby
pod 'MJiOSCore/CloudinaryHaneke'
```

### Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Author

Mobile Jazz, info@mobilejazz.com

## License

MJiOSCore is available under the Apache 2 license. See the LICENSE file for more info.
