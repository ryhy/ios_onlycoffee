//
//  PostReviewViewController.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

class PostReviewViewController: UIViewController {

    static let storyboard_id = "postreview"
    
    
    @IBOutlet var postImage: UIImageView! {
        didSet {
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped(_:)))
            postImage.isUserInteractionEnabled = true
            postImage.addGestureRecognizer(tap)
        }
    }
    
    
    var selected_image: UIImage? = nil;
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = selected_image {
            self.postImage.image = img        }
    }

    @IBAction func postPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
}




