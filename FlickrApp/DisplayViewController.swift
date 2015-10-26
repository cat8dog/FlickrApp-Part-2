import UIKit


class DisplayViewController: UIViewController {
    

    
   // http://stackoverflow.com/questions/29582200/how-do-i-get-the-views-inside-a-container-in-swift
    
   // private var flickrAPIViewController: FlickrAPIViewController!
    
    private let imageDataSource = FlickrData()
    
    // eventually should be set up to save images to FavouritesViewController.
    @IBAction func saveFavourite(sender: AnyObject) {
        var selectedPhoto = photoArray[counter]
        //updateImage()
        
            
        }
    
   
    
    var photoArray:[[String:AnyObject]] = []
    
    private var embeddedViewController: StoryViewController!
    
//    @IBAction func longPressStory(sender: UILongPressGestureRecognizer) {
//     
//        println("STORY!")
//        if sender.state == UIGestureRecognizerState.Began {
//        
//        var alpha:CGFloat = 1.0
//        
//        if self.storyContainer.alpha == 0.5 {
//            alpha = 0.0
//            println("/(alpha)")
//        }
//        
//        UIView.animateWithDuration(0.3, animations: { () -> Void in
//            
//            self.storyContainer.alpha = alpha
//        })
//        }
//        
//    }
    @IBAction func showStory(sender: AnyObject) {
        println("STORY!")
        
        var alpha:CGFloat = 1.0
        
        if self.storyContainer.alpha == 1.0 {
            alpha = 0.0
        }
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.storyContainer.alpha = alpha
        })
        
        
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
        
        println("test for gavin --- *** --- \(photoArray)")
        
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
                
                testArray.text = flickrTitle
             
                if let description = currentPhoto.valueForKey("description") as? NSDictionary {
                    println("test 1")
                    if let story = description.valueForKey("_content") as? String {
                        self.updateStory( story )
                        println("test 2")
                    }
                }
            } else {
                println("Image does not exist at \(imageURL)")
            }
        }
        
    
    func updateStory( chosenStory:String ) {
        embeddedViewController.currentStory = chosenStory
        embeddedViewController.updateText()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       // flickrImage.image = UIImage(named: "yorkmills")
        
       
          //let imageID = currentPhoto.valueForKey("id") as! String
        storyContainer.alpha = 0.0
         imageDataSource.getImagesFromFlickrWithCallback {
                (images) -> () in
            self.photoArray = images
       
            var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        //    var gestdismissKeys: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "dismissedKeys:")
            
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
        
      
//
//        } else if (longPress.state == UIGestureRecognizerState.Ended) {
//            println("Ended")
//            println("STORY!")
//            
//            
//            
//            } else if (longPress.state == UIGestureRecognizerState.Cancelled) {
//                self.storyContainer.alpha == 0.0
//            }
        
        UIView.animateWithDuration(0.3, animations: {() -> Void in
            self.storyContainer.alpha = alpha
            
            })
     }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? StoryViewController
            where segue.identifier == "EmbedSegue" {
                self.embeddedViewController = vc
             
//        } else if let faveVC = segue.destinationViewController as? FavouritesViewController
//            where segue.identifier == "segueFave" {
//            FavouritesViewController
        }
    }


}
