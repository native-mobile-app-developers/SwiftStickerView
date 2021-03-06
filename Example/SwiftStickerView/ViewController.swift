//
//  ViewController.swift
//  SwiftStickerView
//
//  Created by sachithamh on 09/19/2020.
//  Copyright (c) 2020 sachithamh. All rights reserved.
//

import UIKit
import SwiftStickerView

class ViewController: UIViewController {

    var selectedStickerView:StickerView! = nil
    var stickerView:StickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let configuration = Configuration()
        configuration.borderWidth = 2
//        configuration.buttonSize = CGSize(width: 32, height: 16)
        
         let testView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 150, height: 100))
               testView.backgroundColor = UIColor.red
        testView.image = UIImage(named: "image")
        stickerView = StickerView.init(contentView: testView, configuration: configuration)
        
        stickerView.center = self.view.center
        self.view.addSubview(stickerView)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func showHideEditView(_ sender: Any) {
        stickerView.showEditingHandlers = !stickerView.showEditingHandlers
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

