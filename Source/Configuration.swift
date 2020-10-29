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
    var button:UIButton!
    var isOverrideSize:Bool!
    private let _defaultbutton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "square.fill")!, for: .normal)
        button.frame.size = CGSize(width: 16, height: 16)
        return button
    }()
    
    init(buttonPosition:ButtonPosition!,
         buttonType:ButtonType!,
         button:UIButton? = nil,
         isOverrideSize:Bool = false
         ) {
        self.buttonPosition = buttonPosition
        self.buttonType = buttonType
        
        self.button = button ?? _defaultbutton
        self.isOverrideSize = isOverrideSize
    }
}

open class Configuration {
    
    var activeButtons:[Button]! = []
    
    private let _trashButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "trash")!, for: .normal)
        button.frame.size = CGSize(width: 16, height: 16)
        buttonDecorator(button)
        return button
    }()
    private let _scaleButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right")!, for: .normal)
        button.frame.size = CGSize(width: 16, height: 16)
        buttonDecorator(button)
        return button
    }()
    
    private let _rotateButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "gobackward")!, for: .normal)
        button.frame.size = CGSize(width: 16, height: 16)
        buttonDecorator(button)
        return button
    }()
    
    private let _stretchWidthButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "square.fill")!, for: .normal)
        button.frame.size = CGSize(width: 16, height: 16)
        buttonDecorator(button)
        return button
    }()
    
    private let _stretchHeightButton:UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "square.fill")!, for: .normal)
        button.frame.size = CGSize(width: 16, height: 16)
        buttonDecorator(button)
        return button
    }()
    
    private static func buttonDecorator(_ button:UIButton){
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 4.0
        button.layer.masksToBounds = false
        button.layer.cornerRadius = 28/2
        button.backgroundColor = .white
    }
    
    public init(){
        activeButtons = [Button(buttonPosition: .top_left, buttonType: .remove,button: _trashButton),
                                      Button(buttonPosition: .bottom_right, buttonType: .scale,button: _scaleButton),
                                      Button(buttonPosition: .bottom_left, buttonType: .rotate,button: _rotateButton),
                                      Button(buttonPosition: .midle_left, buttonType: .stretch_width,button: _stretchWidthButton),
                                      Button(buttonPosition: .midle_bottom, buttonType: .stretch_height,button: _stretchHeightButton)]
    }
    
    var minimumSize:CGFloat! = 16 * 4
    public var insetMarging:CGFloat! = 16
    public var boarderColor:UIColor! = .darkGray
    public var borderWidth:CGFloat! = 2
    public var buttonSize:CGSize! = CGSize(width: 28, height: 28) {
        didSet{
            minimumSize = buttonSize.width * 4
        }
    }
    
}
