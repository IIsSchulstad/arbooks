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
