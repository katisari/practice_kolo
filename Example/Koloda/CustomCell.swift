//
//  CustomCell.swift
//  Koloda_Example
//
//  Created by Katie  Lee on 7/13/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    var cost = ""
    var seturl = ""
    @IBOutlet var imageDisplay: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        priceLabel.text = cost
//        let url = URL(string: seturl)
//        let data = try? Data(contentsOf: url!)
//        imageDisplay.image = UIImage(data: data!)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
