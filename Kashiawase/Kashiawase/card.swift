//
//  card.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/17.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class Card: UIView {
    var cardName: String;
    var cardImg: UIImage?;
    var seasonTag: Int;
    var cardId: Int;
    var cardImgView: UIImageView;
    var cardLabel: UILabel;
    var cardBtn: UIButton;
    
    // 色データ
    let seasonColor: Array<UIColor> = [
        UIColor(red: 0.94, green: 0.71, blue: 0.76, alpha: 1.0), //春
        UIColor(red: 0.71, green: 0.84, blue: 0.48, alpha: 1.0), //夏
        UIColor(red: 0.96, green: 0.69, blue: 0.44, alpha: 1.0), //秋
        UIColor(red: 0.49, green: 0.68, blue: 0.81, alpha: 1.0), //冬
        UIColor(red: 0.77, green: 0.77, blue: 0.77, alpha: 1.0)  //通年
    ];
    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);

    
    init(name :String, imgName: String, season: Int, id: Int){
        cardName = name;
        cardImg = UIImage(named: imgName);
        seasonTag = season;
        cardId = id;
        
        cardImgView = UIImageView();
        cardLabel = UILabel();
        cardBtn = UIButton();
        
        super.init(frame: CGRectZero);
        
        //view 設定
        self.backgroundColor = seasonColor[seasonTag];
        self.layer.cornerRadius = 6;
        self.layer.masksToBounds = true;
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = gray.CGColor;
        self.translatesAutoresizingMaskIntoConstraints = false;
        
        // cardImgView 設定
        cardImgView.image = cardImg;
        cardImgView.backgroundColor = UIColor.whiteColor();
        cardImgView.layer.borderWidth = 1.0;
        cardImgView.layer.borderColor = gray.CGColor;
        cardImgView.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(cardImgView);
        
        // cardLabel 設定
        cardLabel.text = cardName;
        cardLabel.numberOfLines = 3;
        cardLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        cardLabel.textColor = UIColor.whiteColor();
        cardLabel.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(cardLabel);
        
        // cardBtn 設定
        cardBtn.tag = cardId;
        cardBtn.layer.cornerRadius = 6;
        cardBtn.layer.masksToBounds = true;
        cardBtn.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(cardBtn);
    }
    
    // AutoLayout カード内部設定
    func cardItemSet(){
        // 画像設定
        self.addConstraints([
            NSLayoutConstraint(
                item: self.cardImgView,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.cardImgView,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: cardImgView,
                attribute: NSLayoutAttribute.Width,
                multiplier: 0.75,
                constant: 0),
            NSLayoutConstraint(
                item: self.cardImgView,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Height,
                multiplier: 0.60,
                constant: 0),
            NSLayoutConstraint(
                item: self.cardImgView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0)
            ])
        
        // タイトル設定
        self.addConstraints([
            NSLayoutConstraint(
                item: self.cardLabel,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1.0,
                constant: 6),
            NSLayoutConstraint(
                item: self.cardLabel,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1.0,
                constant: 6),
            NSLayoutConstraint(
                item: self.cardLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.cardImgView,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 12)
            
            ])
        
        // ボタン設定
        self.addConstraints([
            NSLayoutConstraint(
                item: self.cardBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.cardBtn,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.cardBtn,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.cardBtn,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1.0,
                constant: 0)
            
            ])
    }
    
    //AutoLayout カード設定
    func cardSet(superView :UIView){
        superView.addConstraints([
            NSLayoutConstraint(
                item: self,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superView,
                attribute: NSLayoutAttribute.Width,
                multiplier: 0.49,
                constant: 0),
            NSLayoutConstraint(
                item: self,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Height,
                multiplier: 0.80,
                constant: 0)
            
            ])
    }
    
    //AutoLayout カード配置設定
    func cardSet(superView :UIView, max :Int, num :Int){
        
        var rightFlag: Bool = false;
        var bottomFlag: Bool = false;
        var displacement: CGFloat; //上からの擦れ
        
        //初期設定
        if (num % 2 != 0){ rightFlag = true; }
        if (num + 1 == max){ bottomFlag = true; }
        
        //下寄せ
        if(bottomFlag){
            superView.addConstraints([
                NSLayoutConstraint(
                    item: self,
                    attribute: NSLayoutAttribute.Bottom,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: superView,
                    attribute: NSLayoutAttribute.Bottom,
                    multiplier: 1.0,
                    constant: 0)
                ]);
        }
        
        if(rightFlag){
            superView.addConstraints([
                NSLayoutConstraint(
                    item: self,
                    attribute: NSLayoutAttribute.Trailing,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: superView,
                    attribute: NSLayoutAttribute.Trailing,
                    multiplier: 1.0,
                    constant: 0)
                ]);
        }else{
            superView.addConstraints([
                NSLayoutConstraint(
                    item: self,
                    attribute: NSLayoutAttribute.Leading,
                    relatedBy: NSLayoutRelation.Equal,
                    toItem: superView,
                    attribute: NSLayoutAttribute.Leading,
                    multiplier: 1.0,
                    constant: 0)
                ]);
        }
        
        // 上からの擦れの計算
        self.layoutIfNeeded();
        displacement = (self.layer.bounds.height + 12) * CGFloat(Int(num / 2));
//        print("num : " + String(num));
//        print(Int(num / 2));
//        print(self.layer.bounds.height);
//        print(Int(displacement));

        superView.addConstraints([
            NSLayoutConstraint(
                item: self,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: displacement)
            ]);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
