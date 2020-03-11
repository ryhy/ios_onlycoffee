//
//  Pagination.swift
//  onlycoffee
//
//  Created by 新井　崚平 on 2019/04/08.
//  Copyright © 2019 ryohei. All rights reserved.
//

import Foundation
import FirebaseFirestore
import UIKit


class PageTable {
    
    var last_node: DocumentSnapshot?
    var tableView: UITableView
    var category: CATEGORY
    
    private var is_first_time = true
    var posts: [CoffeePost] = [CoffeePost]()
    
    init(last_node: DocumentSnapshot?, tableView: UITableView, category: CATEGORY = .all) {
        self.last_node = last_node
        self.tableView = tableView
        self.category = category
    }
    
    func pull() {
        
        i.on()
        // 一回目は、ゼロからデータを取得する。
        if is_first_time {
            
            // 次回から2回目なのでここで値を置き換える。
            is_first_time = false
            
            // 0番目からデータを取得する
            CoffeeAPI.shared.fetchAllPosts(node: nil, category: self.category) { node, posts  in
                
                // サーバーからデータを取得したことを保証する。
                if !posts.isEmpty {
                    self.last_node = node;
                    self.posts = posts.sorted(by: { (left, right) -> Bool in
                        return left.timestamp > right.timestamp
                    })
                    self.tableView.reloadData();
                    print(#function, " posts are not empty. Reloading tableview");
                    i.off()
                } else {
                    // エラー。取得することができなかったから、
                    // ここで、データを作るようにユーザーを促す？
                    print(#function, "posts are empty");
                    i.off()
                }
            }
            
        } else {
            
            // 2回目以降のフェッチは、かlast node以降のデータ。
            CoffeeAPI.shared.fetchAllPosts(node: last_node, category: self.category) { node, posts in
                self.last_node = node
                self.posts = posts
                self.tableView.reloadData()
                i.off()
            }
            
        }
    }
    
    func clear() {
        self.is_first_time = true
        self.last_node = nil
        self.posts = []
    }
    

}



