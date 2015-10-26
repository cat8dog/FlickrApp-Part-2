
import Foundation

class FlickrData: NSObject {
    
    
   let baseURL = "https://api.flickr.com/services/rest"
    //let methodName = "flickr.galleries.getPhotos"
    
   // GAVIN *** By changing the method I was able to access my own album (which is NOT considered a gallery)
    let methodName = "flickr.photosets.getPhotos"
    let APIKey = "88ee32cee1b0938e096f3307a996b280"
    //let galleryID = "136294158-72157659526447160"
    
    
    let photosetID = "72157612629420900"
    let userID = "33185468@N02"
    let extras = "description"
    
    
    //GAVIN *** need extras to have multiple items: description and url_m
    //let extras = "description" // extras should also include "url_m"
    let dataFormat = "json"
    let noJSONCallback = "1"
    
    
    func getImagesFromFlickrWithCallback(callback:([[String: AnyObject]])->()) {
        let methodArguments = [
            "method": methodName,
            "api_key": APIKey,
            //"gallery_id": galleryID,
            "photoset_id": photosetID,
            //"user_id": userID,
            "extras": extras,
            "format": dataFormat,
            "nojsoncallback": noJSONCallback
        ]
        
        let session = NSURLSession.sharedSession()
        let urlString = baseURL + escapedParameters(methodArguments)
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL: url)
        
        let task = session.dataTaskWithRequest(request) {data, response, downloadError in
            if let error = downloadError {
                println("Could not complete the request \(error)")
            } else {
//                println("Gavin says hi!")
//                println("response \(response)")
                var parsingError: NSError? = nil
                let parsedResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
                let parsedDictionary = parsedResult as! NSDictionary
                println("\(parsedResult)")
                
                //if let photosDictionary = parsedResult.valueForKey("photos") as? NSDictionary {
                if let photosDictionary = parsedDictionary.valueForKey("photoset") as? NSDictionary {
                    if let photoArray = photosDictionary.valueForKey("photo") as? [[String: AnyObject]] {

                     callback(photoArray)
                       
                       
                    } else {
                        println("Can't find key 'photo' in \(photosDictionary)")
                        
                    }
                
                    
                } else {
                    println("Can't find key 'photos' in \(parsedResult)")
                }
                
            }
        }
        
        task.resume()
    }
    
    func escapedParameters(parameters: [String: AnyObject]) -> String {
        var urlVars = [String]()
        
        for (key, value) in parameters {
            // ensure it's a string value
            let stringValue = "\(value)"
            
            // escape it
            let escapedValue = stringValue.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            
            // fix: replace spaces with '+'
            let replaceSpaceValue = stringValue.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
            
            // append it!
            urlVars += [key + "=" + "\(value)"]
        }
        
        return (!urlVars.isEmpty ? "?" : "") + join("&", urlVars)
    }
}


