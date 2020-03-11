//
//  API.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/02.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import Foundation
import FirebaseFirestore
import UIKit


class CoffeeAPI: DB {
    
    static let shared = CoffeeAPI()
    
    enum FETCH_TYPE {
        case allposts
        case profiles
        case relationship
    }
    
    override init() {
        print("Firebase is now initialized in the Firebase custom parent class")
        super.init()
    }
    
    
    // ALL POSTS
    
    func fetchAllPosts(node: DocumentSnapshot?, category: CATEGORY, completion: @escaping ((DocumentSnapshot?, [CoffeePost]) -> Void)) {
        
        var last_node: DocumentSnapshot? = nil
        
        let ref: Query? = self.root(name: "allposts")
        
        if let snapshot_node = node {
            
            switch category {
            case .all:
                ref?.limit(to: 3).start(afterDocument: snapshot_node)
            case .black:
                ref?.limit(to: 3).whereField("category_type", isEqualTo: "1").start(afterDocument: snapshot_node)
            case .cafelate:
                ref?.limit(to: 3).whereField("category_type", isEqualTo: "2").start(afterDocument: snapshot_node)
            }
            
        } else {
            
            switch category {
            case .all:
                ref?.limit(to: 30)
            case .black:
                ref?.limit(to: 30).whereField("category_type", isEqualTo: "1")
            case .cafelate:
                ref?.limit(to: 30).whereField("category_type", isEqualTo: "2")
            }
        }
        
        ref?.getDocuments { (querysnapshot, error) in
            
            var posts = [CoffeePost]();
            
            if error != nil {
                print("allposts: エラーが発生しました");
                return;
            }
            
            guard let query = querysnapshot else {
                print("queryエラーが発生しました");
                return;
            }
            
            print()
            print(#function, "The count of documents is: ", query.documents.count)
            print()
            
            // LAST NODE IS FOUND
            last_node = query.documents.last
            
            // INSIDE THE LAST NODE
            if let dictionary = last_node?.data() {
                print()
                print("last node is found! The key-values are -- ")
                print(dictionary)
                print()
            }
            
            // LOOP THROUGH THE DOCUMENTS TO MAKE CUSTOM ARRAY AND RETURN IT
            query.documents.forEach({ (snapshot) in
                
                let dictionary = snapshot.data()
                
                // ユーザーについて
                let user_image = dictionary["user_image"] as! String
                let user_name = dictionary["user_name"] as! String
                
                // コーヒーについて
                let coffee_image = dictionary["coffee_image"] as! String
                let caption = dictionary["caption"] as! String
                let coffee_name = dictionary["coffee_name"] as! String
                let coffee_type = dictionary["coffee_type"] as! Int
                let timestamp = dictionary["timestamp"] as! Int
                
                // 評価
                let stars = dictionary["stars"] as! Double
                let liked = dictionary["liked"] as! Bool
                
                // ID
                let post_id = dictionary["post_id"] as! String
                let user_id = dictionary["user_id"] as! String
                
                // 使うかわからないけど、用意しておく
                let lat = dictionary["lat"] as! Int
                let log = dictionary["log"] as! Int
                let location_name = dictionary["location_name"] as! String
                
                // インスタンス化
                let post = CoffeePost(user_image: user_image, user_name: user_name, coffee_image: coffee_image, caption: caption, coffee_name: coffee_name, coffee_type: coffee_type, timestamp: timestamp, stars: stars, liked: liked, post_id: post_id, user_id: user_id, lat: lat, log: log, location_name: location_name)
                posts.append(post)
                
            })
            
            // 最後のデータと取得したデータを返す。
            completion(last_node, posts)
            print("posts are all fetched! Done :) ")
        }
    }
    
    
    private func fetch(type: FETCH_TYPE, completion: @escaping ((QuerySnapshot) -> Void)) {
        switch type {
        case .allposts:
            self.root(name: "allposts").getDocuments { (querysnapshot, error) in
                if error != nil {
                    print("allposts: エラーが発生しました")
                    return;
                }
                guard let query = querysnapshot else {
                    print("queryエラーが発生しました")
                    return
                }
                completion(query)
            }
        case .profiles:
            self.root(name: "profiles").getDocuments { (querysnapshot, error) in
                if error != nil {
                    print("profiles: エラーが発生しました")
                    return;
                }
                guard let query = querysnapshot else {
                    print("queryエラーが発生しました")
                    return
                }
                completion(query)

            }
        case .relationship:
            self.root(name: "relationship").getDocuments { (querysnapshot, error) in
                if error != nil {
                    print("relationship: エラーが発生しました")
                    return;
                }
                guard let query = querysnapshot else {
                    print("queryエラーが発生しました")
                    return
                }
                completion(query)

            }
        }
        

    }
    
    
    
    func post(data: CoffeePost, completion: @escaping(() -> Void)) {
        
        var dictionary = [String:Any]()
        
        // user info
        dictionary["user_image"] = data.user_image
        dictionary["user_name"] = data.user_name
        
        // About coffee
        dictionary["coffee_image"] = data.coffee_image
        dictionary["caption"] = data.caption
        dictionary["coffee_name"] = data.coffee_name
        dictionary["coffee_type"] = data.coffee_type
        dictionary["timestamp"] = data.timestamp
        
        // 評価
        dictionary["stars"] = data.stars
        dictionary["liked"] = data.liked
        
        // ID
        dictionary["post_id"] = data.post_id
        dictionary["user_id"] = data.post_id
        
        // 使うかわからないけど、用意しておく
        dictionary["lat"] = data.lat
        dictionary["log"] = data.log
        dictionary["location_name"] = data.location_name
        
        self.root(name: "allposts").document().setData(dictionary) { (error) in
            guard let err = error else {return}
            print(err.localizedDescription)
            completion()
        }
    }
}

