//
//  FeedTableViewCell.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

protocol CategorySelectionDelegate {
    func display(sender: UITableViewCell)
}

protocol ProfileDelegate {
    func showProfile(sender: UITableViewCell)
}

protocol DetectUserToBeDangerous {
    func openOptions(sender: UITableViewCell)
}

class FeedTableViewCell: UITableViewCell {

    @IBOutlet var userImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.profilePressed(sender:)))
            userImage.isUserInteractionEnabled = true
            userImage.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var postCommentLabel: UILabel!
    @IBOutlet var coffeeTypeButton: ShadowButton!
    @IBOutlet weak var reportButton: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.openReportOptions(sender:)))
            reportButton.isUserInteractionEnabled = true
            reportButton.addGestureRecognizer(tap)
        }
    }
    
    
    @IBOutlet private var cardview: UIView! {
        didSet {
//             Make it card-like
            cardview.layer.cornerRadius = 13
            cardview.layer.shadowOpacity = 0.5
            cardview.layer.shadowRadius = 6
            cardview.layer.shadowColor = UIColor.lightGray.cgColor
            cardview.layer.shadowOffset = CGSize(width: 2, height: 2)
        }
    }
    
    @IBOutlet private var clippingview: UIView! {
        didSet {
            clippingview.layer.cornerRadius = 13
            clippingview.backgroundColor = UIColor.white
            clippingview.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var stackview: UIStackView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.profilePressed(sender:)))
            stackview.isUserInteractionEnabled = true
            stackview.addGestureRecognizer(tap)
        }
    }
    
    
    // DELEGATES :
    
    var delegate:CategorySelectionDelegate? = nil;
    var profileDelegate:ProfileDelegate? = nil;
    var detectDangerousPersonDelegate:DetectUserToBeDangerous? = nil;
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let customeinsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//        contentView.frame = contentView.frame.inset(by: customeinsets)
//        self.addShadowEffect()
        self.userImage.setRounded()
    }
    
    
    func configure(posts: [CoffeePost], indexPath: IndexPath) {
        let post = posts[indexPath.row]
        self.coffeeTypeButton.setTitle(coffeeName(coffeetype: post.coffee_type), for: .normal)
        self.username.text = post.user_name
        self.timestamp.text = "\(post.timestamp)"
        self.postCommentLabel.text = post.caption
    }
    
    func coffeeName(coffeetype: Int) -> String {
        switch coffeetype {
        case 1:
            return "ブラック"
        case 2:
            return "カフェモカ"
        case 3:
            return "エスプレッソ"
        case 4:
            return "ソイラテ"
        case 5:
            return "ラテ"
        case 6:
            return "ラテアート"
        default:
            return ""
        }
    }
    
    private func addShadowEffect() {
        self.layer.shadowOpacity = 0.18
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
    
    @objc func profilePressed(sender: UITapGestureRecognizer) {
        print(#function, " 実行されました。")
        self.profileDelegate?.showProfile(sender: self)
    }
    
    @objc func openReportOptions(sender: UITapGestureRecognizer) {
        self.detectDangerousPersonDelegate?.openOptions(sender: self)
    }
    
    @IBAction func display(_ sender: Any) {
        print("display button is pressed! Feed tableViewCell")
        self.delegate?.display(sender: self)
    }
    
}

