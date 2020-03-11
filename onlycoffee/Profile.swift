//
//  Profile.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/02.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import Foundation


class Profile {
    var name: String
    var image: String
    var followers: [String]
    var following: [String]
    var favorites: [String]
    var caption: String
    var instagram_account: String
    var twitter_account: String
    
    init(name: String, image: String, followers: [String], following: [String], favorites:[String], caption: String, instagram_account: String = "", twitter_account: String = "") {
        self.name = name
        self.image = image
        self.followers = followers
        self.following = following
        self.favorites = favorites
        self.caption = caption
        self.instagram_account = instagram_account
        self.twitter_account = twitter_account
    }
}

