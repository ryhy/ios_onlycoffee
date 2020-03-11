//
//  RelationshipViewController.swift
//  onlycoffee
//
//  Created by 新井　崚平 on 2019/04/04.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

class RelationshipViewController: UIViewController {

    static let storyboard_id = "relationship"
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension RelationshipViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        return UITableViewCell()
    }
}
