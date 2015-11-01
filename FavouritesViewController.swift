
import UIKit

class FavouritesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   // @IBOutlet var favouritesTable: UITableView!
    
    private var favesCellVC = FaveTableViewCell()
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    var currentPhoto = (image: String(), title: String(), description: String())
    
    func printCurrentPhoto() {
        println("Halloween Special! \(currentPhoto)")
    }
   
    @IBOutlet var favouritesTable: UITableView!
    var faveIndexPath: NSIndexPath = NSIndexPath()
    
    var faveImages = ["day44.jpg", "day45.jpg", "day47.jpg", "day48.jpg", "day49.jpg"]
    var faveNames = ["day44", "day45", "day47", "day48", "day49"]
    var faveStories = ["The Two-Year Itch", "Allison tries really hard to convince people that she's not that good a person, but I know she's full of shit.  It's not just anybody, who when overhearing a co-worker saying their dad just had an operation and needs a walker but can't afford one, volunteers her own grandpa's walker.  Maybe it was one of those things you just saaaay, not expecting anyone to actually follow up on the nice thought. This is her the next morning, eating her words.", "The End of the World.", "Chrysler and Fiat, walking the walk.", "The cool girls of York Mills.  On Mondays, when I want to die all day, the only thing that I look forward to is a new episode of One Tree Hill.  I wasn't always like that-  everyone I know who's seen at least one season of this junk gets so hooked that what was once a guilty pleasure quickly becomes a major bar topic.  Anyway when it was too hot to move last summer, I watched the box set, and since then have endured each painfully slow week till the next instalment comes on.  Or at least, we did that till January.  The show sucks so bad now, it hurts to watch.  But you're like a kid waiting on the back porch months after the dog dissapeared- refusing to admit that the worst might actually be true. Anyway what kills me is that when I see girls like this, it occurs to me that the characters I know so well are (or were, before they leaped to being 22) the same age.  So there's something pretty awful and sick about that. Also, I drew it knowing that I only get to because I'm a girl.  A guy my age would never be caught dead sketching this, evermind showcasing it."]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        printCurrentPhoto()
        
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

            cell.thumbnailImage.image = UIImage(named: faveImages[indexPath.row])
            cell.nameLabel.text = faveNames[indexPath.row]
            cell.storyTextView.text = faveStories[indexPath.row]
//        
    
    
    
        return cell
    
    }


    

        


}















    