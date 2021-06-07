//
//  viewcontrollergrow.swift
//  treeapp2
//
//  Created by Apple on 2019/3/26.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit

class viecontrollertask2: UIViewController {
    var number=0;
    let picturen=["p0","p1","p2","p3","p4","p5","p6","p7"]
    
    var steps = 0
    var sbebtn = 1
    var missionteacend = 0
    
    var warehousenumber = 0
    @IBOutlet weak var beforeBT: UIButton!
    @IBOutlet var views: UIView!
    //  @IBOutlet var stage_picture: UIImageView!
    @IBOutlet var finger_picture: UIImageView!
    @IBOutlet var text_picture: UIImageView!
    @IBOutlet var speak_picture: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let seatsize = CGRect.init(x: 200, y: 300, width: 400, height: 500)
        let stage_picture: UIImageView
        number = Int.random(in: 0..<8)
        while number == 2 {
            number = Int.random(in: 0..<8)
        }
        let x = UIImage(named: picturen[number])
        stage_picture = UIImageView(image: x,highlightedImage:x)
        stage_picture.frame = seatsize
        self.view.addSubview(stage_picture)
        if(steps == 3){
            teachstep()
        }
    }
    @IBAction func showbefore() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "taskpage") as? viecontrollertask{
            controller.steps = self.steps 
            controller.missionteacend = self.missionteacend
            present(controller, animated: true, completion: nil)
        }
        
    }
     @IBAction func showfind() {
     if let controller = storyboard?.instantiateViewController(withIdentifier: "findpage")as?viewcontrollerfind2 {
        if(steps == 5){
            steps += 1
        }
        controller.warehousenumber = self.warehousenumber
        controller.steps = self.steps
        controller.picture = picturen[number] + "3d"
     present(controller, animated: true, completion: nil)
        
     }
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
        
            let seatsize = CGRect.init(x: 30, y: 250, width: 710, height: 250)
            let x = UIImage(named: "speak2" )
            speak_picture = UIImageView(image: x,highlightedImage:x)
            speak_picture.frame = seatsize
            self.view.addSubview(speak_picture)
           
           
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
        if steps == 3{
            beforeBT.isEnabled = false
            teasetthing()
            teacimg()
        }
        else if steps == 4{
           teacimg()
        }
        else if steps == 5{
            self.views.isHidden = true
            //self.stage_picture.isHidden = true
            self.text_picture.isHidden = true
            self.speak_picture.isHidden = true
            self.playButton.isHidden = true
            self.skipButton.isHidden = true
            sbebtn = 0  //close showbefore btn
        }
    }
    func teacimg() {    //teach content text
        if(steps == 4){
            text_picture.removeFromSuperview();
        }
        let teacimgs=["timg52","timg53"]
        let seatsize = CGRect.init(x: 180, y: 330, width: 470, height: 120)
        let x = UIImage(named: teacimgs[steps-3] )
        text_picture = UIImageView(image: x,highlightedImage:x)
        text_picture.frame = seatsize
        self.view.addSubview(text_picture)
    }
    @IBAction func teacend(){   //skipbtn event
        self.speak_picture.isHidden = true
        self.views.isHidden = true
        self.playButton.isHidden = true
        self.skipButton.isHidden = true
        self.text_picture.isHidden = true
        beforeBT.isEnabled = true
        steps = 0
        missionteacend = 1
        //enbtn()
    }
    
}

