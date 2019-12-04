import UIKit

class Book{
    
    var title: String
    var cover: UIImage?
    var author: String
    var edition: Int
    var yearPublished: Int
    var videoURL: String
    var resource: String
    
    init?(title: String, cover: UIImage?, author: String, edition: Int, yearPublished: Int, videoURL: String, resource: String) {
        
        if title.isEmpty {
            return nil
        }
        
        self.title = title
        self.cover = cover
        self.author = author
        self.edition = edition
        self.yearPublished = yearPublished
        self.videoURL = videoURL
        self.resource = resource
    }
}
