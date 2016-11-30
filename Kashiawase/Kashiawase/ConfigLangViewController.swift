//
//  ConfigLangViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/22.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation
import UIKit

class ConfigLangViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var cells: Array<UITableViewCell> = [];
    
    let userDefault: NSUserDefaults = NSUserDefaults.standardUserDefaults();
    var configLang: String!;
    var systemDefault: String!;
    let langs = ["日本語", "English"];
    let subLangs = ["Japanease", "英語"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ナビゲーションバー設定
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        let backBtn: UIBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        self.navigationItem.backBarButtonItem = backBtn;
        self.navigationItem.title = "設定";
        
        //テーブル設定
        tableView.backgroundColor = UIColor(red: 0.94, green: 0.94, blue: 0.96, alpha: 1.0);
        tableView.rowHeight = 50;
        
        configLang = userDefault.stringForKey("lang");
        print(configLang);
        
        if(NSLocale.preferredLanguages().first!.hasPrefix("ja")){
            systemDefault = "日本語";
        }else{
            systemDefault = "English";
        }
    }
    
    /// セルの個数を指定するデリゲートメソッド（必須）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    /// セルに値を設定するデータソースメソッド（必須）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "langCell")
        cell.accessoryType = .Checkmark;
        cell.tintColor = UIColor.grayColor();
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        cell.textLabel!.text = langs[indexPath.row];
        cell.backgroundColor = UIColor.whiteColor();
        cell.detailTextLabel?.textColor = UIColor.blackColor();
        
        if(langs[indexPath.row] == configLang){
            cell.accessoryType = .Checkmark;
        }else{
            cell.accessoryType = .None;
        }
//        print(defaultLang);
        if(langs[indexPath.row] == systemDefault){
            cell.detailTextLabel?.text = "システムデフォルト";
        }else{
            cell.detailTextLabel?.text = subLangs[indexPath.row];
        }
        
        cells.append(cell);
        return cell;
    }
    
    /// セルが選択された時に呼ばれるデリゲートメソッド
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        userDefault.setObject(langs[indexPath.row], forKey: "lang");
        userDefault.synchronize();
        for(var i = 0; i < cells.count; i++){
            cells[i].accessoryType = .None;
        }
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = .Checkmark;

        print(langs[indexPath.row]);
        defaultLangSet();
    }
    
    func defaultLangSet(){
        let lang: String! = userDefault.stringForKey("lang");
        print(lang);
        
//        cells[0].detailTextLabel?.text = lang;
        if(lang == "日本語"){
            self.title = "設定";
//            cells[0].textLabel?.text = "言語";
        }else{
            self.title = "Config";
//            cells[0].textLabel?.text = "Language";
        }
        
        let top: TopViewController = self.parentViewController?.parentViewController as! TopViewController;
        top.langSet();

    }
    
    override func viewDidAppear(animated: Bool) {
        defaultLangSet();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
