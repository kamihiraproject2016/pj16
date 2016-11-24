//
//  GameViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/21.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import UIKit
import Foundation

class GameViewController: UIViewController {
    
    @IBOutlet weak var listView: UIView!
    
    var titleLabels: Array<UILabel> = [];
    
    var icons: Array<Array<Icon>> = [];
    
    // 色データ
    let seasonColor: Array<UIColor> = [
        UIColor(red: 0.94, green: 0.71, blue: 0.76, alpha: 1.0), //春
        UIColor(red: 0.71, green: 0.84, blue: 0.48, alpha: 1.0), //夏
        UIColor(red: 0.96, green: 0.69, blue: 0.44, alpha: 1.0), //秋
        UIColor(red: 0.49, green: 0.68, blue: 0.81, alpha: 1.0), //冬
        UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)  //通年
    ];
    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションバー設定
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        let backBtn: UIBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        self.navigationItem.backBarButtonItem = backBtn;
        self.navigationItem.rightBarButtonItem?.image = self.navigationItem.rightBarButtonItem?.image?.imageWithRenderingMode(.AlwaysOriginal);

        for(var i = 0; i < 8; i++){
            let groupView = UIView();
            let label = UILabel();
            let labelView = UIView();
            var groupIcons: Array<Icon>= [];
            let iconsView = UIView();
            
            // groupView設定
//            groupView.backgroundColor = gray;
            
            listView.addSubview(groupView);
            groupView.translatesAutoresizingMaskIntoConstraints = false;
            
            listView.addConstraints([
                NSLayoutConstraint(
                    item: groupView,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: listView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 24),
                NSLayoutConstraint(
                    item: groupView,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: listView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: 24),
                NSLayoutConstraint(
                    item: groupView,
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: listView,
                    attribute: NSLayoutAttribute.Width,
                    multiplier: 1.0,
                    constant: -CGFloat(24*2))
                ]);
            
            if(i == 0){
                listView.addConstraints([
                    NSLayoutConstraint(
                        item: groupView,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: listView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 24)
                    ])
            }else{
                if(i % 2 == 0){
                    listView.addConstraints([
                        NSLayoutConstraint(
                            item: groupView,
                            attribute: NSLayoutAttribute.Top,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: listView.subviews[i-1],
                            attribute: NSLayoutAttribute.Bottom,
                            multiplier: 1.0,
                            constant: 36)
                        ])
                }else{
                    listView.addConstraints([
                        NSLayoutConstraint(
                            item: groupView,
                            attribute: NSLayoutAttribute.Top,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: listView.subviews[i-1],
                            attribute: NSLayoutAttribute.Bottom,
                            multiplier: 1.0,
                            constant: 12)
                        ])
                }
            }
            if(i == 7){
                listView.addConstraints([
                    NSLayoutConstraint(
                        item: groupView,
                        attribute: NSLayoutAttribute.Bottom,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: listView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: -24)
                    ])
            }
            // label設定
            label.textColor = UIColor.whiteColor();
            label.text = "海鮮丼っぽいもの";
            label.sizeToFit();
            label.numberOfLines = 0;
            label.translatesAutoresizingMaskIntoConstraints = false;
            
            // labelView設定
            labelView.backgroundColor = seasonColor[i / 2];
            labelView.translatesAutoresizingMaskIntoConstraints = false;
            labelView.layer.cornerRadius = 6;
            labelView.layer.masksToBounds = true;
            
            // view設定
            iconsView.backgroundColor = seasonColor[i / 2];
            iconsView.translatesAutoresizingMaskIntoConstraints = false;
            
            titleLabels.append(label);
            
            labelView.addSubview(label);
            groupView.addSubview(labelView);
            groupView.addSubview(iconsView);

            if(i % 2 == 0){
                labelView.addConstraints([
                    NSLayoutConstraint(
                        item: label,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: labelView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 6)
                    ])
                
                groupView.addConstraints([
                    NSLayoutConstraint(
                        item: labelView,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: groupView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 0),
                    NSLayoutConstraint(
                        item: iconsView,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: labelView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: -10),
                    NSLayoutConstraint(
                        item: iconsView,
                        attribute: NSLayoutAttribute.Bottom,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: groupView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: 0)
                    ])
            }else{
                labelView.addConstraints([
                    NSLayoutConstraint(
                        item: label,
                        attribute: NSLayoutAttribute.Bottom,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: labelView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: -6)
                    ])
                
                groupView.addConstraints([
                    NSLayoutConstraint(
                        item: labelView,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: iconsView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: -10),
                    NSLayoutConstraint(
                        item: labelView,
                        attribute: NSLayoutAttribute.Bottom,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: groupView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: 0),
                    NSLayoutConstraint(
                        item: iconsView,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: groupView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 0),
                    ])

            }

            // Autolayout 基本設定
            labelView.addConstraints([
                NSLayoutConstraint(
                    item: label,
                    attribute: NSLayoutAttribute.CenterX,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: labelView,
                    attribute: NSLayoutAttribute.CenterX,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: label,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: labelView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 8),
                NSLayoutConstraint(
                    item: label,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: labelView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: -8)
                ])
            
            groupView.addConstraints([
                NSLayoutConstraint(
                    item: labelView,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: groupView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: labelView,
                    attribute: NSLayoutAttribute.Height,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: label,
                    attribute: NSLayoutAttribute.Height,
                    multiplier: 1.0,
                    constant: CGFloat(6 + 10)),
                NSLayoutConstraint(
                    item: iconsView,
                    attribute: NSLayoutAttribute.Width,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: groupView,
                    attribute: NSLayoutAttribute.Width,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: iconsView,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: groupView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 0),
                NSLayoutConstraint(
                    item: iconsView,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: groupView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: 0)
                ])
            
            // icon設定
            for(var j = 0; j < 4; j++){
                let icon = Icon();
                iconsView.addSubview(icon);
                groupIcons.append(icon);
                
                icon.iconItemSet();
                icon.iconBtn.addTarget(self, action: "iconTap:", forControlEvents: .TouchUpInside)
                
                if(i % 2 == 0){
                    iconsView.addConstraints([
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Top,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView,
                            attribute: NSLayoutAttribute.Top,
                            multiplier: 1.0,
                            constant: 5),
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Bottom,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView,
                            attribute: NSLayoutAttribute.Bottom,
                            multiplier: 1.0,
                            constant: 0)

                        ])
                }else{
                    iconsView.addConstraints([
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Top,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView,
                            attribute: NSLayoutAttribute.Top,
                            multiplier: 1.0,
                            constant: 0),
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Bottom,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView,
                            attribute: NSLayoutAttribute.Bottom,
                            multiplier: 1.0,
                            constant: -5)
                        ])
                    
                }
                if(j == 0){
                    iconsView.addConstraints([
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Leading,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView,
                            attribute: NSLayoutAttribute.Leading,
                            multiplier: 1.0,
                            constant: 0)
                        ])
                }else{
                    iconsView.addConstraints([
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Leading,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView.subviews[j - 1],
                            attribute: NSLayoutAttribute.Trailing,
                            multiplier: 1.0,
                            constant: 0),
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Width,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView.subviews[0],
                            attribute: NSLayoutAttribute.Width,
                            multiplier: 1.0,
                            constant: 0)
                        ])
                }
                if(j == 3){
                    iconsView.addConstraints([
                        NSLayoutConstraint(
                            item: icon,
                            attribute: NSLayoutAttribute.Trailing,
                            relatedBy: NSLayoutRelation.Equal,
                            toItem: iconsView,
                            attribute: NSLayoutAttribute.Trailing,
                            multiplier: 1.0,
                            constant: 0)
                        ])
                }
            }
            icons.append(groupIcons);
        }
        shuffle();
    }
    
    func shuffle(){
        for(var i = 0; i < 4; i++){
            var (results, err) = SD.executeQuery("SELECT * FROM db_groups WHERE season = " + String(i + 1));
            if err != nil{
            } else {
                for(var k = 0; k < 1; k++){
                    let random = Int(arc4random_uniform(UInt32(results.count)));
                    
                    let groupName = results[random]["name"]?.asString()!;
                    var cardIds: Array<Int> = [];
                    cardIds.append((results[random]["sweets_1st_id"]?.asInt())!);
                    cardIds.append((results[random]["sweets_2nd_id"]?.asInt())!);
                    cardIds.append((results[random]["sweets_3rd_id"]?.asInt())!);
                    cardIds.append((results[random]["event_id"]?.asInt())!);
                    
                    titleLabels[i].text = groupName;
                    //                print(groupName);
                    //                print(cardIds);
                    
                    for(var j = 0; j < cardIds.count; j++){
                        let (res, e) = SD.executeQuery("SELECT * FROM db_info_cards WHERE card_id =" + String(cardIds[j]));
                        if e != nil{
                        }else{
//                            print(res);
                            for row in res{
                                if let img = row["illust"]?.asString(){
                                    icons[i][j].iconImgView.image = UIImage(named: "img/" + img);
                                    icons[i][j].iconBtn.tag = (row["card_id"]?.asInt())!;
                                }
                            }
                        }
                    }
                    results.removeAtIndex(random);
                    
                }
            }
        }
    }
    
    @IBAction func iconTap(sender: UIButton){
//        print(sender.tag);
        performSegueWithIdentifier("showDetail", sender: sender)
    }
    
    @IBAction func updateBtn(sender: UIBarButtonItem) {
        let alert: UIAlertController = UIAlertController(title: "新しくゲームを始めますか？", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okBtn: UIAlertAction = UIAlertAction(title: "はい", style: UIAlertActionStyle.Default, handler: {
            (action: UIAlertAction!) -> Void in
            self.shuffle();
        })
        let cancelBtn: UIAlertAction = UIAlertAction(title: "いいえ", style: UIAlertActionStyle.Cancel, handler: {
            (action: UIAlertAction!) -> Void in
        })
        
        alert.addAction(okBtn);
        alert.addAction(cancelBtn);
        
        presentViewController(alert, animated: true, completion: nil);
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

