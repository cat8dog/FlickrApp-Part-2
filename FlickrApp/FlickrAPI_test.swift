//
//import Foundation
//import UIKit
//
//let apiKey = "d08c5737957e2267de54835efa3f42bf"
//
//struct FlickrSearchResults {
//    let searchTerm : String
//    let searchResults: [FlickrPhoto]
//}
//
//class FlickrPhoto : Equatable {
//    var thumbnail : UIImage?
//    var largeImage : UIImage?
//    let photoID : String
//    let farm : Int
//    let server : String
//    let secret : String
//    
//    init (photoID:String, farm:Int, server:String, secret:String) {
//        self.photoID = photoID
//        self.farm = farm
//        self.server = server
//        self.secret = secret
//    }
//    
//    func flickrImageURL(size:String = "m") -> NSURL {
//        return NSURL(string: "http://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret)_\(size).jpg")!
//        
//        // https://www.flickr.com/photos/136317212@N03/galleries/72157659526447160
//    }
//    
//    func loadLargeImage(completion: (flickrPhotos:FlickrPhoto, error: NSError?) -> Void) {
//        let loadURL = flickrImageURL(size: "b")
//        let loadRequest = NSURLRequest(URL:loadURL)
//        NSURLConnection.sendAsynchronousRequest(loadRequest, queue: NSOperationQueue.mainQueue()) {
//            response, data, error in
//            
//            if error != nil {
//                completion(flickrPhotos: self, error: error)
//                return
//            }
//            
//            if data != nil {
//                let returnedImage = UIImage(data: data)
//                self.largeImage = returnedImage
//                completion(flickrPhotos: self, error: nil)
//                return
//            }
//            
//         completion(flickrPhotos: self, error: nil)
//    }
//}
//
//    func sizeToFillWidthOfSize(size:CGSize) -> CGSize {
//        if thumbnail == nil {
//            return size
//        }
//        
//        let imageSize = thumbnail!.size
//        var returnSize = size
//        
//        let aspectRatio = imageSize.width / imageSize.height
//        
//        returnSize.height = returnSize.width / aspectRatio
//        
//        if returnSize.height > size.height {
//            returnSize.height = size.height
//            returnSize.width = size.height * aspectRatio
//        }
//        
//        return returnSize
//    }
//}
//
//    func == (lhs: FlickrPhoto, rhs: FlickrPhoto) -> Bool {
//    return lhs.photoID == rhs.photoID
//    }
//
//class Flickr {
//    
//    let processingQueue = NSOperationQueue()
//    
//    func getNextPhotoFromFlickr(searchTerm: String, completion : (results: FlickrSearchResults?, error: NSError?) -> Void) {
//        let searchURL = flickrSearchURLForSearchTerm(searchTerm)
//        let photoRequest = NSURLRequest(URL: searchURL)
//        NSURLConnection.sendAsynchronousRequest(photoRequest, queue: processingQueue) {response, data, error in
//            if error != nil {
//                completion(results: nil, error: error)
//                return
//            }
//            
//            var JSONError : NSError?
//            let resultsDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(0), error: &JSONError) as? NSDictionary
//            if JSONError != nil {
//                completion(results: nil, error: JSONError)
//                return
//            }
//            
//            switch (resultsDictionary!["stat"] as! String) {
//                case "ok":
//                println("Results processed OK")
//                case "fail":
//                    let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:resultsDictionary!["message"]!])
//                    completion(results: nil, error: APIError)
//                return
//                    default:
//                    let APIError = NSError(domain: "FlickrSearch", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
//                completion(results: nil, error: APIError)
//                return
//            }
//            
//            let photosContainer = resultsDictionary!["photos"] as! NSDictionary
//            let photosReceived = photosContainer["photo"] as! [NSDictionary]
//            
//            let flickrPhotos : [FlickrPhoto] = photosReceived.map {
//                photoDictionary in
//                
//                let photoID = photoDictionary["id"] as? String ?? ""
//                let farm = photoDictionary["farm"] as? Int ?? 0
//                let server = photoDictionary["server"] as? String ?? ""
//                let secret = photoDictionary["sectret"] as? String ?? ""
//                
//                let flickrPhoto = FlickrPhoto(photoID: photoID, farm: farm, server: server, secret: secret)
//                let imageData = NSData(contentsOfURL: flickrPhoto.flickrImageURL())
//                flickrPhoto.thumbnail = UIImage(data: imageData!)
//                
//                return flickrPhoto
//            }
//            
//            dispatch_async(dispatch_get_main_queue(), {
//                completion(results: FlickrSearchResults(searchTerm: searchTerm, searchResults: flickrPhotos), error: nil)
//            })
//    }
//}
//    
//    private func flickrSearchURLForSearchTerm(searchTerm:String) -> NSURL {
//        
//        let escapedTerm = searchTerm.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        let URLString = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(apiKey)&text=\(escapedTerm)&per_page=20&format=json&nojsoncallback=1"
//        return NSURL(string: URLString)!
//        
//    }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//}