//
//  Books.swift
//  arbooks
//
//  Created by Rasmus Albrektsen on 12/11/2019.
//  Copyright © 2019 Rasmus Stamm. All rights reserved.
//

import Foundation

class BookList {
    var books = [String: Book]();
    
    init() {
        books["TestBook"] = Book(title: "Test Book", author: "Test Author", yearPublished: 1999);
        
    }
}
