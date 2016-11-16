//
//  DetailViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/10.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import UIKit
import Foundation

class DetailViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var changeTabBar: UITabBar!;
    @IBOutlet weak var JpnView: UIView!;
    @IBOutlet weak var EnView: UIView!;

    var cardId: Int!;

    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var cardName: String!;
        cardName = "あんみつ";
        // ナビゲーションバーの設定
        self.title = cardName;
        
        // タブバーの設定
        changeTabBar.barTintColor = gray;
        changeTabBar.tintColor = UIColor.whiteColor();
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(25.5)], forState: UIControlState.Normal);
        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0, -9);
        
        JpnView.hidden = false;
        EnView.hidden = true;

        changeTabBar.delegate = self;
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        print("OK");
        switch item.tag{
        case 1:
            JpnView.hidden = false;
            EnView.hidden = true;
        case 2:
            JpnView.hidden = true;
            EnView.hidden = false;
        default:
            return;
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

