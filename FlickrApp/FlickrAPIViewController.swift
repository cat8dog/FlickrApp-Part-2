
import UIKit

class FlickrAPIViewController: UIViewController {
    
    private var displayViewController: DisplayViewController!
    
    let baseURL = "https://api.flickr.com/services/rest"
    let methodName = "flickr.galleries.getPhotos"
    let APIKey = "88ee32cee1b0938e096f3307a996b280"
    let galleryID = "136294158-72157659526447160"
    let extras = "url_m"
    let dataFormat = "json"
    let noJSONCallback = "1"
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func getImageFromFlickr() {
        let methodArguments = [
        "method": methodName,
        "api_key": APIKey,
        "gallery_id": galleryID,
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
                var parsingError: NSError? = nil
                let parsedResult: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: &parsingError)
                
                if let photosDictionary = parsedResult.valueForKey("photos") as? NSDictionary {
                    if let photoArray = photosDictionary.valueForKey("photo") as? [[String: AnyObject]] {
                        
                        // grabs a single image *** may need to fix
                        let PhotoIndex = Int(photoArray.count)
                        let photoDictionary = photoArray[PhotoIndex] as [String: AnyObject]
                        
                        // get the image url and title
                        let photoTitle = photoDictionary["title"] as? String
                        let imageUrlString = photoDictionary["url_m"] as? String
                        let imageURL = NSURL(string: imageUrlString!)
                        
                        if let imageData = NSData(contentsOfURL: imageURL!) {
                            dispatch_async(dispatch_get_main_queue(), {
                                // fill this in!!!
                                
                                // pass photoTitle array
                                // pass imageUrlString array
                                // pass the image info
                            })
                        } else {
                            println("Image does not exist at \(imageURL)")
                        }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DisplayViewController
            where segue.identifier == "DisplaySegue" {
                self.displayViewController = vc
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
