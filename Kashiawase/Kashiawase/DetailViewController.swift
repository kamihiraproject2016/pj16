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

    var cardName: String!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        //DBからのデータ取得
        let (results, err) = SD.executeQuery("SELECT name from db_info_cards where card_id = " + String(cardId));
        if err != nil{
        } else {
            for row in results{
                cardName = row["name"]?.asString()!;
            }
        }
        // ナビゲーションバーの設定
        self.title = cardName;
        
        // タブバーの設定
        changeTabBar.delegate = self;
        changeTabBar.barTintColor = gray;
        changeTabBar.tintColor = UIColor.whiteColor();
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.systemFontOfSize(25.5)], forState: UIControlState.Normal);
        UITabBarItem.appearance().titlePositionAdjustment = UIOffsetMake(0, -9);
        
        // 日英切り替え
        // 日本語設定なら日本語表記 違う場合は英語表記
        let userDefalt: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        if let value = userDefalt.stringForKey("lang"){
            print(value);
            if(value == "ja"){
                JpnView.hidden = false;
                EnView.hidden = true;
            }else{
                JpnView.hidden = true;
                EnView.hidden = false;
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

