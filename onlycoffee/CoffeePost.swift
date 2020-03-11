//
//  Post.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/02.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import Foundation

class CoffeePost {
    
    let user_image: String
    let user_name: String
    
    // About coffee
    let coffee_image: String
    let caption: String
    let coffee_name: String
    let coffee_type: Int
    let timestamp: Int
    
    // 評価
    let stars: Double
    let liked: Bool
    
    // ID
    let post_id: String
    let user_id: String
    
    // 使うかわからないけど、用意しておく
    let lat: Int
    let log: Int
    let location_name: String
    
    init(
        user_image: String, user_name: String,
        coffee_image: String, caption: String, coffee_name: String, coffee_type: Int, timestamp: Int,
        stars: Double, liked: Bool,
        post_id: String, user_id: String,
        lat: Int, log: Int, location_name: String) {
        
        self.user_image = user_image
        self.user_name = user_name
        
        self.coffee_image = coffee_image
        self.caption = caption
        self.coffee_name = coffee_name
        self.coffee_type = coffee_type
        self.timestamp = timestamp
        
        self.stars = stars
        self.liked = liked
        
        self.post_id = post_id
        self.user_id = user_id
        
        self.lat = lat
        self.log = log
        self.location_name = location_name
    }
}
