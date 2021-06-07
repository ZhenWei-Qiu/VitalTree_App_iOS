//
//  ViewController.swift
//  treeapp2
//
//  Created by Apple on 2019/3/25.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import FBSDKShareKit

class ViewController: UIViewController {
    



    @IBOutlet weak var sharebtn: FBSDKShareButton!
    @IBOutlet weak var intrbtn: UIButton!
    @IBOutlet weak var treebtn: UIButton!
    @IBOutlet weak var gamebtn: UIButton!
    @IBOutlet weak var mainBac1: UIImageView!
    @IBOutlet weak var starrbtn: UIButton!
    
    let tag = UIImage(named:"tag")
    let t = UIImage(named:"t")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.intrbtn.isHidden = true
        self.treebtn.isHidden = true
        self.gamebtn.isHidden = true
        sharebtn.isHidden = true
        self.view .addSubview(sharebtn)
        
        
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        
        content.contentURL = NSURL(string: "http://medhum.fjuh.fju.edu.tw/art/lifetree")! as URL
        
        sharebtn.shareContent = content
        sharebtn.setBackgroundImage(tag, for: .normal)
        sharebtn.setImage(t, for: .normal)
    }
    
    @IBAction func showappbegin() {
        self.intrbtn.isHidden = false
        self.treebtn.isHidden = false
        self.gamebtn.isHidden = false
        self.starrbtn.isHidden = true
        self.mainBac1.isHidden = true
        sharebtn.isHidden = false
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

    @objc func handleUnityReady() {
        showUnitySubView()
    }
    
    func showUnitySubView() {
        if let unityView = UnityGetGLView() {
            // insert subview at index 0 ensures unity view is behind current UI view
            //view?.insertSubview(unityView, at: 0)
            view?.addSubview(unityView)
            
            /* unityView.translatesAutoresizingMaskIntoConstraints = false
             let views = ["view": unityView]
             let w = NSLayoutConstraint.constraints(withVisualFormat: "|-0-[view]-0-|", options: [], metrics: nil, views: views)
             let h = NSLayoutConstraint.constraints(withVisualFormat: "V:|-75-[view]-0-|", options: [], metrics: nil, views: views)
             view.addConstraints(w + h)*/
        }
    }
    
    @IBAction func startUnity(_ sender: UIButton) {
        if let unityView = UnityGetGLView()
        {
            unityView.isHidden = false;
        }
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate
        {
            appDelegate.startUnity()
            NotificationCenter.default.addObserver(self, selector: #selector(handleUnityReady), name: NSNotification.Name("UnityReady"), object: nil)
        }
    }
    
    @IBAction func pauseUnity(_ sender: UIButton) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate
        {
            appDelegate.stopUnity()
            
            if let unityView = UnityGetGLView()
            {
                unityView.isHidden = true;
            }
        }
    }
}

