//
//  CustomSegue.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/23.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class CustomSegue: UIStoryboardSegue{
    var source: UIViewController!
    var destination: UIViewController!
    var guruguru: UIActivityIndicatorView!
    
    override func perform() {
        source = self.sourceViewController as UIViewController!
        destination = self.destinationViewController as UIViewController!
        
        source.view.alpha = 1.0;
        destination.view.alpha = 0.0;
        
//        guruguru = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50));
//        guruguru.center = source.view.center;
//        guruguru.hidesWhenStopped = true;
//        guruguru.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.White;
//        guruguru.backgroundColor = UIColor.grayColor();
//        guruguru.layer.masksToBounds = true;
//        guruguru.layer.cornerRadius = 5.0;
//        guruguru.layer.opacity = 0.8;
//        
//        source.view.addSubview(guruguru);
//        
//        guruguru.startAnimating();

        source.view.addSubview(destination.view);

        UIView.animateWithDuration(2.0, animations: { () -> Void in
            for subview in self.source.view.subviews{
                subview.alpha = 0.0;
            }
            }) { (finished) -> Void in
                UIView.animateWithDuration(2.0, delay: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    self.destination.view.alpha = 1.0;
                    }, completion: { (finished) -> Void in
                        self.source.presentViewController(self.destination, animated: false, completion: nil);
                })
        }
    }
    
}