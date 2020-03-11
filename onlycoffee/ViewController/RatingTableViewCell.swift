//
//  RatingTableViewCell.swift
//  onlycoffee
//
//  Created by 新井崚平 on 2019/04/03.
//  Copyright © 2019年 ryohei. All rights reserved.
//

import UIKit

protocol RateDelegate {
    func rate(sender: UITableViewCell)
}

class RatingTableViewCell: UITableViewCell {

    @IBOutlet var rateButton: ShadowButton!
    var delegate: RateDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func rateButtonPressed(_ sender: Any) {
        self.delegate?.rate(sender: self)
    }
    
}
