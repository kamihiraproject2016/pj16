//
//  EnDetailViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/15.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class EnDetailViewController: UIViewController {
    
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    var labels: Array<UILabel>! = [];
    
    var cardId: Int!;
    var eventFlag: Bool!;
    var seasonTag: Int!;
    
    let enSeasons: Array<String> = ["spring", "summer", "autumn", "winter", "all year around"];
    let seasons: Array<String> = ["Spring", "Summer", "Autumn", "Winter", "All year around"];
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

        detailView.layer.masksToBounds = true;
        detailView.layer.cornerRadius = 6;
//        detailView.layer.borderColor = gray.CGColor;
//        detailView.layer.borderWidth = 1.0;
//        imgView.layer.borderColor = gray.CGColor;
//        imgView.layer.borderWidth = 1.0;
        
        // サンプルデータ
        var img: UIImage!;
        var contents: Array<String>! = [];
        
        if(eventFlag == true){ //行事
            labelName = ["Name", "Date(Season)", "Related wagashi", "The purpose and history", "About the event", "The present state"];
//            contents = ["Doll’s Festival", seasons[0], "March 3rd", "Hinaarare, Hishi Mochi", "It is a day to pray for the health and happiness of young girls.", "Families with girls display Hina Ningyo, which means Hina dolls.", "It is a festival for girls  which is on March 3rd.It is also called 'Momo no Sekku', which means 'Peach Festival'. Families with girls display Hina dolls. Hina dolls wear Heian period court costumes, and it is said that Hina dolls take away the bad luck of the girls who own them."];
            var (results, err) = SD.executeQuery("SELECT * FROM db_info_cards WHERE card_id = " + String(cardId));
            if(err != nil){
                
            } else {
//                contents = [];
                for row in results {
                    print(row)
                    img = UIImage(named: "img/" + (row["illust"]?.asString()!)!);
                    contents.append((row["name_en"]?.asString())! + " / " + (row["name"]?.asString())!);
                    seasonTag = row["season"]?.asInt()!;
                }
            }
            (results, err) = SD.executeQuery("SELECT * FROM db_events_en WHERE card_id = " + String(cardId));
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

        }else{ //お菓子
            labelName = ["Name", "Season", "Related event", "The taste, the food texture and the aroma", "Variation", "Special production localities", "About this wagashi"];
//            contents = ["anmitsu", seasons[1], "-", "It is agar, a red pea, various taste", "Cream Anmitsu, Shiratama Anmitsu, Fruit Anmitsu", "Kyoto, Kmakura, Asakusa, Ueno", "The cake which Anko was served in to look, and to be able to pick it up. Agar or a red pea are ridden and honey is added and is eaten. It is known as a summer feature, and anmitsu of Kyoto and Kamakura is famous."];
            var (results, err) = SD.executeQuery("SELECT * FROM db_info_cards WHERE card_id = " + String(cardId));
            if(err != nil){
                
            } else {
                print(results);
                for row in results {
                    print(row["season"]?.asInt());
                    img = UIImage(named: "img/" + (row["illust"]?.asString()!)!);
                    contents.append((row["name_en"]?.asString())! + " / " + (row["name"]?.asString())!);
                    seasonTag = row["season"]?.asInt()!;
                    contents.append(seasons[seasonTag! - 1]);
                }
            }
            (results, err) = SD.executeQuery("SELECT * FROM db_sweets_en WHERE card_id = " + String(cardId));
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
        imgView.backgroundColor = bckColor[seasonTag - 1];
        
        // 詳細表示
        print(contents);
        print(labelName.count);
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
            
            detailView.addSubview(nameLabel);
            
            if(i == 0){
                detailView.addConstraints([
                    NSLayoutConstraint(
                        item: nameLabel,
                        attribute: NSLayoutAttribute.Top,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: imgView,
                        attribute: NSLayoutAttribute.Bottom,
                        multiplier: 1.0,
                        constant: 24)
                    ])
            }else{
                detailView.addConstraints([
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
            detailView.addConstraints([
                NSLayoutConstraint(
                    item: nameLabel,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: detailView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 24),
                
                NSLayoutConstraint(
                    item: nameLabel,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: detailView,
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
            
            detailView.addSubview(contentLabel);
            
            detailView.addConstraints([
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
                    toItem: detailView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 24),
                
                NSLayoutConstraint(
                    item: contentLabel,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: detailView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: -24)
                ])
            
            if(i == labelName.endIndex - 1){
                detailView.addConstraints([
                    NSLayoutConstraint(
                        item: contentLabel,
                        attribute: NSLayoutAttribute.Bottom,
                        relatedBy: NSLayoutRelation.Equal,
                        toItem: detailView,
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