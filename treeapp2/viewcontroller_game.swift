//
//  viewcontroller_game.swift
//  treeapp2
//
//  Created by Apple on 2019/3/26.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit

class viewcontroller_game: UIViewController {
    
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    let URL_EXECSQLUPDATE = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlUpdate.php"

    @IBOutlet weak var KindTree: UIImageView!
    @IBOutlet weak var ChildTree: UIImageView!
    @IBOutlet weak var WaterTree: UIImageView!
    @IBOutlet weak var BlindTree: UIImageView!
    @IBOutlet weak var MulberryTree: UIImageView!
    @IBOutlet weak var farmerend: UIImageView!
    

    @IBOutlet var views: UIView!
    @IBOutlet var stage_picture: UIImageView!
    @IBOutlet var finger_picture: UIImageView!
    @IBOutlet var text_picture: UIImageView!
    @IBOutlet var speak_picture: UIImageView!
    @IBOutlet var arrow2: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    @IBOutlet weak var missionbtn: UIButton!
    @IBOutlet weak var storybtn: UIButton!
    @IBOutlet weak var growbtn: UIButton!
    @IBOutlet weak var befbtn: UIButton!
    @IBOutlet weak var warehbtn: UIButton!
    @IBOutlet weak var artreebtn: UIButton!
    @IBOutlet var speakcon: UILabel!
    @IBOutlet weak var warebtn: UIButton!
    var teacobj_UIs = [UIView]()

    var fertilizernumber = 0;
    var waternumber = 0;
    var seednumber = 0;
    var warehousenumber = 0;
    var seedarray = [0,0,0,0,0];
    var hastree = [0,0,0,0,0];
    var warehousenum = 0;
    //var modes = 0;  //teach or play
    var completed = 0;  //  2 this page completed
    var steps = 0;   //teach step
    var treeimage = [UIImageView]();
    var treenumber = 0;
    
    var seedupdate = 0;
    var seedtemp = 0;
    var seedtemparraynum = [0,0,0,0,0]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print(uid)
        if(uid != -1){
            getTool()
            treeSelect()
            storySelect()
            Thread.sleep(forTimeInterval:0.8)
        }
        treeimage.append(KindTree);
        treeimage.append(ChildTree);
        treeimage.append(BlindTree);
        treeimage.append(WaterTree);
        treeimage.append(MulberryTree);
        if(steps != 999){
            steps = 0
        }
        else{
            missionbtn.isEnabled = false;
            storybtn.isEnabled = false;
            artreebtn.isEnabled = false;
            befbtn.isEnabled = false;
            warebtn.isEnabled = false;
            steps = 2
        }
        for i in 0...4{
            if hastree[i] == 1{
                treeimage[i].isHidden = false
                treenumber += 1
            }
            else{
                treeimage[i].isHidden = true
            }
        }
        for i in 0...4 {
            if seedarray[i] == 1{
                seednumber += 1
            }
        }
        
        if(modes == 1){
            completed = 999
        }
        if(completed == 999){
            modes = 1
        }
        if(modes == 0 && completed % 2 == 0 && steps != 999){
            teasetthing()
            teachstep(step:steps,gotobtn:completed);
        }
        if(treenumber == 5 && modes == 1 && modes != 2 ){
            completed = 12
            teasetthing()
            teachstep(step:steps,gotobtn:completed);
            modesUpdate(modeslevel:2)
            farmerend.isHidden = false
        }
        if(modes == 2){
            farmerend.isHidden = false
        }
    }
    
    func teachstep(step:Int,gotobtn:Int){
        if step == 0{
            missionbtn.isEnabled = false;
            storybtn.isEnabled = false;
            growbtn.isEnabled = false;
            artreebtn.isEnabled = false;
            befbtn.isEnabled = false;
            warebtn.isEnabled = false;
            if(modes != 1){
                self.finger_picture.isHidden = true
            }
            
        }
        else if step == 1{
            //self.speakcon.isHidden = true //textcontrol
            if(modes == 1 && completed == 12){
                teacend()
                modes = 2
            }
            else{
                self.text_picture.removeFromSuperview()
                teacimg()
                if(gotobtn == 10){
                    arrow2 = UIImageView(image: UIImage(named:"arrow2" ),highlightedImage:UIImage(named:"arrow2" ))
                    arrow2.transform = CGAffineTransform(rotationAngle: CGFloat(-80));
                    arrow2.frame = CGRect.init(x:660, y: 800, width: 90, height: 85)
                    skipButton.isHidden = true ;
                    self.view.addSubview(arrow2)
                }
            }
        }
        else if step == 2{
            print(gotobtn)
            print(completed)
            if(gotobtn != 0 && gotobtn != 10){
                for i in 0..<5{
                    self.teacobj_UIs[i].isHidden = true
                }
                self.text_picture.isHidden = true
                self.finger_picture.isHidden = false
                completed += 1;
            }
            else{
                self.text_picture.removeFromSuperview()
                skipButton.isHidden = false ;
                teacimg()
            }
            if(gotobtn == 10){
                self.arrow2.removeFromSuperview()
            }
            if(gotobtn == 2){
                growbtn.isEnabled = true
            }
            else if(gotobtn == 4){
                missionbtn.isEnabled = true
            }
            else if(gotobtn == 6){
                warebtn.isEnabled = true
            }
            else if(gotobtn == 8){
                growbtn.isEnabled = true
            }


            
        }
        if(completed == 0 ){
            if(steps == 3){
                self.text_picture.removeFromSuperview()
                teacimg()
            }
            else if(steps == 4){
                storybtn.isEnabled = true
                for i in 0..<5{
                    self.teacobj_UIs[i].isHidden = true
                }
                self.text_picture.isHidden = true
                self.finger_picture.isHidden = false
                completed += 1;
            }
        }
        if(completed == 10 ){
                   if(steps == 3){
                       storybtn.isEnabled = true
                       for i in 0..<5{
                           self.teacobj_UIs[i].isHidden = true
                       }
                       //self.text_picture.isHidden = true
                       //self.finger_picture.isHidden = false
                       teacend()
                   }
               }

    }
    
    @IBAction func teachnext(){
        steps += 1;
        teachstep(step:steps,gotobtn:completed);
    }
    @IBAction func teasetthing(){
        //var fingx = [260,480,700];
        let comtofin = [260,700,480,700,700];//go to where
        
        let frame = CGRect(x: 0, y: 0, width: 800, height: 1100)
        views = UIView(frame: frame)
        views.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.addSubview(views)
        teacobj_UIs.append(views)

        
        var seatsize = CGRect.init(x: 30, y: 250, width: 710, height: 250)
        let x = UIImage(named: "speak2" )
        speak_picture = UIImageView(image: x,highlightedImage:x)
        speak_picture.frame = seatsize
        self.view.addSubview(speak_picture)
        teacobj_UIs.append(speak_picture)
        teacimg()
        if(modes < 1){
            seatsize = CGRect.init(x: 0, y: 0, width: 80, height: 80)
            let finger = UIImage(named:"finger" )
            if(completed == 6){
                seatsize = CGRect.init(x: 570, y: 700, width: 80, height: 80)
            }
                
            else if(completed == 10){
                seatsize = CGRect.init(x: 600, y: 700, width: 80, height: 80)
            }
            else{
                seatsize = CGRect.init(x: comtofin[completed/2] - 10, y: 150, width: 80, height: 80)
            }
            finger_picture = UIImageView(image: finger,highlightedImage:finger)
            finger_picture.frame = seatsize
            self.view.addSubview(finger_picture)
            teacobj_UIs.append(finger_picture)
        }
        
        
        playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        playButton.setImage(UIImage(named: "next"), for: .normal)
        playButton.addTarget(self, action: #selector(self.teachnext), for: .touchUpInside)
        playButton.center = CGPoint(x: 650,y: 480)
        self.view.addSubview(playButton)
        teacobj_UIs.append(playButton)
        
        skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 64))
        skipButton.setImage(UIImage(named: "skip"), for: .normal)
        skipButton.addTarget(self, action: #selector(self.teacend), for: .touchUpInside)
        skipButton.center = CGPoint(x: 702,y: 988)
        self.view.addSubview(skipButton)
        teacobj_UIs.append(skipButton)
        
    }

    @IBAction func teacend(){   //skipbtn event
        modes=1;
        completed = 999;
        self.views.isHidden = true
        self.playButton.isHidden = true
        self.skipButton.isHidden = true
        self.text_picture.isHidden = true
        self.speak_picture.isHidden = true
        missionbtn.isEnabled = true;
        storybtn.isEnabled = true;
        growbtn.isEnabled = true;
        artreebtn.isEnabled = true;
        befbtn.isEnabled = true;
        warebtn.isEnabled = true;
        modesUpdate(modeslevel:1)
        
    }
    
    
    func teacimg() {    //teach content text
        let teacimgs=[["timg00","timg01","timg02","timg03"],["timg20","timg21"],["timg40","timg41"],["timg60","timg61"]
            ,["timg80","timg81"],["timg100","timg101","timg121","timg121"],["timg120"]]
        let x = UIImage(named: teacimgs[completed/2][steps] )
        text_picture = UIImageView(image: x,highlightedImage:x)
        text_picture.frame = CGRect.init(x: 180, y: 330, width: 470, height: 120)
        self.view.addSubview(text_picture)
        
    }
    @IBAction func showstory() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "treepage") as? viewcontrollertree{
            controller.from = 1
            controller.completed = self.completed
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showbefore() {
        
        let controller = UIAlertController(title: "提醒", message: "是否要登出遊戲？", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "好的", style: .default) { (_) in
            if let controller = self.storyboard?.instantiateViewController(withIdentifier: "appbegin2") {
                self.present(controller, animated: true, completion: nil)
                uid = -1
                
            }
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        
        
    }
    @IBAction func showgrow() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "growpage")as? viecontrollergrow{
            controller.fertilizernumber = self.fertilizernumber
            controller.waternumber = self.waternumber
            controller.seedarray = self.seedarray
            print("seedarrary:", controller.seedarray)
            controller.seednumber = self.seednumber
            controller.completed = self.completed
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showwarehouse() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "warehousepage")as? viewcontrollerwarehouse {
            controller.fertilizernumber = self.fertilizernumber
            controller.waternumber = self.waternumber
            controller.completed = self.completed
            controller.seedarray = self.seedarray
            controller.seednumber = self.seednumber
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showtask() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "taskpage") as? viecontrollertask{
            warehousenumber = seednumber + waternumber + fertilizernumber
            
            controller.completed = self.completed
            controller.warehousenumber = self.warehousenumber
            present(controller, animated: true, completion: nil)
        }
        
    }
    /*@IBAction func showargarden() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "gardenpage")as? viewcontrollergraden {
            controller.hastree = self.hastree
            present(controller, animated: true, completion: nil)
        }
        
    }*/
    func getTool()  {
        
        let uidStr = String(uid)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLSELECT)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlSelect"
        let value = "select * from collection where uid = '" + uidStr + "'"
        let param = [ key: value ]
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        request.httpBody = jsonData
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error!)")
                return;
            }
            
            //parsing the response
            do {
                //converting response to NSDictionary
                
                //let jsonString = String(data: data!, encoding: .utf8)!
                let jsonData =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let jsonData2 = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                
                let jsonString = String(data: jsonData2, encoding: .utf8)!
                
                //var a=NSString(string:jsonString)
                print("-------倉庫---------")
                print(jsonString)
                if(jsonString.contains("uid")){
                    var fertilizerStr = "0";
                    if(jsonString.contains("fertilizer")){
                        print(" get fertilizer")
                        let fertilizeri = jsonString.range(of: "fertilizer\" : \"")
                        let fertilizerj = jsonString.range(of: "\",")
                        fertilizerStr = String(jsonString[(fertilizeri?.upperBound)!..<(fertilizerj?.lowerBound)!])
                        
                        }
                    
                    var newi = jsonString.range(of: "uid\" : \"")
                    var newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let uidi = newstr.range(of: "uid\" : \"")
                    let uidj = newstr.range(of: "\",")
                    let uidStr = String(newstr[(uidi?.upperBound)!..<(uidj?.lowerBound)!])
                    newi = jsonString.range(of: "water\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    var waterStr = "0";
                    if(jsonString.contains("water")){
                    let wateri = newstr.range(of: "water\" : \"")
                    let waterj = newstr.range(of: "\",")
                    waterStr = String(newstr[(wateri?.upperBound)!..<(waterj?.lowerBound)!])
                    }
                    newi = jsonString.range(of: "cid\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let cidi = newstr.range(of: "cid\" : \"")
                    let cidj = newstr.range(of: "\"\n")
                    let cidStr = String(newstr[(cidi?.upperBound)!..<(cidj?.lowerBound)!])
                    
                    print("======")
                    print(cidStr)
                    print(uidStr)
                    print(waterStr)
                    print(fertilizerStr)
                    self.fertilizernumber = Int(fertilizerStr)!
                    self.waternumber = Int(waterStr)!
                    
                    
                }
                //switch to main thread
                
                
            } catch {
                print(error)
            }
        }
        
        print("uid")
       
        //executing the task
        task.resume()
        
    }
    
    func treeSelect() {
        
        let uidStr = String(uid)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLSELECT)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlSelect"
        let value = "select * from tree where uid = '" + uidStr + "'"
        let param = [ key: value ]
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        request.httpBody = jsonData
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error!)")
                return;
            }
            
            //parsing the response
            do {
                //converting response to NSDictionary
                
                //let jsonString = String(data: data!, encoding: .utf8)!
                let jsonData =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let jsonData2 = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                let jsonString = String(data: jsonData2, encoding: .utf8)!
                
                //var a=NSString(string:jsonString)
                print(jsonString)
                
                var newi = jsonString.range(of: "uid\" : \"")
                var newstr = ""
                if(jsonString.contains("\"uid\"")){
                    newi = jsonString.range(of: "uid\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                }
                while(newstr.contains("uid\"")){
                    
                    let uidi = newstr.range(of: "uid\" : \"")
                    let uidj = newstr.range(of: "\",")
                    let uidStr = String(newstr[(uidi?.upperBound)!..<(uidj?.lowerBound)!])
                    newi = newstr.range(of: "tree\" : \"")
                    newstr = String(newstr[(newi?.lowerBound)!... ])
                    let treei = newstr.range(of: "tree\" : \"")
                    let treej = newstr.range(of: "\"\n")
                    let treeStr = String(newstr[(treei?.upperBound)!..<(treej?.lowerBound)!])
                
                    let treeInt = Int(treeStr) ?? 0
                    print(uidStr)
                    print(treeStr)
                    print(newstr)
                    if(treeInt >= 0){
                        self.hastree[treeInt] = 1
                    }
                    if(newstr.contains("\"uid\"")){
                        print("＝＝＝＝")
                        newi = newstr.range(of: "uid\" : \"")
                        newstr = String(newstr[(newi?.lowerBound)!... ])
                        print(newstr)
                    }
                    
                }
                //switch to main thread
                
                
            } catch {
                print(error)
            }
        }
        //executing the task
        task.resume()
    }
    func storySelect() {
        
        let uidStr = String(uid)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLSELECT)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlSelect"
        let value = "select * from story where uid = '" + uidStr + "'"
        let param = [ key: value ]
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        request.httpBody = jsonData
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error!)")
                return;
            }
            
            //parsing the response
            do {
                //converting response to NSDictionary
                
                //let jsonString = String(data: data!, encoding: .utf8)!
                let jsonData =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let jsonData2 = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                let jsonString = String(data: jsonData2, encoding: .utf8)!
                
                //var a=NSString(string:jsonString)
                print("----------------seedarrary-------------")
                print(jsonString)
                
                var newi = jsonString.range(of: "uid\" : \"")
                var newstr = ""
                if(jsonString.contains("\"uid\"")){
                    newi = jsonString.range(of: "uid\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                }
                while(newstr.contains("uid\"")){
                    
                    let uidi = newstr.range(of: "uid\" : \"")
                    let uidj = newstr.range(of: "\",")
                    let uidStr = String(newstr[(uidi?.upperBound)!..<(uidj?.lowerBound)!])
                    newi = newstr.range(of: "haveread\" : \"")
                    newstr = String(newstr[(newi?.lowerBound)!... ])
                    let havereadi = newstr.range(of: "haveread\" : \"")
                    let havereadj = newstr.range(of: "\",")
                    let havereadStr = String(newstr[(havereadi?.upperBound)!..<(havereadj?.lowerBound)!])
                    newi = newstr.range(of: "seed\" : \"")
                    newstr = String(newstr[(newi?.lowerBound)!... ])
                    let seedi = newstr.range(of: "seed\" : \"")
                    let seedj = newstr.range(of: "\"\n")
                    let seedStr = String(newstr[(seedi?.upperBound)!..<(seedj?.lowerBound)!])
                    
                    let seedInt = Int(seedStr) ?? 0
                    print(uidStr)
                    print(havereadStr)
                    print(newstr)
                    if(seedInt >= 0){
                        self.seedarray[seedInt] = 1
                    }
                    if(newstr.contains("\"uid\"")){
                        print("＝＝＝＝")
                        newi = newstr.range(of: "uid\" : \"")
                        newstr = String(newstr[(newi?.lowerBound)!... ])
                        print(newstr)
                    }
                    
                }
                //switch to main thread
                
                
            } catch {
                print(error)
            }
        }
        //executing the task
        task.resume()
    }
    func modesUpdate(modeslevel:Int) {
        
        let uidStr = String(uid)
        let modesStr = String(modeslevel)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "update member set modes = '" + modesStr + "' where uid = '" + uidStr + "'"
        let param = [ key: value ]
        let jsonData = try? JSONSerialization.data(withJSONObject: param)
        request.httpBody = jsonData
        
        //creating a task to send the post request
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            if error != nil{
                print("error is \(error!)")
                return;
            }
            
            //parsing the response
            do {
                
                //let jsonString = String(data: data!, encoding: .utf8)!
                let jsonData =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                let jsonData2 = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
                let jsonString = String(data: jsonData2, encoding: .utf8)!
                print(jsonString)
                
            } catch {
                print(error)
            }
        }
        //executing the task
        task.resume()
    }
}

