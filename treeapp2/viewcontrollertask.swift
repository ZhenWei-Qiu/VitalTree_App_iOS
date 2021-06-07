//
//  viewcontrollertask.swift
//  treeapp2
//
//  Created by Apple on 2019/3/26.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class viecontrollertask: UIViewController {
    
    @IBOutlet weak var beforeBT: UIButton!
    @IBOutlet weak var btnGift1: UIButton!
    @IBOutlet weak var btnGift2: UIButton!
    @IBOutlet weak var btnGift3: UIButton!
    @IBOutlet weak var btnGift4: UIButton!
    @IBOutlet weak var imgTips: UIImageView!
    @IBOutlet weak var labTips: UILabel!
    @IBOutlet weak var btnTips: UIButton!
    @IBOutlet var tipbutton: UIButton!
    @IBOutlet var views: UIView!
    @IBOutlet var viewnot: UIView!
    @IBOutlet var stage_picture: UIImageView!
    @IBOutlet var finger_picture: UIImageView!
    @IBOutlet var text_picture: UIImageView!
    @IBOutlet var speak_picture: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    var completed = 0
    var missionteacend = 0
    var steps = 0
    var sbebtn = 1 //close showbefore btn
    var settextpicture = 0
    var settextpicturenum = 0
    
    var seednumber = 0;
    var warehousenumber = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if(missionteacend == 1){
            completed = 999
        }
        
        if(warehousenumber >= 9){
            nottouch()
        }
        imgTips.isHidden = true
        labTips.isHidden = true
        btnTips.isHidden = true
        
        tipbutton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 110))
        tipbutton.setImage(UIImage(named: "light-1"), for: .normal)
        tipbutton.addTarget(self, action: #selector(self.showtip), for: .touchUpInside)
        tipbutton.center = CGPoint(x: 702,y: 80)
        self.view.addSubview(tipbutton)
        print(completed)
        if completed == 5{
            teachstep()
        }
        if steps != 0 && completed == 0{
           teachstep()
        }
        if steps == 0 && completed == 0{
           completed = 999
        }
        
    }
    func nottouch(){
        let frame = CGRect(x: 100, y: 50, width: 600, height: 800)
        viewnot = UIView(frame: frame)
        viewnot.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(viewnot)
        self.view.bringSubviewToFront(labTips)
        self.view.bringSubviewToFront(btnTips)
    }
    @objc func showtip(){
        btnGift1.isEnabled = false
        btnGift2.isEnabled = false
        btnGift3.isEnabled = false
        btnGift4.isEnabled = false
        imgTips.isHidden = false
        labTips.isHidden = false
        btnTips.isHidden = false
    }
    @IBAction func showbefore() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "gamepage")as? viewcontroller_game {
            controller.completed = self.completed
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showgift1() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "task2")as? viecontrollertask2 {
            if(completed != 999){
                controller.steps = self.steps + 1}
            controller.warehousenumber = self.warehousenumber
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showgift2() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "task2")as? viecontrollertask2 {
            if(completed != 999){controller.steps = self.steps + 1}
            controller.warehousenumber = self.warehousenumber
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showgift3() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "task2")as? viecontrollertask2 {
            if(completed != 999){controller.steps = self.steps + 1}
            controller.warehousenumber = self.warehousenumber
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showgift4() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "task2")as? viecontrollertask2  {
            if(completed != 999){controller.steps = self.steps + 1}
            controller.warehousenumber = self.warehousenumber
            present(controller, animated: true, completion: nil)
        }
        
    }
    /* @IBAction func showtree() {
     
     if let controller = storyboard?.instantiateViewController(withIdentifier: "treepage") {
     present(controller, animated: true, completion: nil)
     }
     
     }*/
    
    @IBAction func closeTips(_ sender: Any) {
        btnGift1.isEnabled = true
        btnGift2.isEnabled = true
        btnGift3.isEnabled = true
        btnGift4.isEnabled = true
        imgTips.isHidden = true
        labTips.isHidden = true
        btnTips.isHidden = true
    }
    @IBAction func teachnext(){
           steps += 1;
           teachstep();
       }
    @IBAction func teasetthing(){
           //var fingx = [260,480,700];
           //let comtofin = [260,700,480,700,700];//go to where
           
            let frame = CGRect(x: 0, y: 0, width: 800, height: 1100)
            views = UIView(frame: frame)
            views.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            self.view.addSubview(views)
        
            var seatsize = CGRect.init(x: 30, y: 250, width: 710, height: 250)
            let x = UIImage(named: "speak2" )
            speak_picture = UIImageView(image: x,highlightedImage:x)
            speak_picture.frame = seatsize
            self.view.addSubview(speak_picture)
           
           // teacimg()
            seatsize = CGRect.init(x:80, y: 80, width: 80, height: 80)
            let finger = UIImage(named:"finger" )
            finger_picture = UIImageView(image: finger,highlightedImage:finger)
            finger_picture.frame = seatsize
            
           
            skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 64))
            skipButton.setImage(UIImage(named: "skip"), for: .normal)
            skipButton.addTarget(self, action: #selector(self.teacend), for: .touchUpInside)
            skipButton.center = CGPoint(x: 702,y: 988)
            self.view.addSubview(skipButton)
        
            playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
            playButton.setImage(UIImage(named: "next"), for: .normal)
            playButton.addTarget(self, action: #selector(self.teachnext), for: .touchUpInside)
            playButton.center = CGPoint(x: 650,y: 490)
            self.view.addSubview(playButton)
       }
    func teachstep(){
        settextpicturenum = steps
        if steps == 0{
            beforeBT.isEnabled = false
            teasetthing()
            teacimg()
        }
        else if steps == 1{
            teacimg()
            //self.speakcon.isHidden = true //textcontrol
           // self.text_picture.removeFromSuperview()
           // self.playButton.removeFromSuperview()
           // teacimg()
        }
        else if steps == 2{
            self.views.isHidden = true//??
            self.speak_picture.isHidden = true
            self.text_picture.isHidden = true
            self.playButton.isHidden = true
            self.skipButton.isHidden = true
            sbebtn = 0  //close showbefore btn
          //  self.finger_picture.isHidden = false
        }
        else if steps == 9{
            nottouch()
            settextpicturenum = 2
            teasetthing()
            teacimg()
        }
        else if steps == 10{
            self.views.isHidden = true
            self.speak_picture.isHidden = true
            self.text_picture.isHidden = true
            self.playButton.isHidden = true
            self.skipButton.isHidden = true
            self.view.addSubview(finger_picture)
            sbebtn = 1
            completed = 6
        }
    }
    func teacimg() {    //teach content text
        if(settextpicture == 1){
            self.text_picture.removeFromSuperview()
            settextpicture = 0
        }
        let teacimgs=["timg50","timg51","timg55"]
        let seatsize = CGRect.init(x: 180, y: 330, width: 470, height: 120)
        let x = UIImage(named: teacimgs[settextpicturenum] )
        text_picture = UIImageView(image: x,highlightedImage:x)
        text_picture.frame = seatsize
        self.view.addSubview(text_picture)
        settextpicture = 1
    }
    @IBAction func teacend(){   //skipbtn event
        completed = 999;
        self.speak_picture.isHidden = true
        self.views.isHidden = true
        self.playButton.isHidden = true
        self.skipButton.isHidden = true
        self.text_picture.isHidden = true
        beforeBT.isEnabled = true
        //enbtn()
    }
}
