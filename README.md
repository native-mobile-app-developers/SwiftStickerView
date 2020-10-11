# SwiftStickerView

[![CI Status](https://img.shields.io/travis/native-mobile-app-developers/SwiftStickerView.svg?style=flat)](https://travis-ci.org/sachithamh/SwiftStickerView)
[![Version](https://img.shields.io/cocoapods/v/SwiftStickerView.svg?style=flat)](https://cocoapods.org/pods/SwiftStickerView)
[![License](https://img.shields.io/cocoapods/l/SwiftStickerView.svg?style=flat)](https://cocoapods.org/pods/SwiftStickerView)
[![Platform](https://img.shields.io/cocoapods/p/SwiftStickerView.svg?style=flat)](https://cocoapods.org/pods/SwiftStickerView)

![](https://github.com/native-mobile-app-developers/SwiftStickerView/blob/master/Example/SwiftStickerView/Images.xcassets/sample-gif.dataset/sample-gif.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SwiftStickerView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SwiftStickerView'
```
code is simple 
first import the pod lib using
```
import SwiftStickerView
```
Then code impimentaion example
```
let configuration = Configuration()
configuration.borderWidth = 2
configuration.buttonSize = CGSize(width: 16, height: 16)

 let testView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 150, height: 100))
       testView.backgroundColor = UIColor.red
testView.image = UIImage(named: "image")
let stickerView = StickerView.init(contentView: testView, configuration: configuration)
stickerView.center = self.view.center
self.view.addSubview(stickerView)
```


If you think that any information you obtained here is worth of some money and are willing to pay for it, feel free to send any amount through paypal.

| Paypal | Bitcoin |
| ------ | ------- |
| [![](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=LUAUTLYBJ7XHN&currency_code=USD) | [](https://github.com/native-mobile-app-developers/SwiftStickerView/blob/master/Example/SwiftStickerView/Images.xcassets/QRCode.imageset/QRCode.png) |

## Author

sachithamh, sachithamh@gmail.com

influnce and idea came from 
[injap2017/StickerView](https://github.com/injap2017/StickerView)


## License

SwiftStickerView is available under the MIT license. See the LICENSE file for more info.
