//
//  InfoTableViewCell.swift
//  arbooks
//
//  Created by Rasmus Stamm on 28/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    /*var mainImageView: UIImageView = {
        var imageView: UIImageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return nil
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(mainImageView)
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }*/
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
