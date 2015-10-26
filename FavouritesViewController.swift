
import UIKit

class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   // @IBOutlet var favouritesTable: UITableView!
   
    @IBOutlet var favouritesTable: UITableView!
    var faveIndexPath: NSIndexPath = NSIndexPath()
    
    var faveImages = ["pie", "pancake", "shirt", "florida", "nun"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
   func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        // Return the number of sections.
        return 1
    }
    
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.faveImages.count
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! FaveTableViewCell
    
        //cell.thumbnailImageView.image = UIImage(named: "yorkmills")
        cell.nameLabel.text = "Day Blah blah"
    
    
        return cell
    
    }

}















    