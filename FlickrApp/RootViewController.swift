
import UIKit

class RootViewController: UIViewController {

    @IBOutlet weak var imageContainterCentreConstraint: NSLayoutConstraint!
   
    @IBOutlet weak var showFavourites: UIBarButtonItem!
    @IBOutlet var showInfoi: UINavigationItem!

    
    private var displayEmbeddedViewController: DisplayViewController!
    @IBOutlet weak var displayContainer: UIView!
    
    enum SelectionState {
        case NoSelection
        case FavouritesSwipe
        case RejectedSwipe
    }
    
    var selectionState = SelectionState.NoSelection

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            println("Touches Began")
        case .Ended:
            println("Touches Ended")
      
          imageContainterCentreConstraint.constant = 0
            UIView.animateWithDuration(0.3, animations: {
                () -> Void in
                self.displayEmbeddedViewController.view.transform = CGAffineTransformIdentity
                self.view.layoutIfNeeded()
                
                },
                completion: {
                    (completed) -> Void in
                    if completed {
                      
            
                        if self.selectionState == .FavouritesSwipe {
                            // can ignore this state for now
                            self.performSegueWithIdentifier("FaveSegue", sender: self)
                        } else if self.selectionState == .RejectedSwipe {
                            
                            if self.displayEmbeddedViewController.counter >= self.displayEmbeddedViewController.photoArray.count {
                                self.displayEmbeddedViewController.counter = 0
                            }
                            
                            self.displayEmbeddedViewController.updateImage()
                            self.displayEmbeddedViewController.counter++
                        }
                        self.selectionState = .NoSelection
                        
                        
                    }
            })
            
        default:
            println("Touches Continued")
            var translation = sender.translationInView(self.view)
            if abs(translation.x) < view.bounds.size.width / 2 {
                
                
                if abs(translation.y) > 60 {
                    displayEmbeddedViewController.view.transform = CGAffineTransformMakeScale( 1 - (abs(translation.y - 60) / ((view.bounds.width - 120 / 2))), 1 - (abs(translation.y - 60) / ((view.bounds.width - 120  / 2))))
                    //displayEmbeddedViewController.view.center = CGPointMake(self.view.bounds.width / 2 + self.view.bounds.width / 2 * translation.x, 30)
                } else {
                    imageContainterCentreConstraint.constant = -translation.x
                    view.layoutIfNeeded()
                }
                
            } else {
                if ((view.bounds.size.width / 2) + translation.x > view.bounds.size.width) {
                    println("Faves Selected")
                    selectionState = .FavouritesSwipe
                } else if ((view.bounds.size.width / 2) + translation.x < 0) {
                    println("Reject Selected")
                    selectionState = .RejectedSwipe
                } else {
                    println("Nothing selected")
                    selectionState = .NoSelection
                    
                }
            }
        }
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? DisplayViewController
            where segue.identifier == "ImageContainerSegue" {
                self.displayEmbeddedViewController = vc
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
