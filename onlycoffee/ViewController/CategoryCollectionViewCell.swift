//
//  CategoryCollectionViewCell.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet var genreImageView: UIImageView! {
        didSet {
            genreImageView.layer.masksToBounds = true
            genreImageView.layer.cornerRadius = 12
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
