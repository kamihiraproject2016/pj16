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
    
    let unselectedImages = ["OffIcon1", "OffIcon2", "OffIcon3"];
    let selectedImages = ["OnIcon1", "OnIcon2", "OnIcon3"];
    
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
            
            UITabBar.appearance().tintColor = UIColor(red:0.53, green:0.53, blue:0.53, alpha:1.0);
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

            let navi = self.childViewControllers[1] as? UINavigationController;
            navi?.popToRootViewControllerAnimated(false);
            print(self.childViewControllers[1].childViewControllers);
            
            if(navi?.childViewControllers.count > 0){
                if let database = navi?.childViewControllers[0] as? DataBaseTopViewController{
                    database.langSet();
                    print(database);
                }
                if(navi?.childViewControllers.count > 1){
                    if let database = navi?.childViewControllers[1] as? ListViewController{
                        database.langSet();
                        print(database);
                    }
                    if(navi?.childViewControllers.count > 2){
                        if let database = navi?.childViewControllers[2] as? DetailViewController{
                            database.langSet();
                            print(database);
                        }

                    }
                }
            }

            
        case 2: //ゲーム画面表示
            gameView.hidden = false;
            databaseView.hidden = true;
            configView.hidden = true;

            let navi = self.childViewControllers[0] as? UINavigationController;
            navi?.popToRootViewControllerAnimated(false);
            let game = navi?.childViewControllers[0] as? GameViewController;
            game!.langSet();
            
        case 3: //設定画面
            gameView.hidden = true;
            databaseView.hidden = true;
            configView.hidden = false;
            
            let navi = self.childViewControllers[2] as? UINavigationController;
            navi?.popToRootViewControllerAnimated(false);
            
        default:
            return;
        }
        
//        print(self.childViewControllers);
    }
    
    func langSet(){
        let userDefault: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        let lang: String! = userDefault.stringForKey("lang");
        print(lang);
        
//        cells[0].detailTextLabel?.text = lang;
        if(lang == "日本語"){
            topTabBar.items?[0].title = "カード一覧";
            topTabBar.items?[1].title = "ゲーム";
            topTabBar.items?[2].title = "設定";
            self.title = "設定";
//            cells[0].textLabel?.text = "言語";
        }else{
            topTabBar.items?[0].title = "Cards";
            topTabBar.items?[1].title = "Game";
            topTabBar.items?[2].title = "Config";
            self.title = "Config";
//            cells[0].textLabel?.text = "Language";
        }
    }
    
    override func viewWillAppear(animated: Bool) {

        langSet();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

