//
//  PhotoSelectViewController.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit
import YPImagePicker
import AVFoundation
import AVKit
import Photos


class PhotoSelectViewController: UIViewController {
    
    static let storyboard_id = "photoselection"
    
    
    let selectedImageV = UIImageView()
    let pickButton = UIButton()
    let resultsButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func showCameraPressed(_ sender: Any) {
        
    }
    
}

