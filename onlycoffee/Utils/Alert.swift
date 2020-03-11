//
//  Alert.swift
//  onlycoffee
//
//  Created by 新井　崚平 on 2019/04/08.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit
import Foundation


class Alert {
    
    static let shared = Alert()
    
    enum STYLE {
        case `default`
        case destructive
        case cancel
    }
    
    private var alertcontroller: UIAlertController!
    
    init() {
        self.alertcontroller = UIAlertController.init(title: "", message: "", preferredStyle: .alert)
    }
    
    func makeController(title: String?, message: String?) {
        self.alertcontroller = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
    }
    
    func makeAction(title: String?, style: STYLE, callback: @escaping (() -> Void)) -> UIAlertAction {
        var alert: UIAlertAction
        switch style {
        case .default:
            alert = UIAlertAction(title: title, style: .default, handler: { (_) in
                callback()
            })
        case .destructive:
            alert = UIAlertAction(title: title, style: .destructive, handler: { (_) in
                callback()
            })
        case .cancel:
            alert = UIAlertAction(title: title, style: .cancel, handler: { (_) in
                callback()
            })
        }
        return alert
    }
    
    func present(to: UIViewController) {
        to.present(self.alertcontroller, animated: true) {
            print("presented alert controller")
        }
    }
    
    func close(at: UIViewController) {
        self.alertcontroller.dismiss(animated: true, completion: nil)
    }
}



struct SharedManager {
    static let alert = Alert.shared
}









