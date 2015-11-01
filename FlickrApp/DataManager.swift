
import Foundation

class organizeData {
    
    var currentPhoto : NSDictionary = [:]
    var farmID : String = ""
    var serverID : String = ""
    var secretID : String = ""
    var flickerTitle : String = ""
    
    var flickrURL : String = ""
    var imageURL : String = ""
    
    func returnImageData() {
        if let imageData = NSData(contentsOfURL: imageURL) {
            var currentImage = UIImage(data: imageData)
            var currentTitle = ("")
            var currentStory = ("")
        }
        
    }
    
}