//
//  BookTableViewCell.swift
//  arbooks
//
//  Created by Rasmus Stamm on 14/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var coverImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
