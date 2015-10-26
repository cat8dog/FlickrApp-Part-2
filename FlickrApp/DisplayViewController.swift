import UIKit


class DisplayViewController: UIViewController {
    

    
//    
//    enum SelectionState {
//        case NoSelection
//        case FavouritesSwipe
//        case RejectedSwipe
//    }
//
//    var selectionState = SelectionState.NoSelection
//    
//    @IBOutlet weak var imageContainerCentreConstraint: NSLayoutConstraint!
    
   // http://stackoverflow.com/questions/29582200/how-do-i-get-the-views-inside-a-container-in-swift
    
   // private var flickrAPIViewController: FlickrAPIViewController!
    
    private let imageDataSource = FlickrData()
    
    var photoArray:[[String:AnyObject]] = []
    
    private var embeddedViewController: StoryViewController!
    
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
    //var storyAlpha:UIView = UIView(storyContainer)
    
    @IBAction func nextLabel(sender: AnyObject) {
        println("tapped!")
        if counter >= photoArray.count {
            counter = 0
        }
        
        
       // updateLabel()
        updateImage()
      //  updateStory()
        counter++
    }
    
    
//    
//    func updateLabel() {
//        var chosenTitle = mockTitles[counter]
//        testArray.text = chosenTitle
//        println("\(chosenTitle)")
//    }

    func updateImage() {
        
        println("test for gavin --- *** --- \(photoArray)")
        
        let currentPhoto = photoArray[counter] as NSDictionary
        
        let farmID = String(currentPhoto.valueForKey("farm") as! Int)
        let imageID = currentPhoto.valueForKey("id") as! String
        let serverID = currentPhoto.valueForKey("server") as! String
        let secretID = currentPhoto.valueForKey("secret") as! String
        
        let flickrTitle = currentPhoto.valueForKey("title") as! String
        
        // https://farm{farm-id}.staticflickr.com/{server-id}/{id {secret}.jpg
        let flickrURL = "https://farm" + farmID + ".staticflickr.com/" + serverID + "/" + imageID + "_" + secretID + ".jpg"
        
      // if let imageUrl:String = photoArray[counter]["url_m"] as? String{
        
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
        storyContainer.alpha = 0.0
         imageDataSource.getImagesFromFlickrWithCallback {
                (images) -> () in
            self.photoArray = images
            println("******Hi Cat!*****")
    
            println("BLLAAAAH \(self.photoArray)")
            
        }
        
    }


    

    override func viewDidAppear(animated: Bool) {
   //     self.embeddedViewController
    }
    
    
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
