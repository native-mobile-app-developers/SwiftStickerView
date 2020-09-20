//
//  Configuration.swift
//  SwiftStickerView
//
//  Created by sachitha on 9/19/20.
//

import Foundation

enum ButtonType {
    case scale,rotate,flip,remove,move,stretch_left,stretch_top
}

enum ButtonPosition{
    case top_left,bottom_right
}

struct Button {
    var buttonPosition:ButtonPosition!
    var buttonType:ButtonType!
    var image:UIImage!
    var tintColor:UIColor!
    init(buttonPosition:ButtonPosition!,
         buttonType:ButtonType!,tintColor:UIColor = .black,
         image:UIImage = UIImage(systemName: "square.fill")!) {
        self.buttonPosition = buttonPosition
        self.buttonType = buttonType
        self.image = image
        self.tintColor = tintColor
    }
}

open class Configuration {
  
    public init(){}
    var activeButtons:[Button]! = [Button(buttonPosition: .top_left, buttonType: .remove,image: UIImage(systemName: "trash")!),
                                   Button(buttonPosition: .bottom_right, buttonType: .scale,image: UIImage(systemName: "arrow.up.left.and.arrow.down.right")!)]
    var insetMarging:CGFloat! = 16
    var boarderColor:UIColor! = .darkGray
    var borderWidth:CGFloat! = 2
    var buttonSize:CGSize! = CGSize(width: 24, height: 24)
    var minimumSize:CGFloat! = 16 * 4
}
