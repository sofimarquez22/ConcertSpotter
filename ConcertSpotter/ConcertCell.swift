//
//  ComcertCell.swift
//  ConcertSpotter
//
//  Created by Ana Santos on 12/10/19.
//  Copyright © 2019 Sofia Marquez. All rights reserved.
//

import UIKit

class ConcertCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
