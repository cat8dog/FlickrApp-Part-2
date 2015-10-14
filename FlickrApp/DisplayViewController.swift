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
    
    private var embeddedViewController: StoryCollectionViewController!
    
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
  
    @IBOutlet var imageArray: UIImageView!
    
    var mockImages = ["day44.jpg", "day45.jpg", "day47.jpg", "day48.jpg", "day49.jpg"]
    
    // counter = 0

    
    @IBOutlet var storyContainer: UIView!
    
    @IBOutlet var testArray: UILabel!
    
    //  @IBOutlet var showStory: UIButton!
    
    var mockTitles = ["Day 44", "Day 45", "day 47", "day 48", "day 49"]
    
    var mockStories = ["The Two-Year Itch.", "Allison tries really hard to convince people that she's not that good a person, but I know she's full of shit.  It's not just anybody, who when overhearing a co-worker saying their dad just had an operation and needs a walker but can't afford one, volunteers her own grandpa's walker.  Maybe it was one of those things you just saaaay, not expecting anyone to actually follow up on the nice thought. This is her the next morning, eating her words.", "The End of The World.", "Chrysler and Fiat walk the walk."]
    
    var counter = 0
    //var storyAlpha:UIView = UIView(storyContainer)
    
    @IBAction func nextLabel(sender: AnyObject) {
        println("tapped!")
        if counter >= mockTitles.count {
            counter = 0
        }
        if counter >= mockImages.count {
            counter = 0
        }
        if counter >= mockStories.count {
            counter = 0
        }
        
        
        updateLabel()
        updateImage()
        updateStory()
        counter++
    }
    
    
    
    func updateLabel() {
        var chosenTitle = mockTitles[counter]
        testArray.text = chosenTitle
        println("\(chosenTitle)")
    }

    func updateImage() {
        var chosenImage: UIImage = UIImage (named: (mockImages[counter]))!
        imageArray.image = chosenImage
        println("\(chosenImage)")
        
    }
    
    func updateStory() {
        var chosenStory = mockStories[counter]
        embeddedViewController.currentStory = chosenStory
        embeddedViewController.updateText()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyContainer.alpha = 0.0
    }

    // *******************
    
//    @IBAction func didPan(sender: UIPanGestureRecognizer) {
//        switch sender.state {
//        case .Began:
//            println("Touches Began")
//        case .Ended:
//            println("Touches Ended")
//            imageContainerCentreConstraint.constant = 0
//            UIView.animateWithDuration(0.3, animations: {
//                 () -> Void in
//                    self.view.layoutIfNeeded()
//                },
//                completion: {
//                    (completed) -> Void in
//                    if completed {
//                        if self.selectionState == .FavouritesSwipe {
//                            self.performSegueWithIdentifier("FaveSegue", sender: self)
//                        } else if self.selectionState == .RejectedSwipe {
//                            self.performSegueWithIdentifier("RejectSegue", sender: self)
//                        }
//                        self.selectionState = .NoSelection
//                    }
//            })
//            
//        default:
//            println("Touches Continued")
//            var translation = sender.translationInView(self.view)
//            if abs(translation.x) < view.bounds.size.width / 2 {
//                imageContainerCentreConstraint.constant = -translation.x
//                view.layoutIfNeeded()
//            } else {
//                if ((view.bounds.size.width / 2) + translation.x > view.bounds.size.width) {
//                    println("Faves Selected")
//                    selectionState = .FavouritesSwipe
//                } else if ((view.bounds.size.width / 2) + translation.x < 0) {
//                    println("Reject Selected")
//                    selectionState = .RejectedSwipe
//                } else {
//                    println("Nothing selected")
//                    selectionState = .NoSelection
//                }
//            }
//        }
//        
//    }
    

    override func viewDidAppear(animated: Bool) {
   //     self.embeddedViewController
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? StoryCollectionViewController
            where segue.identifier == "EmbedSegue" {
                self.embeddedViewController = vc
                //var chosenStory = mockStories[counter]
                //vc.currentStory = chosenStory
                //vc.updateText()
        }
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
