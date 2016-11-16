//
//  dataBase.swift
//  Kashiawase
//
//  Created by mi-snow on 2016/11/14.
//  Copyright © 2016年 KamihiraProject. All rights reserved.
//

import Foundation

class dataBase{
    
    init() {
        let (tb, err) = SD.existingTables()
        
        // databaseのパスを表示
        print(SD.databasePath())
    }
}