![Mobile Jazz Vastra](https://raw.githubusercontent.com/mobilejazz/metadata/master/images/banners/mobile-jazz-ios-core.jpg)

# ![Mobile Jazz Badge](https://raw.githubusercontent.com/mobilejazz/metadata/master/images/icons/mj-40x40.png) MJiOSCore

Several utilities that depend on UIKit, meant for iOS only projects

## How to 

To install the MJ iOS Core library, just paste the following line in your podfile:
```
pod 'mj-ios-core', :git => 'https://bitbucket.org/mobilejazz/mj-ios-core.git', :tag => '1.0.0'
```

We also have some subpods that can be installed like this:
```ruby
pod 'mj-ios-core/Tools'
pod 'mj-ios-core/ViewControllers'
pod 'mj-ios-core/Views'
```

## Dependencies
- Haneke
- Cloudinary
- UIImage+Additions
- UIColor+Additions

## Included classes
### Tools
- MJCloudinaryInterface
- UIImageView+MJCloudinaryInterface
- MJPushNotificationQueue

### Views
- MJTextViewCell
- MJMultiToggleControl
- MJNotificationView
- UIBarButtonItem+Additions
- UIResponder+Additions
- UIView+Additions
- UIActionSheet+Blocks
- UIAlertView+Blocks

### View Controllers
- MJContainerViewController
- MJTableViewController
- MJPDFViewerController
