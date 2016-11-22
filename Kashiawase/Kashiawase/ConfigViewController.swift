//
//  ConfigViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/21.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class ConfigViewController: UIViewController{
    
    @IBOutlet weak var langLabel: UILabel!
    @IBOutlet weak var JpnBtn: UIButton!
    @IBOutlet weak var EnBtn: UIButton!
    
    let userDefault: NSUserDefaults = NSUserDefaults.standardUserDefaults();
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lang: String! = userDefault.stringForKey("lang");
        print(lang);
        
        if(lang == "ja"){
            langLabel.text = "日本語";
        }else{
            langLabel.text = "English";
        }
    }
    
    @IBAction func changeLang(sender: UIButton) {
        if(sender.tag == 1){
            langLabel.text = "日本語";
            userDefault.setValue("ja", forKey: "lang")
        }else{
            langLabel.text = "English";
            userDefault.setValue("en", forKey: "lang")

        }
        userDefault.synchronize();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}