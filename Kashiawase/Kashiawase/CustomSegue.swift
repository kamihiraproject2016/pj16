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
    override func perform() {
        let source = self.sourceViewController as UIViewController!
        let destination = self.destinationViewController as UIViewController!
        
        source.view.alpha = 1.0;
        destination.view.alpha = 0.0;

        source.view.addSubview(destination.view);
        
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            for subview in source.view.subviews{
                subview.alpha = 0.0;
            }
        }) { (finished) -> Void in
            UIView.animateWithDuration(2.0, delay: 0.5, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                    destination.view.alpha = 1.0;
                }, completion: { (finished) -> Void in
                    source.presentViewController(destination, animated: false, completion: nil);
            })
        }
    }
}