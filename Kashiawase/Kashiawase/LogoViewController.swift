//
//  LogoViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/20.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class LogoViewController: UIViewController {
    
    @IBOutlet weak var logoView1: UIImageView!
    @IBOutlet weak var logoView2: UIImageView!
    @IBOutlet weak var copyRightLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        startBtn.layer.cornerRadius = 10;
        UIView.animateWithDuration(2.0, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.logoView1.alpha = 0.0;
            self.copyRightLabel.alpha = 0.0;
            }) { (BOOL finished) -> Void in
                UIView.animateWithDuration(2.0, delay: 1.0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.logoView2.alpha = 1.0;
                    self.startBtn.alpha = 1.0;
                    }, completion: { (BOOL finished) -> Void in
                })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}