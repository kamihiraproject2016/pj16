//
//  card.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/13.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation

class card:NSObject{
    
    var id:Int
    var image:String
    var jpnName:String
    var enName:String
    
    init(ID:Int, img:String, jpn:String, en:String){
        id = ID
        image = img
        jpnName = jpn
        enName = en
    }

}