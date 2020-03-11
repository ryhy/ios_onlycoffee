//
//  SecurityAPI.swift
//  onlycoffee
//
//  Created by 新井　崚平 on 2019/04/08.
//  Copyright © 2019 ryohei. All rights reserved.
//

import Foundation
import FirebaseFirestore


class SecurityAPI : DB {
    
    static let shared = SecurityAPI()
    
    override init() {
        print("Firebase is now initialized in the Firebase custom parent class")
        super.init()
    }
    
    // MARK - REPORT USER
    
    func report(user_id: String) {
        let ref = self.root(name: "block_users");
        ref.getDocuments { (querysnapshot, error) in
            guard let err = error else {return}
            print(err.localizedDescription)
            guard let documents = querysnapshot?.documents else { return }
            guard !documents.isEmpty else {
                print(#function, "documents are empty :( ")
                return
            }
            let user = documents.filter { $0.data()["user_id"] as! String == user_id }[0];
            var count = user.data()["count"] as! Int
            var isBlocked = user.data()["isBlocked"] as! Bool
            count += 1
            if (count > 2) { isBlocked = true }
            let save_data = ["user_id": user_id, "isBlocked": isBlocked, "count": count] as [String : Any]
            ref.document(user_id).setData(save_data) { (error) in
                guard let err = error else { return }
                print(err.localizedDescription)
            }
        }
    }
    
    func check_userBlockStatus(user_id: String, completion: @escaping ((Bool) -> Void)) {
        self.root(name: "block_users").document(user_id).getDocument { (query, error) in
            guard let err = error else { return }
            print(err.localizedDescription)
            let isBlocked = query?.data()?["isBlocked"] as! Bool
            completion(isBlocked)
        }
    }
}
