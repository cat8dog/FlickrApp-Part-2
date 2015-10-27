//
//  StoryCollectionViewController.swift
//  FlickrApp
//
//  Created by Catherine Reyto on 2015-10-02.
//  Copyright (c) 2015 Catherine Reyto. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    
    
    var currentStory = ""
    
    @IBOutlet weak var storyTextView: UITextView!

    
//    @IBAction func storyAlphonzo(sender: AnyObject) {
//    // self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(1.0)
//        toggleView()
//       
//    
//        println("tapped!!")
//    }

    
    //var viewIsHidden:Bool = false
    override func viewWillAppear(animated: Bool) {
        var hideView: () = self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.0)
       
        storyTextView.scrollEnabled = true
        storyTextView.selectable = false
    }
    
    func showView () -> Bool {
        self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(1.0)
        var viewIsOn = true
        return viewIsOn
    }
    
    func toggleView () -> Bool {
        var stateOfView = true
        if self.view.backgroundColor == UIColor.grayColor().colorWithAlphaComponent(0.0) {
            showView()
        }
        else {
            hideView()
        }
        return stateOfView
    }
    
    func hideView () -> Bool {
        self.view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.0)
        var viewIsOff = true
        return viewIsOff
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
  
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateText() {
        if let storyTV = storyTextView {
            storyTV.text = currentStory
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
