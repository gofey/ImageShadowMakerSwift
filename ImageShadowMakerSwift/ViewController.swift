//
//  ViewController.swift
//  ImageShadowMakerSwift
//
//  Created by 厉国辉 on 2017/4/28.
//  Copyright © 2017年 GofeyLee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var imgIndex:Int = 0
    let imgView = ImageShadowView(frame:CGRect.init(x: UIScreen.main.bounds.size.width / 2 - 50, y: UIScreen.main.bounds.size.height / 2 - 50, width: 100, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.addSubview(imgView)
        imgView.isUserInteractionEnabled = true
        imgView.image = #imageLiteral(resourceName: "image0")
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(changeImg))
        imgView.addGestureRecognizer(tap)
        imgView.cornerRadius = 50
        
    }
    
    func changeImg() {
        imgIndex  = imgIndex + 1
        if imgIndex > 12 {
            imgIndex = 0
        }
        imgView.image = UIImage.init(imageLiteralResourceName: "image\(imgIndex)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
