//
//  JpnDetailViewController.swift
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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var tasteLabel: UILabel!
    @IBOutlet weak var variateLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var expLabel: UILabel!

    let seasons: Array<String> = ["Spring", "Summer", "Autumn", "Winter", "All year around"];
    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        detailView.layer.masksToBounds = true;
        detailView.layer.cornerRadius = 6;
        detailView.layer.borderColor = gray.CGColor;
        detailView.layer.borderWidth = 1.0;
        imgView.layer.borderColor = gray.CGColor;
        imgView.layer.borderWidth = 1.0;
        tasteLabel.numberOfLines = 0;
        tasteLabel.sizeToFit();
        tasteLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        variateLabel.numberOfLines = 0;
        variateLabel.sizeToFit();
        variateLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        areaLabel.numberOfLines = 0;
        areaLabel.sizeToFit();
        areaLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        expLabel.numberOfLines = 0;
        expLabel.sizeToFit();
        expLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        
        // サンプルデータ
        let jpnName: String = "あんみつ";
        let enName: String = "anmitsu";
        let img: UIImage = UIImage(named: "あんみつ.png")!;
        let season: String = seasons[1];
        let event: String = "None"
        let variate: String! = "Cream anmitsu,Shiratama anmitsu,Fruit anmitsu"
        let specialAreas: String = "Kyoto, Kmakura, Asakusa, Ueno"
        let tastes: String = "It is agar, a red pea, various taste"
        let exp: String = "The cake which bean jam was served in to look, and to be able to pick it up. Agar or a red pea are ridden and honey is added and is eaten. It is known as a summer feature, and anmitsu of Kyoto and Kamakura is famous."
        
        // データを表示
        imgView.image = img;
        nameLabel.text = jpnName + " / " + enName;
        seasonLabel.text = season;
        tasteLabel.text = tastes;
        variateLabel.text = variate;
        areaLabel.text = specialAreas;
        eventLabel.text = event;
        expLabel.text = exp;
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}