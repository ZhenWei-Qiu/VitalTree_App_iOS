//
//  viewcontrollertree.swift
//  treeapp2
//
//  Created by Apple on 2019/3/26.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
var story = -1;
var begintest = 0;
var user_ans = -1;
var rand = -1;
class viewcontrollertree: UIViewController {
   
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    let URL_EXECSQLUPDATE = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlUpdate.php"
    @IBOutlet weak var wrongImage: UIImageView!
    @IBOutlet weak var testresultLabel: UILabel!
    @IBOutlet weak var seedokbtn: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var checkbtn: UIButton!
    @IBOutlet weak var choose: UIImageView!
    @IBOutlet weak var btn1: UIButton!
    @IBOutlet weak var btn2: UIButton!
    @IBOutlet weak var btn3: UIButton!
    @IBOutlet weak var btn4: UIButton!
    @IBOutlet weak var btn5: UIButton!
    @IBOutlet weak var correct1: UIButton!
    @IBOutlet weak var correct2: UIButton!
    @IBOutlet weak var correct3: UIButton!
    @IBOutlet weak var correct4: UIButton!
    @IBOutlet weak var correct5: UIButton!
    
    @IBOutlet weak var beforebtn: UIButton!
    @IBOutlet weak var imgTips: UIImageView!
    @IBOutlet weak var labTips: UILabel!
    @IBOutlet weak var btnTips: UIButton!
    @IBOutlet weak var btnUnityStart: UIButton!
    @IBOutlet weak var btnUnityStop: UIButton!
    @IBOutlet var tipbutton: UIButton!
    
    @IBOutlet var views: UIView!
    @IBOutlet var stage_picture: UIImageView!
    @IBOutlet var finger_picture: UIImageView!
    @IBOutlet var speak_picture: UIImageView!
    @IBOutlet var text_picture: UIImageView!
    @IBOutlet var arrow2: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    @IBOutlet var speakcon: UILabel!
    var from = 0
    var completed = 0
    var steps = 0
    var hasfinpic = 0
    var hastexpic = 0
    var haschange = 0
    var iscorrect = 0
    
    var seedupdate = 0;
    var seedtemp = 0;
    var seedtemparray = [0,0,0,0,0]
    
    let choosetest = UIImageView(image:UIImage(named:"choose_test"));
    let t1_1 = UIImageView(image:UIImage(named:"t1-1"))
    let t2_1 = UIImageView(image:UIImage(named:"t2-1"))
    let t3_1 = UIImageView(image:UIImage(named:"t3-1"))
    let t4_1 = UIImageView(image:UIImage(named:"t4-1"))
    let t5_1 = UIImageView(image:UIImage(named:"t5-1"))
    let t1_2 = UIImageView(image:UIImage(named:"t1-2"))
    let t2_2 = UIImageView(image:UIImage(named:"t2-2"))
    let t3_2 = UIImageView(image:UIImage(named:"t3-2"))
    let t4_2 = UIImageView(image:UIImage(named:"t4-2"))
    let t5_2 = UIImageView(image:UIImage(named:"t5-2"))
    
    let seed1 = UIImageView(image:UIImage(named:"seed-1"))
    let seed2 = UIImageView(image:UIImage(named:"seed-2"))
    let seed3 = UIImageView(image:UIImage(named:"seed-3"))
    let seed4 = UIImageView(image:UIImage(named:"seed-4"))
    let seed5 = UIImageView(image:UIImage(named:"seed-5"))
    var disenBTn = 0
    var seedimage = [UIImageView]()
    var testimage = [UIImageView]()
    var testimage2 = [UIImageView]()
    var answer = [3,3,3,1,1];
    var answer2 = [1,3,1,1,3];
    var hasread = [0,0,0,0,0]
    var tarrow = 0
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        storySelect()
        Thread.sleep(forTimeInterval:0.6)
        
        story = -1
        testimage.append(t1_1)
        testimage.append(t2_1)
        testimage.append(t3_1)
        testimage.append(t4_1)
        testimage.append(t5_1)
        testimage2.append(t1_2)
        testimage2.append(t2_2)
        testimage2.append(t3_2)
        testimage2.append(t4_2)
        testimage2.append(t5_2)
        
        seedimage.append(seed1)
        seedimage.append(seed2)
        seedimage.append(seed3)
        seedimage.append(seed4)
        seedimage.append(seed5)
        
        //btnUnityStart.isEnabled = false
        //btnUnityStop.isEnabled = false
        //showChoose()
        imgTips.isHidden = true
        labTips.isHidden = true
        btnTips.isHidden = true
        
        tipbutton = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 110))
        tipbutton.setImage(UIImage(named: "light-1"), for: .normal)
        tipbutton.addTarget(self, action: #selector(self.showtip), for: .touchUpInside)
        tipbutton.center = CGPoint(x: 702,y: 80)
        self.view.addSubview(tipbutton)
        if(completed == 1 && from == 1){
            teachstep()
            completed+=1
        }
        if(from == 0){
            checkbtn.isHidden = true;
        }
        
    }
    func showChoose(){
        for i in 0...4{
            if hasread[i] == 1{
                if i == 0{
                    btn1.isEnabled = false
                    correct1.isHidden = false
                }
                if i == 1{
                    btn2.isEnabled = false
                    correct2.isHidden = false
                }
                if i == 2{
                    btn3.isEnabled = false
                    correct3.isHidden = false
                }
                if i == 3{
                    btn4.isEnabled = false
                    correct4.isHidden = false
                }
                if i == 4{
                    btn5.isEnabled = false
                    correct5.isHidden = false
                }
            }
        }
    }
    func closeChoose(){
        correct1.isHidden = true
        correct2.isHidden = true
        correct3.isHidden = true
        correct4.isHidden = true
        correct5.isHidden = true
    }
    func seedchangetemp(){
        //seedupdate = 1
        if(seedupdate == 1){
            
        }
    }
    @IBAction func showappbegin() {
        if(from == 1 ){
            if let controller = storyboard?.instantiateViewController(withIdentifier: "gamepage") as? viewcontroller_game {
                controller.completed = self.completed
                
                present(controller, animated: true, completion: nil)
            }
        }
        else{
            if let controller = storyboard?.instantiateViewController(withIdentifier: "appbegin2")  {
                present(controller, animated: true, completion: nil)
            }
        }
    }
    @objc func showtip(){
           imgTips.isHidden = false
           labTips.isHidden = false
           btnTips.isHidden = false
       }
    
    @objc func handleUnityReady() {
        print("handleUnityReady")
        showUnitySubView()
    }
    
    func showUnitySubView() {
        if let unityView = UnityGetGLView() {
            // insert subview at index 0 ensures unity view is behind current UI view
            view?.insertSubview(unityView, at: 0)
            //view?.addSubview(unityView)
            
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
        
        showUnitySubView()
       
        
    }
    @IBAction func conbtn(btnen:Bool){
        btnUnityStart.isEnabled = btnen
        btnUnityStop.isEnabled = btnen
        checkbtn.isEnabled = btnen
        checkbtn.isEnabled = btnen
        if(btn1.isHidden == false){
            btn1.isEnabled = btnen
            btn2.isEnabled = btnen
            btn3.isEnabled = btnen
            btn4.isEnabled = btnen
            btn5.isEnabled = btnen
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
    
    @IBAction func closeTips(_ sender: UIButton) {
        if(disenBTn != 1){
            btnUnityStart.isEnabled = true
            btnUnityStop.isEnabled = true
            
        }
        imgTips.isHidden = true
        labTips.isHidden = true
        btnTips.isHidden = true
    }
    @IBAction func teachtest(nowstep :Int){
        if(completed == 2){
            steps = nowstep
            teachstep()
        }
    }
    @IBAction func teachnext(){
           steps += 1;
           teachstep();
       }
       @IBAction func teasetthing(){
        //let comtofin = [260,700,480,700,700];//go to where
           
        let frame = CGRect(x: 0, y: 0, width: 800, height: 1100)
        views = UIView(frame: frame)
        views.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        self.view.addSubview(views)
          
        let x = UIImage(named:"speak2" )
        speak_picture = UIImageView(image: x,highlightedImage:x)
        speak_picture.frame = CGRect.init(x: 30, y: 230, width: 710, height: 250)
        self.view.addSubview(speak_picture)
        teacimg()

        skipButton = UIButton(frame: CGRect(x: 0, y: 0, width: 115, height: 64))
        skipButton.setImage(UIImage(named: "skip"), for: .normal)
        skipButton.addTarget(self, action: #selector(self.teacend), for: .touchUpInside)
        skipButton.center = CGPoint(x: 702,y: 988)
        self.view.addSubview(skipButton)
        
        playButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        playButton.setImage(UIImage(named: "next"), for: .normal)
        playButton.addTarget(self, action: #selector(self.teachnext), for: .touchUpInside)
        playButton.center = CGPoint(x: 650,y: 460)
        self.view.addSubview(playButton)
       }
    
    func teacimg() {    //teach content text
        if(hastexpic == 1){
            self.text_picture.removeFromSuperview()
        }
        let teacimgs=["timg10","timg11","timg12","timg13","timg13"]
        let x = UIImage(named: teacimgs[steps] )
        text_picture = UIImageView(image: x,highlightedImage:x)
        text_picture.frame = CGRect.init(x: 180, y: 300, width: 470, height: 120)
        self.view.addSubview(text_picture)
        hastexpic = 1
    }
    func teacarr() {    //teach content text
        if(tarrow == 1){
            self.arrow2.removeFromSuperview()
            //self.arrow2.removeFromSuperview()
        }
        let fingx = [300,600,550];
        let fingy = [85,85,80];
        arrow2 = UIImageView(image: UIImage(named:"arrow2" ),highlightedImage:UIImage(named:"arrow2" ))
        arrow2.transform = CGAffineTransform(rotationAngle: CGFloat(-90));
        arrow2.frame = CGRect.init(x:fingx[tarrow], y: fingy[tarrow], width: 100, height: 50)
        self.view.addSubview(arrow2)
        tarrow += 1
    }
    func teacfin() {    //teach content text
        if(hasfinpic == 1){
            self.finger_picture.removeFromSuperview()
        }
        let fingx = [640,610,700];
        let fingy = [80,450,700];
        let finger = UIImage(named:"finger" )
        finger_picture = UIImageView(image: finger,highlightedImage:finger)
        finger_picture.frame = CGRect.init(x:fingx[steps/2 - 1], y: fingy[steps/2 - 1], width: 80, height: 80)
        self.view.addSubview(finger_picture)
        hasfinpic = 1
    }
    
    func teachstep(){
        disenBTn = 1
        if steps == 0{
            beforebtn.isEnabled = false
            conbtn(btnen: false)
            teasetthing()
        }
        else if steps == 1{
            teacarr()
            teacimg()
            views.isHidden = true
        }
        else if steps == 2{
            teacarr()
            teacimg()
            //conbtn(btnen: true)
        }
        else if steps == 3{
            disenBTn = 0
            self.arrow2.removeFromSuperview()
            self.text_picture.removeFromSuperview()
            hastexpic = 0
            conbtn(btnen: true)
            teachidden(thidden:true)
        }
        else if steps == 4{ //391
            
            teachidden(thidden : false)
            teacimg()
            conbtn(btnen: false)
        }
        else if steps == 5{
            let finger = UIImage(named:"finger" )
            finger_picture = UIImageView(image: finger,highlightedImage:finger)
            finger_picture.frame = CGRect.init(x:100, y: 80, width: 80, height: 80)
            self.view.addSubview(finger_picture)
            self.text_picture.removeFromSuperview()
            hastexpic = 0
            teachidden(thidden : true)
            beforebtn.isEnabled = true
            
            //conbtn(btnen: true)
        }
    }
    
    @IBAction func teacend(){   //skipbtn event
        if( steps <= 2 && steps >= 1 ){
            self.arrow2.removeFromSuperview()
        }
        completed = 999;
        self.views.isHidden = true
        self.playButton.isHidden = true
        self.skipButton.isHidden = true
        self.text_picture.isHidden = true
        self.speak_picture.isHidden = true
        beforebtn.isEnabled = true
        conbtn(btnen:true)
        steps = 0
        modes = 1
        //enbtn()
    }
    
    @IBAction func teachidden(thidden:Bool){   //skipbtn event
        self.views.isHidden = thidden
        self.text_picture.isHidden = thidden
        self.speak_picture.isHidden = thidden
        self.playButton.isHidden = thidden
        self.skipButton.isHidden = thidden
        //self.finger_picture.isHidden = !thidden
    }
    
    @IBAction func okclick(_ sender: Any) {
        wrongImage.isHidden = true
        seedimage[story].isHidden = true
        seedokbtn.isHidden = true
        testresultLabel.isHidden = true
        begintest = 0
        btn2.isHidden = true
        btn3.isHidden = true
        btn4.isHidden = true
        checkbtn.isHidden = false
        btnUnityStart.isHidden = false
        btnUnityStop.isHidden = false
        Thread.sleep(forTimeInterval:0.8)
        if(completed == 2 && steps == 3 && iscorrect == 1 && haschange == 1){
            teachtest(nowstep: 4 )
        }
    }
    @IBAction func cancelclick(_ sender: Any) {
        cancel.isHidden = true
        choose.isHidden = true
        checkbtn.isHidden = false
        btn1.isHidden = true
        btn2.isHidden = true
        btn3.isHidden = true
        btn4.isHidden = true
        btn5.isHidden = true
        btnUnityStart.isHidden = false
        btnUnityStop.isHidden = false
        closeChoose()
    }
    @IBAction func testclick(_ sender: Any) {
        storySelect()
        Thread.sleep(forTimeInterval:0.8)
        checkbtn.isHidden = true
        cancel.isHidden = false
        choose.isHidden = false
        btn1.isHidden = false
        btn2.isHidden = false
        btn3.isHidden = false
        btn4.isHidden = false
        btn5.isHidden = false
        btnUnityStart.isHidden = true
        btnUnityStop.isHidden = true
        print(completed)
        print(steps)
        showChoose()
        rand = Int.random(in: 0...1)
        
    }
    @IBAction func btn1_click(_ sender: Any) {
        chooseLevel(num:0)
        
    }
    
    @IBAction func btn2_click(_ sender: Any) {
        
        if(begintest == 1){
            user_ans = 1;
            if(rand == 0){
                if(user_ans == answer[story]){
                    correctTest()
                }else{
                    wrongTest()
                }
            }else{
                if(user_ans == answer2[story]){
                    correctTest()
                }else{
                    wrongTest()
                }
            }
        }
        else{
            chooseLevel(num:1)
        }
    }
    @IBAction func btn3(_ sender: Any) {
        if(begintest == 1){
            user_ans = 2;
            if(rand == 0){
                if(user_ans == answer[story]){
                    correctTest()
                }else{
                    wrongTest()
                }
            }else{
                if(user_ans == answer2[story]){
                    correctTest()
                }else{
                    wrongTest()
                }
            }
        }
        else{
            chooseLevel(num:2)
        }
    }
    @IBAction func btn4_click(_ sender: Any) {
        if(begintest == 1){
            user_ans = 3;
            if(rand == 0){
                if(user_ans == answer[story]){
                    correctTest()
                }else{
                    wrongTest()
                }
            }else{
                if(user_ans == answer2[story]){
                    correctTest()
                }else{
                    wrongTest()
                }
            }
        }
        else{
            chooseLevel(num:3)
        }
    }
    @IBAction func btn5_click(_ sender: Any) {
        chooseLevel(num:4)
    }
    func chooseLevel(num:Int){
        choose.isHidden = true
        btn1.isHidden = true
        btn5.isHidden = true
        btn2.isEnabled = true
        btn3.isEnabled = true
        btn4.isEnabled = true
        cancel.isHidden = true
        if(rand == 0){
            testimage[num].frame = CGRect(x:120, y:280, width:540, height:475)
            self.view.insertSubview(testimage[num], aboveSubview: choose)
            testimage[num].isHidden = false
        }else{
            testimage2[num].frame = CGRect(x:120, y:280, width:540, height:475)
            self.view.insertSubview(testimage2[num], aboveSubview: choose)
            testimage2[num].isHidden = false
        }
        story = num;
        begintest = 1;
        closeChoose()
    }
    func correctTest() {
        seedimage[story].frame = CGRect(x:300, y:420, width:160, height:200)//種子型態
        self.view.addSubview(seedimage[story])//種子添加到原本的view上
        testimage[story].isHidden = true
        testimage2[story].isHidden = true
        seedimage[story].isHidden = false
        seedokbtn.isHidden = false
        testresultLabel.isHidden = false
        testresultLabel.text = "+1"
        btn2.isHidden = true
        btn3.isHidden = true
        btn4.isHidden = true
        hasread[story] = 1
        haschange = 0
        iscorrect = 1
        storyInsert()
        
    }
    func wrongTest(){
        testimage[story].isHidden = true
        testimage2[story].isHidden = true
        wrongImage.isHidden = false
        seedokbtn.isHidden = false
        testresultLabel.isHidden = false
        testresultLabel.text = String(format: "答題失敗")
        btn2.isHidden = true
        btn3.isHidden = true
        btn4.isHidden = true
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
                    
                    let havereadInt = Int(havereadStr) ?? 0
                    print(uidStr)
                    print(seedStr)
                    print(newstr)
                    if(havereadInt >= 0){
                        self.hasread[havereadInt] = 1
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
    
    func storyInsert() {
        
        let uidStr = String(uid)
        let storyStr = String(story)
 
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "insert into story (uid, haveread, seed) values ('" + uidStr +  "','" + storyStr + "','" + storyStr + "')"
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
        haschange = 1
        task.resume()
    }
}
