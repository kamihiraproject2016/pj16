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
    
    var cards: Array<UIView> = [];
    @IBOutlet weak var listView: UIView!;

    // 1:春、2:夏、3:秋、4:冬、5:通年
    var season: Int!;
    let seasonTitle: Array<String> = ["春のカード", "夏のカード", "秋のカード", "冬のカード", "通年のカード"];
    
    // 色データ
    let seasonColor: Array<UIColor> = [
        UIColor(red: 0.94, green: 0.71, blue: 0.76, alpha: 1.0), //春
        UIColor(red: 0.71, green: 0.84, blue: 0.48, alpha: 1.0), //夏
        UIColor(red: 0.96, green: 0.69, blue: 0.44, alpha: 1.0), //秋
        UIColor(red: 0.49, green: 0.68, blue: 0.81, alpha: 1.0), //冬
        UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)  //通年
    ];
    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);

    // テストデータ
    var cardId: Int = 1;
    var cardName: String = "あんみつ";
    var cardEnName: String = "Anmitsu";
    var cardImage: UIImage = UIImage(named: "あんみつ.png")!;

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
        var result = NSMutableArray();
        let (results, err) = SD.executeQuery("SELECT * FROM info_cards");
        if err != nil{
        } else {
            for row in results {
                if let id = row["id"]?.asInt() {
                    let name = row["name"]?.asString()!;
                    let dic = ["id":id, "name":name!];
                    result.addObject(dic);
                }
                
            }
        }
        
        print(result.description)
        
        var count: Int = 10;
        
        //カードの作成
        for(var i = 0; i < count; i++){
            //カードの作成ビュー設定
            var cardView: UIView = UIView();
            cardView.backgroundColor = seasonColor[season];
            cardView.layer.cornerRadius = 6;
            cardView.layer.masksToBounds = true;
            cardView.layer.borderWidth = 1.0;
            cardView.layer.borderColor = gray.CGColor;
            cardView.translatesAutoresizingMaskIntoConstraints = false;
            
            var cardImg: UIImageView = UIImageView();
            cardImg.image = cardImage;
            cardImg.layer.borderWidth = 1.0;
            cardImg.layer.borderColor = gray.CGColor;
            cardImg.translatesAutoresizingMaskIntoConstraints = false;
            
            cardView.addSubview(cardImg);
            
            var cardLabel: UILabel = UILabel();
            cardLabel.text = cardName + "\n" + cardEnName;
            cardLabel.numberOfLines = 2;
            cardLabel.textColor = UIColor.whiteColor();
            cardLabel.translatesAutoresizingMaskIntoConstraints = false;
            
            cardView.addSubview(cardLabel);
            
            var cardBtn: UIButton = UIButton();
            cardBtn.tag = cardId;
            cardBtn.layer.cornerRadius = 6;
            cardBtn.layer.masksToBounds = true;
            cardBtn.addTarget(self, action: "cardTap:", forControlEvents: .TouchUpInside);
            cardBtn.translatesAutoresizingMaskIntoConstraints = false;
            
            cardView.addSubview(cardBtn);

            listView.addSubview(cardView);
            
            cards.append(cardView);
            
            //AutoLayout カードの配置
            if(count % 2 == 0){
                if(i == count - 1 || i == count - 2){ //下寄せ
                    listView.addConstraints([
                        NSLayoutConstraint(
                            item: cardView,
                            attribute: NSLayoutAttribute.Bottom,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: listView,
                            attribute: NSLayoutAttribute.Bottom,
                            multiplier: 1.0,
                            constant: 0)
                        ]);
                }

            }else{
                if(i == count - 1){ //下寄せ
                    listView.addConstraints([
                        NSLayoutConstraint(
                            item: cardView,
                            attribute: NSLayoutAttribute.Bottom,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: listView,
                            attribute: NSLayoutAttribute.Bottom,
                            multiplier: 1.0,
                            constant: 0)
                        ]);
                }
            }
            if(i == 0 || i == 1){ //上寄せ
                listView.addConstraints([
                    NSLayoutConstraint(
                        item: cardView,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: listView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 0)
                    ]);
            }else{
                listView.addConstraints([
                    NSLayoutConstraint(
                        item: cardView,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: cards[i - 2],
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: 12)
                    ]);
            }
            if(i % 2 == 0){ //左寄せ
                listView.addConstraints([
                    NSLayoutConstraint(
                        item: cardView,
                        attribute: NSLayoutAttribute.Leading,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: listView,
                        attribute: NSLayoutAttribute.Leading,
                        multiplier: 1.0,
                        constant: 0)
                    ]);
            }else{ //右寄せ
                listView.addConstraints([
                    NSLayoutConstraint(
                        item: cardView,
                        attribute: NSLayoutAttribute.Trailing,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: listView,
                        attribute: NSLayoutAttribute.Trailing,
                        multiplier: 1.0,
                        constant: 0)
                    ]);

            }
            
            listView.addConstraints([
                NSLayoutConstraint(
                    item: cardView,
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: listView,
                    attribute: NSLayoutAttribute.Width,
                    multiplier: 0.49,
                    constant: 0),
                NSLayoutConstraint(
                    item: cardView,
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 0.75,
                    constant: 0)

                ])
            
            // AutoLayout 画像設定
            cardView.addConstraints([
                NSLayoutConstraint(
                    item: cardImg,
                    attribute: NSLayoutAttribute.CenterX,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.CenterX,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: cardImg,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardImg,
                    attribute: NSLayoutAttribute.Width,
                    multiplier: 0.75,
                    constant: 0),
                NSLayoutConstraint(
                    item: cardImg,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 0.70,
                    constant: 0),
                NSLayoutConstraint(
                    item: cardImg,
                    attribute: NSLayoutAttribute.Top,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Top,
                    multiplier: 1.0,
                    constant: 0)
                ])
            
            // AutoLayout タイトル設定
            cardView.addConstraints([
                NSLayoutConstraint(
                    item: cardLabel,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 6),
                NSLayoutConstraint(
                    item: cardLabel,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: 6),
                NSLayoutConstraint(
                    item: cardLabel,
                    attribute: NSLayoutAttribute.Top,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardImg,
                    attribute: NSLayoutAttribute.Bottom,
                    multiplier: 1.0,
                    constant: 12)

                ])
            
            // AutoLayout ボタン設定
            cardView.addConstraints([
                NSLayoutConstraint(
                    item: cardBtn,
                    attribute: NSLayoutAttribute.Top,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Top,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: cardBtn,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: cardBtn,
                    attribute: NSLayoutAttribute.Bottom,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Bottom,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: cardBtn,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: cardView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: 0)

                ])

        }

    }
    
    @IBAction func cardTap(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //        print(sender)
        let detail: DetailViewController = segue.destinationViewController as! DetailViewController
        detail.cardId = sender!.tag
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

