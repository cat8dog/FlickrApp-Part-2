import UIKit


class DisplayViewController: UIViewController {
    
    @IBAction func savesToFavourites(sender: AnyObject) {
        updateFavourites()
    }

    
   // http://stackoverflow.com/questions/29582200/how-do-i-get-the-views-inside-a-container-in-swift
    
   // private var flickrAPIViewController: FlickrAPIViewController!
    
    private let imageDataSource = FlickrData()
    
    // eventually should be set up to save images to FavouritesViewController.
    @IBAction func saveFavourite(sender: AnyObject) {
        //var selectedPhoto = photoArray[counter]
        //updateImage()
        saveToFavesVC()
        println("FAVE PUSH")
            
        }
    
   
    
    var photoArray:[[String:AnyObject]] = []
    
    private var embeddedViewController: StoryViewController!
    private var favouritesViewController: FavouritesViewController!
    private var rootViewController: RootViewController!
    

    @IBAction func showStory(sender: AnyObject) {
        
        updateImage()
        
    }
  
    @IBOutlet var flickrImage: UIImageView!
    
    
    @IBOutlet var storyContainer: UIView!
    
    @IBOutlet var testArray: UILabel!
    
    //  @IBOutlet var showStory: UIButton!
    
  
    
    var counter = 0
//
//    @IBAction func nextLabel(sender: AnyObject) {
//        println("tapped!")
//     
//        if counter >= photoArray.count {
//            counter = 0
//        }
//        
//        updateImage()
//        counter++
//    }
    
  

    func updateImage() {
        
        
        let currentPhoto = photoArray.reverse()[counter] as NSDictionary
        
        let farmID = String(currentPhoto.valueForKey("farm") as! Int)
        let imageID = currentPhoto.valueForKey("id") as! String
        let serverID = currentPhoto.valueForKey("server") as! String
        let secretID = currentPhoto.valueForKey("secret") as! String
        
        let flickrTitle = currentPhoto.valueForKey("title") as! String
        
        // https://farm{farm-id}.staticflickr.com/{server-id}/{id {secret}.jpg
        let flickrURL = "https://farm" + farmID + ".staticflickr.com/" + serverID + "/" + imageID + "_" + secretID + ".jpg"
        
        println("Image Url: \(flickrURL)")
            let imageURL = NSURL(string: flickrURL)
        
        if let imageData = NSData(contentsOfURL: imageURL!) {
            flickrImage.image = UIImage(data: imageData)
            
            loadNextSwipe()
          //  getCurrentPhotoInfo()
            println("8888888 The image is \(flickrImage), the title is \(flickrTitle) and the description is \(description)")

        } else {
            println("Image does not exist at \(imageURL)")
        }
        
    }
    
        func loadNextSwipe() {
            var flickrTitle = String?()
            var currentPhoto = NSDictionary.self

                testArray.text = flickrTitle

                if let description = currentPhoto.valueForKey("description") as? NSDictionary {
                    println("test 1")
                    if let story = description.valueForKey("_content") as? String {
                        self.updateStory( story )
                        println("test 2")
                        
                    }
                
                let compiledInfo = getCurrentPhotoInfo()
                    println("8888888 The image is \(flickrImage), the title is \(flickrTitle) and the description is \(description)")
                    println("WE'RE HIT")
                }
         
        
        }
        
    
    func getCurrentPhotoInfo() -> (image: String, title: String, description: String) {
    return("flickrImage", "flickrTitle", "desctription")
    
    }
    
    func updateFavourites() {
        let compiledInfo = getCurrentPhotoInfo()
        favouritesViewController.currentPhoto = compiledInfo
    }
        
    
    func updateStory( chosenStory:String ) {
        embeddedViewController.currentStory = chosenStory
        embeddedViewController.updateText()
        
    }
    
//    func updateTitle ( chosenTitle:String ) {
//        rootViewController.currentTitle = chosenTitle
//        rootViewController.updateTitleText()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        storyContainer.alpha = 0.0
         imageDataSource.getImagesFromFlickrWithCallback {
                (images) -> () in
            self.photoArray = images
       
            var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
            
            self.view.addGestureRecognizer(gesture)
            
            gesture.minimumPressDuration = 1.0
            

        }
        
    }
    
    func longPressed(longPress: UIGestureRecognizer) {
        var alpha:CGFloat = 1.0
       
        
        if (longPress.state == UIGestureRecognizerState.Ended) {
            if self.storyContainer.alpha == 1.0 {
                alpha = 1.0
            } else {self.storyContainer == 0.0}
            
            
            println("ended")
        }
        
      else if (longPress.state == UIGestureRecognizerState.Began) {
            
            println("Began")
            if self.storyContainer.alpha == 1.0 {
                alpha = 0.0
                
                println("alpha")
        }
        
        
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.storyContainer.alpha = alpha
            
            
            })
     }
    }
    
    func saveToFavesVC() {
       
  
        let displayViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("favouritesViewId") as! UIViewController
        //self.presentViewController(FavouritesViewController(), animated: false, completion: nil)
        favouritesViewController.currentPhoto = getCurrentPhotoInfo()
        
        
    }
    
    
//    func updateLabel ( chosenLabel:String ) {
//       favouritesViewController.currentTitle = chosenLabel
//        favouritesViewController.updateTheLabel()
//    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

        
        
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? StoryViewController
            where segue.identifier == "EmbedSegue" {
                self.embeddedViewController = vc
                

        }
    }


}
