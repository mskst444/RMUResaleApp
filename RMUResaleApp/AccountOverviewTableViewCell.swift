//
//  AccountOverviewTableViewCell.swift
//  RMUResaleApp
//
//  Created by Jacob Wright on 4/18/19.
//  Copyright © 2019 Mitchell Keller. All rights reserved.
//

import UIKit

class AccountOverviewTableViewCell: UITableViewCell {
    
/*********************** Properties: **********************************************/
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
/**********************************************************************************/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    
    
    
    
}
