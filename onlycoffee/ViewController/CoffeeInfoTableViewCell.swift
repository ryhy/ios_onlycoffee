//
//  CoffeeInfoTableViewCell.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit



class CoffeeInfoTableViewCell: UITableViewCell {

    @IBOutlet var categoryButton: ShadowButton!
    @IBOutlet weak var stackview: UIStackView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.profilePressed(sender:)))
            stackview.isUserInteractionEnabled = true
            stackview.addGestureRecognizer(tap)
        }
    }
    @IBOutlet var userimage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.profilePressed(sender:)))
            userimage.isUserInteractionEnabled = true
            userimage.addGestureRecognizer(tap)
        }
    }
    var delegate: CategorySelectionDelegate? = nil
    var profileDelegate:ProfileDelegate? = nil;
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.userimage.setRounded()
    }
    
    @objc func profilePressed(sender: UITapGestureRecognizer) {
        print(#function, " 実行されました。")
        self.profileDelegate?.showProfile(sender: self)
    }
    
    
    @IBAction func categoryPressed(_ sender: Any) {
        self.delegate?.display(sender: self)
    }
    
}
