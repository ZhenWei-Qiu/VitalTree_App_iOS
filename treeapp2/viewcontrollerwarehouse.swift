//
//  viewcontrollerwarehouse.swift
//  treeapp2
//
//  Created by Apple on 2019/3/26.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class viewcontrollerwarehouse: UIViewController {
    let URL_EXECSQLUPDATE = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlUpdate.php"
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    var fertilizernumber: Int = 0
    var waternumber: Int = 0
    var seedarray = [Int]()
    var completed = 0
    var seednumber = 0
    @IBOutlet var views: UIView!
    @IBOutlet var stage_picture: UIImageView!
    @IBOutlet var finger_picture: UIImageView!
    @IBOutlet var text_picture: UIImageView!
    @IBOutlet var speak_picture: UIImageView!
    @IBOutlet weak var lbNum1: UILabel!
    @IBOutlet weak var lbNum2: UILabel!
    var steps = 0
    var position = 0
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        let seatx=[123,320,510];
        let seaty=[290,515,727];
        
        let watering = UIImage(named: "water2")
        let fertilizer = UIImage(named: "fertilizer")
        let seed1 = UIImage(named: "seed-1")
        let seed2 = UIImage(named:"seed-2")
        let seed3 = UIImage(named:"seed-3")
        let seed4 = UIImage(named:"seed-4")
        let seed5 = UIImage(named:"seed-5")
        var seedimage = [UIImage]()
        
        seedimage.append(seed1!)
        seedimage.append(seed2!)
        seedimage.append(seed3!)
        seedimage.append(seed4!)
        seedimage.append(seed5!)
  
        
        var seats = [CGRect]()
        for i in 0...2 {
            for j in 0...2 {
                seats.append(CGRect.init(x: seatx[i], y: seaty[j], width: 145, height: 160))
            }
        }
        print(waternumber)
        print(fertilizernumber)
        lbNum1.text = "";
        lbNum2.text = "";
        
        var fertilizer_UIs = [UIImageView]()
        if(fertilizernumber>0){
            fertilizer_UIs.append(UIImageView(image: fertilizer,highlightedImage: fertilizer))
            fertilizer_UIs[position].frame = seats[position]
            self.view.addSubview(fertilizer_UIs[position])
            print("fff")
            position = position+1
            lbNum1.text = "X"+String(fertilizernumber)
        }
        
        var water_UIs = [UIImageView]()
        if(waternumber>0){
            var tmp = 0
            if(fertilizernumber>0){
                tmp = 1
            }
            water_UIs.append(UIImageView(image: watering,highlightedImage: watering))
            water_UIs[position-tmp].frame = seats[position]
            self.view.addSubview(water_UIs[position-tmp])
            print("www")
            if(fertilizernumber>0){
                lbNum2.text = "X"+String(waternumber)
            }else{
                lbNum1.text = "X"+String(waternumber)
            }
            position=position+1
        }
        
        if(completed == 7 ){
            teachstep();
        }
        var seed_UIs = [UIImageView]()
        var k = position
        for i in 0...4{
            if(seedarray[i] == 1){
                seed_UIs.append(UIImageView(image: seedimage[i],highlightedImage: seedimage[i]))
                seed_UIs[k-(position)].frame = seats[k]
                self.view.addSubview(seed_UIs[k-(position)])
                k += 1
            }
        }
        
    }
    @IBAction func teasetthing(){
        let frame = CGRect(x: 0, y: 0, width: 800, height: 1100)
        views = UIView(frame: frame)
        views.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.addSubview(views)
        
        skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 64))
        skipButton.setImage(UIImage(named: "skip"), for: .normal)
        skipButton.addTarget(self, action: #selector(self.teacend), for: .touchUpInside)
        skipButton.center = CGPoint(x: 702,y: 988)
        self.view.addSubview(skipButton)
        
        var seatsize = CGRect.init(x: 60, y: 45, width: 680, height: 225)
        let x = UIImage(named: "speak2" )
        speak_picture = UIImageView(image: x,highlightedImage:x)
        speak_picture.frame = seatsize
        self.view.addSubview(speak_picture)
        
        seatsize = CGRect.init(x: 80, y: 80, width: 80, height: 80)
        let finger = UIImage(named:"finger" )
        finger_picture = UIImageView(image: finger,highlightedImage:finger)
        finger_picture.frame = seatsize
        
        playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        playButton.setImage(UIImage(named: "next"), for: .normal)
        playButton.addTarget(self, action: #selector(self.teachnext), for: .touchUpInside)
        playButton.center = CGPoint(x: 665,y: 260)
        self.view.addSubview(playButton)
    }
    func teactextimg() {    //teach content text
        let teacimgs=["timg70","timg71","timg72"]
        let seatsize = CGRect.init(x: 200, y: 100, width: 470, height: 120)
        let x = UIImage(named: teacimgs[steps] )
        text_picture = UIImageView(image: x,highlightedImage:x)
        text_picture.frame = seatsize
        self.view.addSubview(text_picture)

    }
    @IBAction func teachnext(){
        steps += 1;
        teachstep();
    }
    func teachstep(){
        if steps == 0{
            teasetthing()
            teactextimg()
        }
        else if steps == 1{
            self.text_picture.removeFromSuperview()
            teactextimg()
            
        }
        else if steps == 2{
            self.text_picture.removeFromSuperview()
            teactextimg()
        }
        else if steps == 3{
            self.view.addSubview(finger_picture)
            self.views.isHidden = true
            self.text_picture.isHidden = true
            self.speak_picture.isHidden = true
            self.playButton.isHidden = true
            self.skipButton.isHidden = true
            //self.finger_picture.isHidden = false
            completed += 1;
        }
        
    }
    @IBAction func teacend(){   //skipbtn event
        completed = 999;
        self.views.isHidden = true
        self.text_picture.isHidden = true
        self.speak_picture.isHidden = true
        self.playButton.isHidden = true
        self.skipButton.isHidden = true
        modes = 1
    }
    @IBAction func showbefore() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "gamepage")as? viewcontroller_game {
            controller.completed = self.completed
            present(controller, animated: true, completion: nil)
        }
        
    }
    
    /* @IBAction func showtree() {
     
     if let controller = storyboard?.instantiateViewController(withIdentifier: "treepage") {
     present(controller, animated: true, completion: nil)
     }
     
     }*/
    
}

