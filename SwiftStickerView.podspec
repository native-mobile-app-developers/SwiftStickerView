#
# Be sure to run `pod lib lint SwiftStickerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftStickerView'
  s.version          = '2.0.2'
  s.summary          = 'SwiftStickerView for view move rotate scretch.'
  s.requires_arc = true

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = "SwiftStickerView for view move rotate scretch. and you can view as ImageView,textView,TextLabel... like any kind of View"

  s.homepage         = 'https://github.com/native-mobile-app-developers/SwiftStickerView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sachithamh' => 'sachithamh@gmail.com' }
  s.source           = { :git => 'https://github.com/native-mobile-app-developers/SwiftStickerView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Source/*.swift'
  s.swift_version = '4.0'
  s.platforms = {
      "ios":"13.0"
  }
  # s.resource_bundles = {
  #   'SwiftStickerView' => ['SwiftStickerView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
