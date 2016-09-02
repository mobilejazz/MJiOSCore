# MJiOSCore

## How to 

To install the MJiOSCore library, just paste the following line in your podfile:
```
pod 'MJiOSCore', :git => 'https://github.com/mobilejazz/MJiOSCore.git', :tag => '0.1.0'
```

We also have some subpods that can be installed like this:
```ruby
pod 'MJiOSCore/Tools'
pod 'MJiOSCore/ViewControllers'
pod 'MJiOSCore/Views'
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
