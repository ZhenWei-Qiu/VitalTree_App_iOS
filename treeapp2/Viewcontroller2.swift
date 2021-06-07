//
//  Viewcontroller2.swift
//  treeapp2
//
//  Created by Apple on 2019/3/25.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FBSDKShareKit
class ViewController2: UIViewController {
    
    @IBOutlet weak var sharebtn: FBSDKShareButton!
    let shareButton: FBSDKShareButton = FBSDKShareButton()
    
    let tag = UIImage(named:"tag")
    let t = UIImage(named:"t")
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        
        content.contentURL = NSURL(string: "http://medhum.fjuh.fju.edu.tw/art/lifetree")! as URL
        
        sharebtn.shareContent = content
        sharebtn.setBackgroundImage(tag, for: .normal)
        sharebtn.setImage(t, for: .normal)
    }
    
    @IBAction func showgame() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "login") {
            present(controller, animated: true, completion: nil)
        }
    }
    
    @IBAction func showintr() {
        let url = NSURL(string: "Intr://edu.fju.cs.tree.Intr")!
        UIApplication.shared.openURL(url as URL)
    }
    
    @IBAction func showtree() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "treepage") {
            present(controller, animated: true, completion: nil)
        }
    }
    override func viewWillAppear(_ animated: Bool)
    {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
}
