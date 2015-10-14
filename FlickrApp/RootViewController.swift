
import UIKit

class RootViewController: UIViewController {

   // @IBOutlet var showFavourites: UIBarButtonItem!
    @IBOutlet var showInfoi: UINavigationItem!


    @IBOutlet weak var displayContainer: UIView!
    
    enum SelectionState {
        case NoSelection
        case FavouritesSwipe
        case RejectedSwipe
    }
    
    var selectionState = SelectionState.NoSelection
    

    @IBOutlet weak var imageContainerCentreConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            println("Touches Began")
        case .Ended:
            println("Touches Ended")
            imageContainerCentreConstraint.constant = 0
            UIView.animateWithDuration(0.3, animations: {
                () -> Void in
                self.view.layoutIfNeeded()
                },
                completion: {
                    (completed) -> Void in
                    if completed {
                        if self.selectionState == .FavouritesSwipe {
                            self.performSegueWithIdentifier("FaveSegue", sender: self)
                        } else if self.selectionState == .RejectedSwipe {
                            self.performSegueWithIdentifier("RejectSegue", sender: self)
                        }
                        self.selectionState = .NoSelection
                    }
            })
            
        default:
            println("Touches Continued")
            var translation = sender.translationInView(self.view)
            if abs(translation.x) < view.bounds.size.width / 2 {
               imageContainerCentreConstraint.constant = -translation.x
                view.layoutIfNeeded()
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}
