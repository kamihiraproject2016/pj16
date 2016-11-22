//
//  ViewController.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/02.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import UIKit

class DataBaseTopViewController: UIViewController, UISearchBarDelegate, UITabBarControllerDelegate {

    @IBOutlet weak var listView: UIView!;
    @IBOutlet weak var searchBar: UISearchBar!;
    
//    var cards: Array<UIView> = [];
    var cards: Array<Card> = [];
    var searchCards: Array<Card> = [];
    
    let gray: UIColor = UIColor(red: 0.69, green: 0.69, blue: 0.70, alpha: 1.0);
    
    //季節のカードデータ
    let cardName: Array<String>! = ["春のカード\nSpring", "夏のカード\nSummer", "秋のカード\nAutumn", "冬のカード\nWinter", "通年のカード\nAll year around"];
    let cardImgName: Array<String>! = ["img/あんみつ.png", "img/あんみつ.png", "img/あんみつ.png", "img/あんみつ.png", "img/あんみつ.png"];
    
    var modalView: UIView!;
    var searchTextLabel: UILabel!;

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //ナビゲーションバー設定
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.98, green: 0.98, blue: 0.98, alpha: 1.0)
        let backBtn: UIBarButtonItem = UIBarButtonItem.init(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil);
        self.navigationItem.backBarButtonItem = backBtn;

        //サーチバー設定
        searchBar.delegate = self;
        searchBar.barTintColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0);
        searchBar.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0).CGColor;
        searchBar.layer.borderWidth = 1.0;
        searchBar.placeholder = "お菓子、行事の検索";
        searchBar.tintColor = UIColor.whiteColor();
        UITextField.my_appearanceWhenContainedIn(UISearchBar.self).tintColor = UIColor.blueColor()
        
        //季節のカードの作成
        for(var i = 0; i < 5; i++){
            let cardView: Card = Card(name: cardName[i], imgName: cardImgName[i], season: i, id: i);
            
            listView.addSubview(cardView);
            cards.append(cardView);
            
            cardView.cardBtn.addTarget(self, action: "seasonCardTap:", forControlEvents: .TouchUpInside);

            // AutoLayout
            cardView.cardItemSet();
            cardView.cardSet(5, num: i);
        }

        //モーダルビュー設定
        modalView = UIView();
        modalView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.60);
        modalView.translatesAutoresizingMaskIntoConstraints = false;
        self.view.addSubview(modalView)
        
        self.view.addConstraints([
            NSLayoutConstraint(
                item: modalView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: searchBar,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: modalView,
                attribute: NSLayoutAttribute.Leading,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.Leading,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: modalView,
                attribute: NSLayoutAttribute.Trailing,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.Trailing,
                multiplier: 1.0,
                constant: 0),
            NSLayoutConstraint(
                item: modalView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: self.view,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: 0)
            ]);
        modalView.hidden = true;
        
        //検索結果が見つからなかった時
        searchTextLabel = UILabel();
        searchTextLabel.text = "検索結果が見つかりませんでした。\nSearch results could not be found.";
        searchTextLabel.textAlignment = NSTextAlignment.Center;
        searchTextLabel.numberOfLines = 2;
        searchTextLabel.sizeToFit();
        searchTextLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping;
        searchTextLabel.translatesAutoresizingMaskIntoConstraints = false;
        
        listView.addSubview(searchTextLabel);

        listView.addConstraints([
            NSLayoutConstraint(
                item: searchTextLabel,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: listView,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: 45),
            NSLayoutConstraint(
                item: searchTextLabel,
                attribute: NSLayoutAttribute.CenterX,
                relatedBy: NSLayoutRelation.Equal,
                toItem: listView,
                attribute: NSLayoutAttribute.CenterX,
                multiplier: 1.0,
                constant: 0)
            ])
        
        searchTextLabel.hidden = true;
        
    }

    @IBAction func seasonCardTap(sender: UIButton) {
        performSegueWithIdentifier("toList", sender: sender);
        
    }

    @IBAction func sweetsCardTap(sender: UIButton) {
        performSegueWithIdentifier("showDetail", sender: sender);
        
    }

    // サーチバーの設定
    override func viewWillAppear(animated: Bool) {
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "keyboardShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func keyboardShow(notification: NSNotification){
        searchBar.showsCancelButton = true;
        modalView.hidden = false;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false;
        modalView.hidden = true;
        searchTextLabel.hidden = true;
        searchBar.resignFirstResponder();
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        for card in cards{
            card.hidden = false;
        }
        for card in searchCards{
            card.removeFromSuperview();
        }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.showsCancelButton = false;
        modalView.hidden = true;
        searchBar.resignFirstResponder();
        self.navigationController?.setNavigationBarHidden(false, animated: true);
        
        //検索結果の初期化
        for card in searchCards{
            card.removeFromSuperview();
        }
        searchCards = [];
        
        for card in cards{
            card.hidden = true;
        }
        
        let searchText: String? = searchBar.text;
        print("検索ワード " + searchText!);
        
        let (results, err) = SD.executeQuery("SELECT * FROM db_info_cards WHERE name LIKE '%" + searchText! + "%' OR name_en LIKE '%" + searchText! + "%' OR ruby LIKE '%" + searchText! + "%'");
        if (results.count == 0){
//            print(err);
            print(results);
            searchTextLabel.hidden = false;
        }else{
            print("検索完了!");
            print(results);
            searchTextLabel.hidden = true;
            var count = 0;
            for row in results{
                if let cardId = row["card_id"]?.asInt() {
                    let cardName = row["name"]?.asString()!;
                    let cardEnName = row["name_en"]?.asString()!;
                    let cardImgName = "img/" + (row["illust"]?.asString()!)!;
                    let seasonTag = row["season"]?.asInt()!;
                    
                    let cardView: Card = Card(name: cardName! + "\n" + cardEnName!, imgName: cardImgName, season: seasonTag!, id: cardId);
                    
                    listView.addSubview(cardView);
                    searchCards.append(cardView);
                    
                    cardView.cardBtn.addTarget(self, action: "sweetsCardTap:", forControlEvents: .TouchUpInside);
                    
                    // AutoLayout
                    cardView.cardItemSet();
                    cardView.cardSet(results.count, num: count);

                }
                count++;
            }
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        print(sender)
        // tag 1:春、2:夏、3:秋、4:冬、5:通年
        if(segue.identifier == "toList"){
            let list: ListViewController = segue.destinationViewController as! ListViewController;
            list.season = sender!.tag;
        }else if(segue.identifier == "showDetail"){
            let detail: DetailViewController = segue.destinationViewController as! DetailViewController;
            detail.cardId = sender!.tag;
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

