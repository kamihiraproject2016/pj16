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
    
    @IBOutlet weak var ChangeTabBar: langTabBar!;
    @IBOutlet weak var JpnView: UIView!;
    @IBOutlet weak var EnView: UIView!;

    var cardId: Int!;
    var season: Int!;

    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);
    
    //色設定
    let tabColor = [
        UIColor(red: 0.96, green: 0.91, blue: 0.95, alpha: 1.0),
        UIColor(red: 0.96, green: 0.96, blue: 0.95, alpha: 1.0),
        UIColor(red: 0.96, green: 0.96, blue: 0.95, alpha: 1.0),
        UIColor(red: 0.95, green: 0.96, blue: 0.96, alpha: 1.0),
        UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
    ];
    
    let langColor = [
        UIColor(red: 0.89, green: 0.48, blue: 0.57, alpha: 1.0),
        UIColor(red: 0.57, green: 0.78, blue: 0.35, alpha: 1.0),
        UIColor(red: 0.95, green: 0.59, blue: 0.31, alpha: 1.0),
        UIColor(red: 0.30, green: 0.57, blue: 0.72, alpha: 1.0),
        UIColor(red: 0.29, green: 0.24, blue: 0.22, alpha: 1.0)
    ];

    var cardName: String!;
    var cardEnName: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //DBからのデータ取得
        let (results, err) = SD.executeQuery("SELECT * from db_info_cards where card_id = " + String(cardId));
        if err != nil{
        } else {
            for row in results{
                cardName = row["name"]?.asString()!;
                cardEnName = row["name_en"]?.asString()!;
                season = row["season"]?.asInt()!;
                season = season - 1;
            }
        }
        // ナビゲーションバーの設定
        self.title = cardName;
        
        // タブバーの設定
        ChangeTabBar.delegate = self;
        ChangeTabBar.barTintColor = tabColor[season];
        UITabBarItem.my_appearanceWhenContainedIn(langTabBar.self).setTitleTextAttributes([
            NSFontAttributeName : UIFont.systemFontOfSize(25.5),
            NSForegroundColorAttributeName:  UIColor(red: 0.50, green: 0.50, blue: 0.50, alpha: 1.0)
            ], forState: UIControlState.Normal);
        UITabBarItem.my_appearanceWhenContainedIn(langTabBar.self).setTitleTextAttributes([
            NSForegroundColorAttributeName: langColor[season]
            ], forState: UIControlState.Selected);
        UITabBarItem.my_appearanceWhenContainedIn(langTabBar.self).titlePositionAdjustment = UIOffsetMake(0, -9);
        
        // 日英切り替え
        // 日本語設定なら日本語表記 違う場合は英語表記
        let userDefalt: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        if let value = userDefalt.stringForKey("lang"){
            print(value);
            if(value == "日本語"){
                JpnView.hidden = false;
                EnView.hidden = true;
                ChangeTabBar.selectedItem = ChangeTabBar.items![0];
            }else{
                JpnView.hidden = true;
                EnView.hidden = false;
                ChangeTabBar.selectedItem = ChangeTabBar.items![1];
            }

        }
    }
    
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
//        print("OK");
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

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        print(sender)
        //DBからのデータ取得
        var eventFlag: Bool!;
        let (results, err) = SD.executeQuery("select event_flg from db_info_cards where card_id = " + String(cardId));
        if err != nil{
        } else {
            for row in results{
                eventFlag = row["event_flg"]?.asBool()!;
            }
        }
        if(segue.identifier == "toJpn"){
            let jpn: JpnDetailViewController = segue.destinationViewController as! JpnDetailViewController;
            jpn.cardId = cardId;
            jpn.eventFlag = eventFlag;
        }else if(segue.identifier == "toEn"){
            let en: EnDetailViewController = segue.destinationViewController as! EnDetailViewController;
            en.cardId = cardId;
            en.eventFlag = eventFlag;
        }
    }

    func langSet(){
        let userDefault: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        let lang: String! = userDefault.stringForKey("lang");
        print(lang);
        
        if(lang == "日本語"){
            self.title = cardName;
            JpnView.hidden = false;
            EnView.hidden = true;
            ChangeTabBar.selectedItem = ChangeTabBar.items![0];
        }else{
            self.title = cardEnName;
            JpnView.hidden = true;
            EnView.hidden = false;
            ChangeTabBar.selectedItem = ChangeTabBar.items![1];
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

