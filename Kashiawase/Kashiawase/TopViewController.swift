//
//  ViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/02.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import UIKit

class TopViewController: UIViewController {

    @IBOutlet var seasonBtns: [UIButton]!;
    @IBOutlet var cardViews: [UIView]!
    @IBOutlet var cardImgs: [UIImageView]!
    @IBOutlet var cardLabels: [UILabel]!
    
    @IBOutlet weak var searchBar: UISearchBar!

    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ナビゲーションバー設定
        self.navigationController?.navigationBar.barTintColor = gray
        let backBtn: UIBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        
        self.navigationItem.backBarButtonItem = backBtn;

        //サーチバー設定
        searchBar.barTintColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0);

        //各ボタン調整
        for view in cardViews{
            view.layer.cornerRadius = 6;
            view.layer.masksToBounds = true;
            view.layer.borderWidth = 1.0;
            view.layer.borderColor = gray.CGColor
        }
        
        for img in cardImgs{
            img.layer.borderWidth = 1.0;
            img.layer.borderColor = gray.CGColor
        }
        
        for label in cardLabels{
            label.textColor = UIColor.whiteColor();
        }
        
        for btn in seasonBtns{
            btn.layer.cornerRadius = 6;
            btn.layer.masksToBounds = true;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cardTap(sender: UIButton) {
        performSegueWithIdentifier("toList", sender: sender);
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print(sender)
        // tag 1:春、2:夏、3:秋、4:冬、5:通年
        let list: ListViewController = segue.destinationViewController as! ListViewController;
        list.season = sender!.tag;
    }
}

