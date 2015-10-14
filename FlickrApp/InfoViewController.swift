
import UIKit

class InfoViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    // will contain text per label
    var tableData: [String] = ["bio","webPage", "news", "contact"]
    var tableImages: [String] = ["bio.png", "webPage.png", "news.png", "contact.png"]


    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        let cellIdentifier = "Cell"
//        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        
        let cell: InfoViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell",  forIndexPath: indexPath) as! InfoViewCell
        cell.infoLabel.text = tableData[indexPath.row]
        cell.InfoImage.image = UIImage(named: tableImages[indexPath.row])
        
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       // println("Cell \(indexPath)
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
