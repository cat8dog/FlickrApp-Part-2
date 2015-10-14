
import UIKit

class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   // @IBOutlet var favouritesTable: UITableView!
   
    @IBOutlet var favouritesTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        
//        // Return the number of sections.
//        return 1
 //   }
    
   func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }
    
   func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UITableViewCell
        
        return cell
    
    }

}
    