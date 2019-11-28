//
//  Info.swift
//  arbooks
//
//  Created by Rasmus Stamm on 28/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import UIKit

class Info {
    var title: String
    var textArray = [String]()
    var imageArray = [UIImage?]()
    
    init?(title: String, textArray: [String], imageArray: [UIImage?]) {
        if title.isEmpty {
            return nil
        }
        
        self.title = title
        self.textArray = textArray
        self.imageArray = imageArray
    }
}
