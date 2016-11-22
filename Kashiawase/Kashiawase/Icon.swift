//
//  Icon.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/21.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class Icon: UIView {
    var iconId: Int?;
    var iconImgView: UIImageView;
    var iconBtn: UIButton;
    
    // 色データ
    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);
    
    
    init(){
        iconImgView = UIImageView();
        iconBtn = UIButton();
        
        super.init(frame: CGRectZero);
        
        //view 設定
//        self.layer.cornerRadius = 6;
//        self.layer.masksToBounds = true;
        self.backgroundColor = UIColor.whiteColor();
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = gray.CGColor;
        self.clipsToBounds = true;
        self.translatesAutoresizingMaskIntoConstraints = false;

        // iconImgView 設定
//        iconImgView.image = iconImg;
//        iconImgView.layer.borderWidth = 1.0;
//        iconImgView.layer.borderColor = gray.CGColor;
        iconImgView.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(iconImgView);
        
        // iconBtn 設定
//        iconBtn.tag = iconId;
//        iconBtn.layer.cornerRadius = 6;
//        iconBtn.layer.masksToBounds = true;
        iconBtn.translatesAutoresizingMaskIntoConstraints = false;
        self.addSubview(iconBtn);
 
    }
    
    // AutoLayout アイコン内部設定
    func iconItemSet(){
        // 画像設定
        self.addConstraints([
            NSLayoutConstraint(
                item: self.iconImgView,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: iconImgView,
                attribute: NSLayoutAttribute.Width,
                multiplier: 0.75,
                constant: 0),
            NSLayoutConstraint(
                item: self.iconImgView,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.iconImgView,
                attribute: NSLayoutAttribute.CenterY,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.CenterY,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.iconImgView,
                attribute: NSLayoutAttribute.Height,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Height,
                multiplier: 1.0,
                constant: 0)
            ])
        
//        // タイトル設定
//        self.addConstraints([
//            NSLayoutConstraint(
//                item: self.cardLabel,
//                attribute: NSLayoutAttribute.Leading,
//                relatedBy: NSLayoutRelation.Equal,
//                toItem: self,
//                attribute: NSLayoutAttribute.Leading,
//                multiplier: 1.0,
//                constant: 6),
//            NSLayoutConstraint(
//                item: self.cardLabel,
//                attribute: NSLayoutAttribute.Trailing,
//                relatedBy: NSLayoutRelation.Equal,
//                toItem: self,
//                attribute: NSLayoutAttribute.Trailing,
//                multiplier: 1.0,
//                constant: 6),
//            NSLayoutConstraint(
//                item: self.cardLabel,
//                attribute: NSLayoutAttribute.Top,
//                relatedBy: NSLayoutRelation.Equal,
//                toItem: self.iconImgView,
//                attribute: NSLayoutAttribute.Bottom,
//                multiplier: 1.0,
//                constant: 12)
//            
//            ])
        
        // ボタン設定
        self.addConstraints([
            NSLayoutConstraint(
                item: self.iconBtn,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.iconBtn,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.iconBtn,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: self.iconBtn,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1.0,
                constant: 0)
            
            ])
        
        //基本設定
        self.addConstraints([
            NSLayoutConstraint(
                item: self,
                attribute: NSLayoutAttribute.Width,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self,
                attribute: NSLayoutAttribute.Height,
                multiplier: 1.0,
                constant: 1.0)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
