//
//  ViewController.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/01.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {
    
    static let storyboard_id = "main"
    private let TABLEVIEW_CELL_HEIGHT = 380
    @IBOutlet var tableView: UITableView!

    var pagination: PageTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* データがロードされるタイミング
        
         
         */
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        self.tabBarController?.delegate = self
        
        let nib = UINib(nibName: "FeedTableViewCell", bundle:  nil)
        tableView.register(nib, forCellReuseIdentifier: "FeedTableViewCell")
        
        self.tableView.rowHeight = CGFloat(TABLEVIEW_CELL_HEIGHT)
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.pagination = PageTable(last_node: nil, tableView: self.tableView, category: .all)
        self.pagination.pull()
    }
    
    
    @IBAction func searchPressed(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: CategorySearchViewController.storyboard_id) as! CategorySearchViewController
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    private func fetch() {
        self.pagination.pull()
    }
    
    private func tableFromScratch() {
        self.pagination.clear()
    }
    
}

extension MainViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        if tabBarIndex == 1 {
            print("selected 1")
            self.tabBarController?.selectedIndex = 0
            YPPicker().finish(from: self) { (item) in
                print("Selected done!")
                let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                let viewcontroller = storyboard.instantiateViewController(withIdentifier: PostReviewViewController.storyboard_id) as! PostReviewViewController
                viewcontroller.selected_image = item.originalImage
                self.navigationController?.pushViewController(viewcontroller, animated: true)
            }
        }
    }
    
    
}


extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pagination.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        cell.delegate = self
        cell.profileDelegate = self
        cell.detectDangerousPersonDelegate = self
        cell.configure(posts: self.pagination.posts, indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // ここから違う画面に遷移する
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewController(withIdentifier: ReviewViewController.storyboard_id) as! ReviewViewController
        let selected_data = self.pagination.posts[indexPath.row]
        print(selected_data);
        self.navigationController?.pushViewController(viewcontroller, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}

extension MainViewController : CategorySelectionDelegate {
    
    func display(sender: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            print("IndexPath: ", indexPath.row, " is pressed")
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewcontroller = storyboard.instantiateViewController(withIdentifier: SearchResultViewController.storyboard_id) as! SearchResultViewController
            let selected_data = self.pagination.posts[indexPath.row]
            viewcontroller.search_category = selected_data.coffee_name
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
}

extension MainViewController : ProfileDelegate {
    
    func showProfile(sender: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            print("IndexPath: ", indexPath.row, " is pressed")
            let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
            let viewcontroller = storyboard.instantiateViewController(withIdentifier: ProfileViewController.storyboard_id) as! ProfileViewController
            let selected_data = self.pagination.posts[indexPath.row]
            self.navigationController?.pushViewController(viewcontroller, animated: true)
        }
    }
    
}



extension MainViewController : DetectUserToBeDangerous {
    
    func openOptions(sender: UITableViewCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            let selected_option = self.pagination.posts[indexPath.row]
            print("IndexPath: ", indexPath.row, " is pressed")
            let alert = UIAlertController(title: "選択をしてください", message: "", preferredStyle: .actionSheet)
            let action1 = UIAlertAction(title: "不適切な投稿", style: .default) { ( _ ) in
                SecurityAPI.shared.report(user_id: selected_option.user_id)
            }
            let action2 = UIAlertAction(title: "気分を害した", style: .default) { ( _ ) in
                SecurityAPI.shared.report(user_id: selected_option.user_id)
            }
            let action3 = UIAlertAction(title: "特に理由はない", style: .default) { ( _ ) in
                SecurityAPI.shared.report(user_id: selected_option.user_id)
            }
            let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { ( _ ) in
                
            }
            alert.addAction(action1)
            alert.addAction(action2)
            alert.addAction(action3)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
