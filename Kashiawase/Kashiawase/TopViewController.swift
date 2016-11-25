//
//  TestViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/21.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import UIKit
import Foundation

class TopViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var topTabBar: UITabBar!;
    @IBOutlet weak var gameView: UIView!;
    @IBOutlet weak var databaseView: UIView!;
    @IBOutlet weak var configView: UIView!;
    
    let unselectedImages = ["img/off_card.png", "", "img/off_gear.png"];
    let selectedImages = ["img/on_card.png", "", "img/on_gear.png"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // タブバーの設定
        topTabBar.delegate = self;
        for item in topTabBar.items! {
            
            var img1 = UIImage(named: selectedImages[item.tag - 1]);
            img1 = img1?.imageWithRenderingMode(.AlwaysOriginal);
            item.selectedImage = img1;
            var img2 = UIImage(named: unselectedImages[item.tag - 1]);
            img2 = img2?.imageWithRenderingMode(.AlwaysOriginal);
            item.image = img2;
        }

        
        //切り替え設定
        gameView.hidden = false;
        databaseView.hidden = true;
        configView.hidden = true;
        topTabBar.selectedItem = topTabBar.items![1];
        
        //初期言語設定
        let defaultLang = NSLocale.preferredLanguages().first;
        print(defaultLang);
        let userDefault: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        if let value = userDefault.stringForKey("lang"){
            print(value);
        }else{
            if(defaultLang!.hasPrefix("ja")){
                userDefault.setObject("日本語", forKey: "lang");
            }else{
                userDefault.setObject("English", forKey: "lang");
            }
            userDefault.synchronize();
        }
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        //        print("OK");
        switch item.tag{
        case 1: //DB表示
            gameView.hidden = true;
            databaseView.hidden = false;
            configView.hidden = true;
        case 2: //ゲーム画面表示
            gameView.hidden = false;
            databaseView.hidden = true;
            configView.hidden = true;
        case 3: //設定画面
            gameView.hidden = true;
            databaseView.hidden = true;
            configView.hidden = false;
        default:
            return;
        }
        
        if(gameView.hidden == false){
            let navi = self.childViewControllers[0] as? UINavigationController;
            navi?.popToRootViewControllerAnimated(false);
        }else if(configView.hidden == false){
            let navi = self.childViewControllers[2] as? UINavigationController;
            navi?.popToRootViewControllerAnimated(false);
        }
        print(self.childViewControllers);
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

