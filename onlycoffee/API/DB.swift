//
//  DB.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/07.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import Foundation
import Firebase

class DB {
    
    private let db: Firestore!
    
    var user_unique_id: String? {
        guard let id = Auth.auth().currentUser?.uid else {
            print("Idを取得することができませんでした。")
            return nil
        };
        return id
    }
    
    init() {
        db = Firestore.firestore()
        let settings = db.settings
        db.settings = settings
    }
    
    func root(name: String) -> CollectionReference {
        return self.db.collection(name)
    }
    
}

