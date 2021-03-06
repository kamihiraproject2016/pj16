//
//  ConfigViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/21.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class ConfigViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var cells: Array<UITableViewCell> = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションバー設定
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0);
        let backBtn: UIBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        self.navigationItem.backBarButtonItem = backBtn;

        //テーブル設定
        tableView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0);
        tableView.rowHeight = 50;
        tableView.separatorStyle = .None;
//        tableView.layer.borderColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0).CGColor;
        
    }
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "langCell")
        cell.accessoryType = .DisclosureIndicator;
        cell.textLabel!.text = "言語";
        cell.backgroundColor = UIColor.whiteColor();
//        cell.tintColor = UIColor(red: 0.63, green: 0.63, blue: 0.64, alpha: 1.0);
        
        cell.layer.borderColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0).CGColor;
        
        cells.append(cell);
        defaultLangSet();

        return cell;
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //選択を解除
        tableView.deselectRowAtIndexPath(indexPath, animated: false);
        performSegueWithIdentifier("toConfigLang", sender: nil);
    }

    func defaultLangSet(){
        let userDefault: NSUserDefaults = NSUserDefaults.standardUserDefaults();
        let lang: String! = userDefault.stringForKey("lang");
        print(lang);
        
        cells[0].detailTextLabel?.text = lang;
        if(lang == "日本語"){
            self.title = "設定";
            cells[0].textLabel?.text = "言語";
        }else{
            self.title = "Config";
            cells[0].textLabel?.text = "Language";
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        defaultLangSet();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}