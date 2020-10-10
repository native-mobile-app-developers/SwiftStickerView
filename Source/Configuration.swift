//
//  Configuration.swift
//  SwiftStickerView
//
//  Created by sachitha on 9/19/20.
//

import Foundation

enum ButtonType {
    case scale,rotate,flip,remove,move,stretch_width,stretch_height
}

enum ButtonPosition{
    case top_left,bottom_right,bottom_left,midle_left,midle_bottom
}

struct Button {
    var buttonPosition:ButtonPosition!
    var buttonType:ButtonType!
    var image:UIImage!
    var tintColor:UIColor!
    var buttonSize:CGSize!
    init(buttonPosition:ButtonPosition!,
         buttonType:ButtonType!,tintColor:UIColor = .black,
         image:UIImage = UIImage(systemName: "square.fill")!,buttonSize:CGSize = CGSize(width: 16, height: 16)) {
        self.buttonPosition = buttonPosition
        self.buttonType = buttonType
        self.image = image
        self.tintColor = tintColor
        self.buttonSize = buttonSize
    }
}

open class Configuration {
    
    public init(){}
    
    var activeButtons:[Button]! = [Button(buttonPosition: .top_left, buttonType: .remove,image: UIImage(systemName: "trash")!),
                                   Button(buttonPosition: .bottom_right, buttonType: .scale,image: UIImage(systemName: "arrow.up.left.and.arrow.down.right")!),
                                   Button(buttonPosition: .bottom_left, buttonType: .rotate,image: UIImage(systemName: "gobackward")!),
                                   Button(buttonPosition: .midle_left, buttonType: .stretch_width,image: UIImage(systemName: "square.fill")!),
                                   Button(buttonPosition: .midle_bottom, buttonType: .stretch_height,image: UIImage(systemName: "square.fill")!)
    ]
    public var insetMarging:CGFloat! = 16
    public var boarderColor:UIColor! = .darkGray
    public var borderWidth:CGFloat! = 2
    public var buttonSize:CGSize! = CGSize(width: 16, height: 16)
    var minimumSize:CGFloat! = 16 * 4
}
