//
//  ViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/10/29.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button1 : UIButton = UIButton(type: UIButtonType.system)
        button1.frame = CGRect(x: 100, y: 50, width: 200, height: 200)
        button1.setTitle(NSLocalizedString("春", comment: ""), for: UIControlState.normal)
        
        self.view.addSubview(button1)
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

