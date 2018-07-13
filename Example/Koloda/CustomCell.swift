//
//  CustomCell.swift
//  Koloda_Example
//
//  Created by Katie  Lee on 7/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
