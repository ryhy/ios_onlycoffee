//
//  ReviewViewController.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    
    static let storyboard_id = "reviewcoffee"

    static let COFFEEIMAGE_CELL = "CoffeeImageTableViewCell"
    static let COFFEEINFORMATION_CELL = "CoffeeInfoTableViewCell"
    static let COFFEERATING_CELL = "RatingTableViewCell"
    static let COFFEECOMMENTS_CELL = "CommentTableViewCell"
    static let COFFEECOMMENTFIELD_CELL = "CommentFieldTableViewCell"
    
    @IBOutlet var tableView: UITableView!
    
    private struct ROWS {
        static let IMAGE = 0
        static let INFORMATION = 1
        static let RATING = 2
        static let COMMENTS = 3
    }
    
    private struct SECTIONS {
        static let INFORMATION = 0
        static let COMMENTS = 1
        static let COMMENT_FIELD = 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        // お店のイメージ
        let imageview_nib = UINib(nibName: ReviewViewController.COFFEEIMAGE_CELL, bundle:  nil)
        tableView.register(imageview_nib, forCellReuseIdentifier: ReviewViewController.COFFEEIMAGE_CELL)
        
        // ユーザー情報 / コーヒー情報
        let information_nib = UINib(nibName: ReviewViewController.COFFEEINFORMATION_CELL, bundle:  nil)
        tableView.register(information_nib, forCellReuseIdentifier: ReviewViewController.COFFEEINFORMATION_CELL)
        
        // ユーザー評価
        let rating_nib = UINib(nibName: ReviewViewController.COFFEERATING_CELL, bundle:  nil)
        tableView.register(rating_nib, forCellReuseIdentifier: ReviewViewController.COFFEERATING_CELL)
        
        // コメント欄
        let comment_nib = UINib(nibName: ReviewViewController.COFFEECOMMENTS_CELL, bundle:  nil)
        tableView.register(comment_nib, forCellReuseIdentifier: ReviewViewController.COFFEECOMMENTS_CELL)
        
        let commentFiled_nib = UINib(nibName: "CommentFieldTableViewCell", bundle: nil)
        tableView.register(commentFiled_nib, forCellReuseIdentifier: "CommentFieldTableViewCell")
        
        
        tableView.rowHeight = UITableView.automaticDimension

    }
    
    
    
    private func fetchPostData() {
        
    }
    
    
    
    
    
    
    
}


extension ReviewViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //
        if section == SECTIONS.COMMENTS {
            return 10 // ユーザーのリアルタイムコメントがここに
        } else if section == SECTIONS.COMMENT_FIELD {
            return 1 // リアルタイムコメントをするテキストフィールドをここに
        } else {
            return 3 // その他の情報は、image, info, rating, commentsここに
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTIONS.COMMENTS {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ReviewViewController.COFFEECOMMENTS_CELL, for: indexPath) as! CommentTableViewCell
            return cell
        } else if indexPath.section == SECTIONS.COMMENT_FIELD {
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ReviewViewController.COFFEECOMMENTFIELD_CELL, for: indexPath) as! CommentFieldTableViewCell
            return cell
        } else {
            return organizeVisualInformation(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == SECTIONS.COMMENTS {
            return 80
        } else if indexPath.section == SECTIONS.COMMENT_FIELD {
            return 60
        } else {
            return setHeight(indexPath: indexPath)
        }
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == SECTIONS.COMMENTS {
            return "コメント"
        } else {
            return nil
        }
    }
}



extension ReviewViewController {
    
    private func organizeVisualInformation(indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        switch indexPath.row {
        case ROWS.IMAGE:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ReviewViewController.COFFEEIMAGE_CELL, for: indexPath) as! CoffeeImageTableViewCell
            return cell
        case ROWS.INFORMATION:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ReviewViewController.COFFEEINFORMATION_CELL, for: indexPath) as! CoffeeInfoTableViewCell
            cell.profileDelegate = self
            cell.delegate = self
            return cell
        case ROWS.RATING:
            let cell = self.tableView.dequeueReusableCell(withIdentifier: ReviewViewController.COFFEERATING_CELL, for: indexPath) as! RatingTableViewCell
            cell.delegate = self
            return cell
        default: break;
        }
        return cell
    }
    
    private func triggerAction(at indexPath: Int) {

        switch indexPath {
        case ROWS.IMAGE:
            break;
        case ROWS.INFORMATION:
            break;
        case ROWS.RATING:
            let alertVC = UIAlertController(title: "評価", message: "低 1 - 5 高", preferredStyle: .alert)
            for i in 1...5 {
                let action = UIAlertAction(title: "\(6 - i)", style: .default) { ( _ ) in
                    print("Added: ", 6 - i)
                }
                alertVC.addAction(action)
            }
            let cancel = UIAlertAction(title: "キャンセル", style: .default) { ( _ ) in
                alertVC.dismiss(animated: true, completion: nil)
            }
            alertVC.addAction(cancel)
            self.present(alertVC, animated: true, completion: nil)
        default: break;
        }
    }
    
    private func setHeight(indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case ROWS.IMAGE:
            return 280
        case ROWS.INFORMATION:
            return UITableView.automaticDimension
        case ROWS.RATING:
            return 170
        default: break;
        }
        return 0
    }
    
}


extension ReviewViewController : CategorySelectionDelegate {
    
    func display(sender: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            print("IndexPath: ", indexPath.row, " is pressed")
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewcontroller = storyboard.instantiateViewController(withIdentifier: SearchResultViewController.storyboard_id) as! SearchResultViewController
            viewcontroller.search_category = "ブラック"
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}

extension ReviewViewController : RateDelegate {
    
    func rate(sender: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            if indexPath.row == ROWS.RATING {
                triggerAction(at: ROWS.RATING)
            }
        }
    }
}


extension ReviewViewController : ProfileDelegate {
    
    func showProfile(sender: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            print("IndexPath: ", indexPath.row, " is pressed")
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewcontroller = storyboard.instantiateViewController(withIdentifier: ProfileViewController.storyboard_id) as! ProfileViewController
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
}
