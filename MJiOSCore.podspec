#
# Be sure to run `pod lib lint MJiOSCore.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MJiOSCore'
  s.version          = '1.5.0'
  s.summary          = 'Mobile Jazz iOS Core'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Common set of reusable classes, categories and definitions for iOS.
                       DESC

  s.homepage         = 'https://bitbucket.org/mobilejazz/mjioscore'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }
  s.author           = { 'Mobile Jazz' => 'info@mobilejazz.com' }
  s.source           = { :git => 'https://bitbucket.org/mobilejazz/mjioscore.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/mobilejazzcom'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MJiOSCore/Classes/MJiOSCore.h'

  s.default_subspecs = 'Tools', 'MVP', 'ViewControllers', 'Views'
  
  s.subspec 'Tools' do |sp|
      sp.source_files = 'MJiOSCore/Classes/Tools/**/*'
  end
  
  s.subspec 'MVP' do |sp|
      sp.source_files = 'MJiOSCore/Classes/MVP/**/*'
      sp.dependency 'MJiOSCore/Tools'
  end
  
  s.subspec 'ViewControllers' do |sp|
      sp.source_files = 'MJiOSCore/Classes/ViewControllers/**/*'
      sp.dependency 'MJiOSCore/Tools'
      sp.frameworks = 'QuickLook'
  end
  
  s.subspec 'Views' do |sp|
      sp.source_files = 'MJiOSCore/Classes/Views/**/*'
      sp.dependency 'MJiOSCore/Tools'
  end
  
  s.subspec 'Cloudinary' do |sp|
      sp.source_files = 'MJiOSCore/Classes/Cloudinary/**/*'
      sp.dependency 'MJiOSCore/Tools'
      sp.dependency 'Cloudinary', '~> 1.0'
  end
  
  s.subspec 'CloudinaryHaneke' do |sp|
      sp.source_files = 'MJiOSCore/Classes/CloudinaryHaneke/**/*'
      sp.dependency 'MJiOSCore/Cloudinary'
      sp.dependency 'Haneke', '~> 1.0'
  end
  
  # s.resource_bundles = {
  #   'MJiOSCore' => ['MJiOSCore/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
