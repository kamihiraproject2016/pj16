//
//  ListViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/09.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import UIKit
import Foundation

class ListViewController: UIViewController {
    
    @IBOutlet weak var listView: UIView!;

    var cards: Array<UIView> = [];
    // 1:春、2:夏、3:秋、4:冬、5:通年
    var season: Int!;
    let seasonTitle: Array<String> = ["春のカード", "夏のカード", "秋のカード", "冬のカード", "通年のカード"];
    let seasons: Array<String> = ["春", "夏", "秋", "冬", "通年"];
    
    // テストデータ
//    var cardId: Array<Int> = [1, 2, 3];
//    var cardName: Array<String> = ["あんみつ", "あわだま", "ひなまつり"];
//    var cardEnName: Array<String> = ["Anmitsu", "Awadama", "Doll Festival"];
//    var cardImage: UIImage = UIImage(named: "あんみつ.png")!;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ナビゲーションバーの設定
        //バックボタンの文字削除
        let backBtn: UIBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        self.navigationItem.backBarButtonItem = backBtn;
        
        //タイトルの設定
        self.title = seasonTitle[season];
        
        //DBからのデータ取得
        let result = NSMutableArray();
        let (results, err) = SD.executeQuery("SELECT * FROM db_info_cards WHERE season =" + String(season+1));
        if err != nil{
        } else {
            var count = 0;
            for row in results {
                if let cardId = row["card_id"]?.asInt() {
                    let cardName = row["name"]?.asString()!;
                    let cardEnName = row["name_en"]?.asString()!;
                    let cardImgName = "img/" + (row["illust"]?.asString()!)!;
                    let seasonTag = row["season"]?.asInt()!;
//                    let dic = ["cardId":cardId, "cardName": cardName!, "cardEnName": cardName!, "cardImageName": cardImageName!];
//                    result.addObject(dic);
                    
                    let cardView: Card = Card(name: cardName! + "\n" + cardEnName!, imgName: cardImgName, season: (seasonTag! - 1), id: cardId);
                    
                    listView.addSubview(cardView);
                    cards.append(cardView);
                    
                    cardView.cardBtn.addTarget(self, action: "cardTap:", forControlEvents: .TouchUpInside);
                    
                    // AutoLayout
                    cardView.cardItemSet();
                    cardView.cardSet(results.count, num: count);

                    count++;
                }
            }
        }
        
        print(result.description)
        
    }
    
    @IBAction func cardTap(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
//        performSegueWithIdentifier("test", sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        print(sender)
        if(segue.identifier == "showDetail"){
            let detail: DetailViewController = segue.destinationViewController as! DetailViewController;
            detail.cardId = sender!.tag;
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

