//
//  TestViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/21.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit
import Foundation

class TopViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var testTabBar: UITabBar!;
    @IBOutlet weak var gameView: UIView!;
    @IBOutlet weak var databaseView: UIView!;
    @IBOutlet weak var configView: UIView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タブバーの設定
        testTabBar.delegate = self;
//        tabBar.tintColor = UIColor.whiteColor();
//        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(25.5)], forState: UIControlState.Normal);
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0, -9);
        
        //切り替え設定
        gameView.hidden = false;
        databaseView.hidden = true;
        configView.hidden = true;
        
        //初期言語設定
        let defaultLang = NSLocale.preferredLanguages().first;
        print(defaultLang);
        let userDefault: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        if let value = userDefault.stringForKey("lang"){
            print(value);
        }else{
            if(defaultLang!.hasPrefix("ja")){
                userDefault.setObject("ja", forKey: "lang");
            }else{
                userDefault.setObject("en", forKey: "lang");
            }
            userDefault.synchronize();
        }
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //        print("OK");
        switch item.tag{
        case 1: //DB表示
            gameView.hidden = false;
            databaseView.hidden = true;
            configView.hidden = true;
        case 2: //ゲーム画面表示
            gameView.hidden = true;
            databaseView.hidden = false;
            configView.hidden = true;
        case 3: //設定画面
            gameView.hidden = true;
            databaseView.hidden = true;
            configView.hidden = false;
        default:
            return;
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

