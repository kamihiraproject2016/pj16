//
//  JpnDetailViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/15.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class JpnDetailViewController: UIViewController {
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelView: UIView!
    
    var labels: Array<UILabel>! = [];
    
    var cardId: Int!;
    var eventFlag: Bool!;
    var seasonTag: Int!;
    
    let seasons: Array<String> = ["春", "夏", "秋", "冬", "通年"];
    var labelName: Array<String>!;
    
    //色設定
    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);
    
    let labelColor = [
        UIColor(red: 0.62, green: 0.25, blue: 0.34, alpha: 1.0),
        UIColor(red: 0.45, green: 0.58, blue: 0.26, alpha: 1.0),
        UIColor(red: 0.71, green: 0.40, blue: 0.26, alpha: 1.0),
        UIColor(red: 0.25, green: 0.48, blue: 0.65, alpha: 1.0),
        UIColor(red: 0.29, green: 0.24, blue: 0.22, alpha: 1.0)
    ];
    
    let bckColor = [
        UIColor(red: 0.96, green: 0.90, blue: 0.91, alpha: 1.0),
        UIColor(red: 0.94, green: 0.96, blue: 0.90, alpha: 1.0),
        UIColor(red: 0.96, green: 0.93, blue: 0.90, alpha: 1.0),
        UIColor(red: 0.90, green: 0.94, blue: 0.96, alpha: 1.0),
        UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
    ];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        labelView.layer.masksToBounds = true;
        labelView.layer.cornerRadius = 6;
//        detailView.layer.borderColor = gray.CGColor;
//        detailView.layer.borderWidth = 1.0;
//        imgView.layer.borderColor = gray.CGColor;
//        imgView.layer.borderWidth = 1.0;
        imgView.clipsToBounds = true;
        
        // サンプルデータ
        var img: UIImage!;
        var contents: Array<String>! = [];
        
        if(eventFlag == true){ //行事
            labelName = ["名前", "日付(季節)", "食べられるお菓子", "目的・由来", "行事について", "現在の形"];
//            contents = ["ひな祭り / Doll’s Festival", seasons[0], "3/3", "ひなあられ、菱餅", "女の子の健康と幸せを祈る", "女の子のいる家庭で雛人形を飾る", "3/3に行われる女の子のためのお祭りです。桃の節句とも呼ばれています。女の子のいる家庭では雛人形を飾ります。雛人形は平安時代の貴族の格好をしていて、女の子の不幸を取り除いてくれると言われています。"];
            var (results, err) = SD.executeQuery("SELECT * FROM db_info_cards WHERE card_id = " + String(cardId));
            if(err != nil){
                
            } else {
//                contents = [];
                for row in results {
                    print(row)
                    img = UIImage(named: "img/" + (row["illust"]?.asString()!)!);
                    contents.append((row["name"]?.asString())! + " / " + (row["name_en"]?.asString())!);
                    seasonTag = row["season"]?.asInt()!;
                }
            }
            (results, err) = SD.executeQuery("SELECT * FROM db_events WHERE card_id = " + String(cardId));
            if(err != nil){
            } else {
                for row in results {
                    contents.append((row["date"]?.asString())! + "(" + seasons[seasonTag! - 1] + ")");
                    contents.append((row["sweets"]?.asString())!);
                    contents.append((row["origin"]?.asString())!);
                    contents.append((row["exp"]?.asString())!);
                    contents.append((row["present"]?.asString())!);
                }
            }
            print(contents)
        }else{ //お菓子
            labelName = ["名前", "季節", "関連行事", "味、食感、香り", "バリエーション", "特産地", "お菓子について"];
//            contents = ["あんみつ", seasons[1], "-", "寒天、赤えんどう豆など様々な味が楽しめる", "クリームあんみつ、白玉あんみつ、フルーツあんみつ", "京都、鎌倉、浅草、上野", "みつまめに餡を盛った菓子。寒天や赤えんどう豆などを乗せ、みつを加えて食べる。夏の風物詩として知られており、京都や鎌倉のあんみつが有名。"];
            var (results, err) = SD.executeQuery("SELECT * FROM db_info_cards WHERE card_id = " + String(cardId));
            if(err != nil){
                
            } else {
//                contents = [];
                for row in results {
                    img = UIImage(named: "img/" + (row["illust"]?.asString()!)!);
                    contents.append((row["name"]?.asString())! + " / " + (row["name_en"]?.asString())!);
                    seasonTag = row["season"]?.asInt()!;
                    contents.append(seasons[seasonTag! - 1]);
                }
            }
            (results, err) = SD.executeQuery("SELECT * FROM db_sweets WHERE card_id = " + String(cardId));
            if(err != nil){
            } else {
                for row in results {
                    contents.append((row["event"]?.asString())!);
                    contents.append((row["taste"]?.asString())!);
                    contents.append((row["variation"]?.asString())!);
                    contents.append((row["special_areas"]?.asString())!);
                    contents.append((row["exp"]?.asString())!);
                }
            }

        }
        
        // イラスト表示
        imgView.image = img;
        
        detailView.superview?.backgroundColor = bckColor[seasonTag - 1];
//        imgView.backgroundColor = UIColor.clearColor()
        
        // 詳細表示
//        print(labelName.endIndex)
        for(var i = 0; i < labelName.count; i++){
            if(contents[i] == "-"){ // なかったらパス
                continue;
            }
            let nameLabel: UILabel = UILabel();
            nameLabel.text = labelName[i];
            nameLabel.textColor = labelColor[seasonTag! - 1];
            nameLabel.numberOfLines = 0;
            nameLabel.sizeToFit();
            nameLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
            nameLabel.translatesAutoresizingMaskIntoConstraints = false;
            
            labelView.addSubview(nameLabel);
            
            if(i == 0){
                labelView.addConstraints([
                    NSLayoutConstraint(
                        item: nameLabel,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: labelView,
                        attribute: NSLayoutAttribute.Top,
                        multiplier: 1.0,
                        constant: 24)
                    ])
            }else{
                labelView.addConstraints([
                    NSLayoutConstraint(
                        item: nameLabel,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: labels[labels.count - 1],
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: 24)
                    ])
            }
            labelView.addConstraints([
                NSLayoutConstraint(
                    item: nameLabel,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: labelView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 24),
                
                NSLayoutConstraint(
                    item: nameLabel,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: labelView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: -24)
                ])
            
            let contentLabel: UILabel = UILabel();
            contentLabel.text = contents[i];
            contentLabel.numberOfLines = 0;
            contentLabel.sizeToFit();
            contentLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
            contentLabel.translatesAutoresizingMaskIntoConstraints = false;

            labelView.addSubview(contentLabel);
            
            labelView.addConstraints([
                NSLayoutConstraint(
                    item: contentLabel,
                    attribute: NSLayoutAttribute.Top,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: nameLabel,
                    attribute: NSLayoutAttribute.Bottom,
                    multiplier: 1.0,
                    constant: 12),
                
                NSLayoutConstraint(
                    item: contentLabel,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: labelView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 24),
                
                NSLayoutConstraint(
                    item: contentLabel,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: labelView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: -24)
                ])
            
            if(i == labelName.endIndex - 1){
                labelView.addConstraints([
                    NSLayoutConstraint(
                        item: contentLabel,
                        attribute: NSLayoutAttribute.Bottom,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: labelView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: -24)
                    ])
            }
            
            labels.append(nameLabel)
            labels.append(contentLabel)

        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}