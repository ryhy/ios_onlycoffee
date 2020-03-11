//
//  ProfileViewController.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    static let storyboard_id = "profile"
    
    var is_some_user: String? = nil
    
    
    @IBOutlet weak var profileOrFollowButton: UIButton!
    
    @IBOutlet var userimage: UIImageView! {
        didSet {
            userimage.setRounded()
        }
    }
    @IBOutlet weak var followingStackView: UIStackView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.followingTapped(sender:)))
            followingStackView.isUserInteractionEnabled = true
            followingStackView.addGestureRecognizer(tap)
        }
    }
    @IBOutlet weak var followersStackView: UIStackView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.followersTapped(sender:)))
            followersStackView.isUserInteractionEnabled = true
            followersStackView.addGestureRecognizer(tap)
        }

    }
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        is_some_user = "jsdkfjslkfjfsldfjskdl"
        
        self.title = "アカウント"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "ProfileCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ProfileCollectionViewCell")
        
        if let _ = is_some_user {
            // follow or unfollow implementation
            self.profileOrFollowButton.backgroundColor = #colorLiteral(red: 0.3019607843, green: 0.7058823529, blue: 0.9764705882, alpha: 1)
            self.profileOrFollowButton.setTitleColor(.white, for: .normal)
            self.profileOrFollowButton.setTitle("フォロー", for: .normal)
        } else {
            // user setting implementation
            self.profileOrFollowButton.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9058823529, blue: 0.9058823529, alpha: 1)
            self.profileOrFollowButton.setTitleColor(.black, for: .normal)
            self.profileOrFollowButton.setTitle("プロフィールを編集", for: .normal)
        }
    }
    
    
    @IBAction func profileEditPressed(_ sender: Any) {
        if let _ = is_some_user {
            // follow or unfollow implementatio
        } else {
            // user setting implementation
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewcontroller = storyboard.instantiateViewController(withIdentifier: EditProfileViewController.storyboard_id) as! EditProfileViewController
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
    
    @objc func followersTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: RelationshipViewController.storyboard_id) as! RelationshipViewController
        viewcontroller.title = "フォロワー"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    @objc func followingTapped(sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: RelationshipViewController.storyboard_id) as! RelationshipViewController
        viewcontroller.title = "フォロー中"
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
}



extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: ReviewViewController.storyboard_id) as! ReviewViewController
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    // UICollectionViewの外周余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.5, left: 0.5, bottom: 1.5, right: 0.5)
    }
    
    // Cellのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize : CGFloat = self.collectionView.bounds.width / 3 - 1.5
        return CGSize(width: cellSize, height: cellSize)
    }
    
    // 行の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // 列の最小余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
