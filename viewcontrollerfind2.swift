//
//  viewcontrollerfind2.swift
//  treeapp2
//
//  Created by Apple on 2019/4/22.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit
import ARKit

class viewcontrollerfind2: UIViewController {
    var waternumber = 0
    var fertilizernumber = 0
    var warehousenumber = 0
    var picture:String = ""
    let URL_EXECSQLUPDATE = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlUpdate.php"
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    @IBOutlet weak var wallBtn: UIButton!
    @IBOutlet weak var doctor: UIImageView!
    @IBOutlet weak var introduction: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var getWord: UILabel!
    @IBOutlet weak var tips: UIImageView!
    @IBOutlet weak var lightBtn: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var beforeBT: UIButton!
    @IBOutlet weak var okBtnget: UIButton!
    @IBOutlet weak var waterget: UIImageView!//water
    @IBOutlet weak var getthing: UIImageView!//fertilizer
    let fadeDuration: TimeInterval = 0.3
    let rotateDuration: TimeInterval = 3
    let waitDuration: TimeInterval = 0.5
    var number = -1
    let p1 = UIImageView(image:UIImage(named:"p1"))
    let p0 = UIImageView(image:UIImage(named:"p0"))
    let p3 = UIImageView(image:UIImage(named:"p3"))
    let p4 = UIImageView(image:UIImage(named:"p4"))
    let p5 = UIImageView(image:UIImage(named:"p5"))
    let p6 = UIImageView(image:UIImage(named:"p6"))
    let p7 = UIImageView(image:UIImage(named:"p7"))
    @IBOutlet var views: UIView!
    //@IBOutlet var stage_picture: UIImageView!
    @IBOutlet var finger_picture: UIImageView!
    @IBOutlet var text_picture: UIImageView!
    @IBOutlet var speak_picture: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    var steps = 0
    var sbebtn = 1
    var missionteacend = 0
    //var stepf = 0
    var findThing = [UIImageView]()
    var type = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        if(uid != -1){
            getTool()
        }
        tips.isHidden = true;
        okBtn.isHidden = true;
        message.isHidden = true;
        getthing.isHidden = true;
        waterget.isHidden = true;
        getWord.isHidden = true;
        okBtnget.isHidden = true;
        wallBtn.isHidden = true;
        sceneView.delegate = self
        configureLighting()
        findThing.append(p0);
        findThing.append(p1);
        findThing.append(p0);
        findThing.append(p3);
        findThing.append(p4);
        findThing.append(p5);
        findThing.append(p6);
        findThing.append(p7);
        if picture == "p03d"{
            type = 0;
        }else if picture == "p13d"{
            type = 1;
        }else if picture == "p33d"{
            type = 3;
        }else if picture == "p43d"{
            type = 4;
        }else if picture == "p53d"{
            type = 5;
        }else if picture == "p63d"{
            type = 6;
        }else if picture == "p73d"{
            type = 7;
        }
        findThing[type].frame = CGRect(x:650, y:800, width:100, height:125)//*
        self.view.addSubview(findThing[type]);
        findThing[type].isHidden = false;
        
        if(steps != 0 ){
            teachstep()
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
           // teacimg()
           
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
        if steps == 6{
            beforeBT.isEnabled = false
            teasetthing()
            teacimg()
        }
        
        else if steps == 7{
            self.views.isHidden = true
            //self.stage_picture.isHidden = true
            self.text_picture.isHidden = true
            self.speak_picture.isHidden = true
            self.playButton.isHidden = true
            self.skipButton.isHidden = true
            sbebtn = 0  //close showbefore btn
          //  self.finger_picture.isHidden = false
        }
    }
    func teacimg() {    //teach content text
        let teacimgs=["timg54"]
        let seatsize = CGRect.init(x: 180, y: 330, width: 470, height: 120)
        let x = UIImage(named: teacimgs[steps-6] )
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
        self.speak_picture.isHidden = true
        beforeBT.isEnabled = true
        steps = 0
        //enbtn()
    }
    @IBAction func closeIntroduction(_ sender: Any) {
        doctor.isHidden = true;
        wallBtn.isHidden = true;
        introduction.isHidden = true;
        titleLabel.isHidden = true;
        introductionLabel.isHidden = true;
        let Queue : DispatchQueue = DispatchQueue(label: "Queue")
        Queue.sync{
        if(uid != -1){
            getTool()
        }
        }
        
        if modes == 0{
            self.number = 0
        }
        else{
            self.number = Int.random(in: 0..<2)
        }
        if(self.number == 0){
            self.getthing.isHidden = false;
            if(uid != -1){
                fertilizernumUpdate()
            }
        }else{
            self.waterget.isHidden = false;
            if(uid != -1){
                waternumUpdate()
            }
        }
        self.label.text = "成功突破任務"
        self.okBtnget.isHidden = false;
        self.getWord.isHidden = false;
        findThing[type].isHidden = true;
        
    }
    @IBAction func tipsShow(_ sender: Any) {
        tips.isHidden = false;
        okBtn.isHidden = false;
        message.isHidden = false;
    }
    @IBAction func tipsHide(_ sender: Any) {
        tips.isHidden = true;
        okBtn.isHidden = true;
        message.isHidden = true;
    }
    @IBAction func showbefore() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "taskpage") as? viecontrollertask{
            controller.steps = self.steps
            controller.warehousenumber = self.warehousenumber
            controller.missionteacend = self.missionteacend
            present(controller, animated: true, completion: nil)
        }
        
    }
    @IBAction func showbeforeget() {
        print("++++++++++++++++++++++")
        if let controller = storyboard?.instantiateViewController(withIdentifier: "taskpage") as? viecontrollertask {
            print(steps)
            if(steps == 7){
                steps += 2
            }
            warehousenumber += 1
            print(warehousenumber)
            controller.steps = self.steps
            controller.warehousenumber = self.warehousenumber
            present(controller, animated: true, completion: nil)
        }
        
    }
    lazy var fadeAndSpinAction: SCNAction = {
        return .sequence([
            .fadeIn(duration: fadeDuration),
            .rotateBy(x: 0, y: 0, z: CGFloat.pi * 360 / 180, duration: rotateDuration),
            .wait(duration: waitDuration),
            .fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var fadeAction: SCNAction = {
        return .sequence([
            .fadeOpacity(by: 0.8, duration: fadeDuration),
            .wait(duration: waitDuration),
            .fadeOut(duration: fadeDuration)
            ])
    }()
    
    lazy var treeNode: SCNNode = {
        guard let scene = SCNScene(named: "tree.scn"),
            let node = scene.rootNode.childNode(withName: "tree", recursively: false) else { return SCNNode() }
        let scaleFactor = 0.005
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x = -.pi / 2
        return node
    }()
    
    lazy var bookNode: SCNNode = {
        guard let scene = SCNScene(named: "book.scn"),
            let node = scene.rootNode.childNode(withName: "book", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.1
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        return node
    }()
    
    lazy var trueNode: SCNNode = {
        guard let scene = SCNScene(named: "true.scn"),
            let node = scene.rootNode.childNode(withName: "p03d", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.1
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        return node
    }()
    
    lazy var mountainNode: SCNNode = {//3d立體圖片
        guard let scene = SCNScene(named: "mountain.scn"),
            let node = scene.rootNode.childNode(withName: "mountain", recursively: false) else { return SCNNode() }
        let scaleFactor  = 0.25
        node.scale = SCNVector3(scaleFactor, scaleFactor, scaleFactor)
        node.eulerAngles.x += -.pi / 2
        return node
    }()
    
    
    func configureLighting() {
        sceneView.autoenablesDefaultLighting = true
        sceneView.automaticallyUpdatesLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        resetTrackingConfiguration()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    @IBAction func resetButtonDidTouch(_ sender: UIBarButtonItem) {
        resetTrackingConfiguration()
    }
    
    func resetTrackingConfiguration() {
        guard let referenceImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: nil) else { return }
        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        let options: ARSession.RunOptions = [.resetTracking, .removeExistingAnchors]
        sceneView.session.run(configuration, options: options)
        label.text = "Move camera around to detect images"
    }
    func waternumUpdate() {
        
        let uidStr = String(uid)
        let waternumberStr = String(waternumber + 1)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "update collection set water = '" + waternumberStr + "' where uid = '" + uidStr + "'"
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
    func fertilizernumUpdate() {
        
        let uidStr = String(uid)
        let fertilizernumberStr = String(fertilizernumber + 1)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "update collection set fertilizer = '" + fertilizernumberStr + "' where uid = '" + uidStr + "'"
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
                print(jsonString)
                if(jsonString.contains("uid")){
                    let fertilizeri = jsonString.range(of: "fertilizer\" : \"")
                    let fertilizerj = jsonString.range(of: "\",")
                    let fertilizerStr = String(jsonString[(fertilizeri?.upperBound)!..<(fertilizerj?.lowerBound)!])
                    var newi = jsonString.range(of: "uid\" : \"")
                    var newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let uidi = newstr.range(of: "uid\" : \"")
                    let uidj = newstr.range(of: "\",")
                    let uidStr = String(newstr[(uidi?.upperBound)!..<(uidj?.lowerBound)!])
                    newi = jsonString.range(of: "water\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let wateri = newstr.range(of: "water\" : \"")
                    let waterj = newstr.range(of: "\",")
                    let waterStr = String(newstr[(wateri?.upperBound)!..<(waterj?.lowerBound)!])
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
}
extension viewcontrollerfind2: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.main.async {
            
            guard let imageAnchor = anchor as? ARImageAnchor,
            let imageName = imageAnchor.referenceImage.name else { return }
            
            let overlayNode = self.getNode(withImageName: imageName)
            overlayNode.opacity = 0
            overlayNode.position.y = 0.2
            overlayNode.runAction(self.fadeAndSpinAction)
            node.addChildNode(overlayNode)
            if imageName == self.picture {
                self.label.text = "點擊任意處繼續..."
                self.wallBtn.isHidden = false
                //self.getWord.text = String(format: "+1")
                if imageName == "p03d"{
                    self.titleLabel.text = String(format:"宗倬章先生")
                    self.introductionLabel.text = String(format:"山東省平度縣蘭底鎮人，於民國三十六年（公元一九四七年）由中國大陸抵台。宗倬章先生深感當時農村生活艱苦，求學上進追求知識難得，矢志鼓勵清寒學子讀書，為自己和社會創造光輝未來。")
                }else if imageName == "p13d"{
                    self.titleLabel.text = String(format:"以愛為名-聖堂以孝存記父母恩")
                    self.introductionLabel.text = String(format:"章董事長虔誠盼望天主能醫治每位進入輔醫卻心靈破碎的人，並能親自包紮了他的傷痕，更期望藉著如此溫馨的揭牌感恩彌撒，與父母述說他的感恩之情。在聖堂旁刻有父母親畫像的銘版上，存記著章董事長對於父母恩永不忘的銘謝，這份堅毅的孝心，將能永遠留存在每一位進入聖堂的人，給予他們溫暖，慰藉每一位因病受苦來到輔醫的人們。")
                }else if imageName == "p33d"{
                    self.titleLabel.text = String(format:"聖堂-沐恩堂")
                    self.introductionLabel.text = String(format:"以安慰與醫治為主題的聖堂，入口擷取聖詠一四七「祂醫治了心靈破碎的人，也親自包紮了他的傷痕」沐恩堂依照天主教堂的形式，規劃讓民眾進行祈禱、祈福，也因應醫院的需求，沐恩堂特別開放２４小時，讓病患及其家屬能夠隨時到此禱告、休息，得到心靈上的平靜以及天主的祝福。")
                }else if imageName == "p43d"{
                    self.titleLabel.text = String(format:"輔大醫院")
                    self.introductionLabel.text = String(format:"歡迎蒞臨輔大醫院，此為華人社會唯一的天主教大學醫院，以病人的需求來建構，發揮天主教敬天愛人，視病猶親的精神；充滿人文藝術的色彩，又有現化科技的智慧，是臺灣優秀醫療人員所嚮往的醫院。")
                }else if imageName == "p53d"{
                    self.titleLabel.text = String(format:"生命之樹")
                    self.introductionLabel.text = String(format:"天使又指示給我一條生命之水的河流，光亮有如水晶，從天主和羔羊的寶座那裏湧出，流在城的街道中央；沿河兩岸，有生命樹，一年結十二次果子，每月結果一次，樹的葉子可治好萬民 。若望默示錄 22:1-2")
                }else if imageName == "p63d"{
                    self.titleLabel.text = String(format:"逃生平面圖")
                    self.introductionLabel.text = String(format:"本院一樓共有六處逃生出口，危及發生時，請依循逃生路線。一樓兩處提供廁所使用，志工服務處附有消防設備。")
                    
                }else if imageName == "p73d"{
                    self.titleLabel.text = String(format:"財團法人宗倬章先生教育基金會")
                    self.introductionLabel.text = String(format:"宗倬章先生因少時農村生活艱苦，求學上進追求知識難得，勵志鼓勵清寒學子讀書，為自己和社會創造光輝未來。六和關係企業創辦人，紀念並實現去是父親理念，設置清寒獎學金，創立基金會每年補助公私立學校、殘障特殊學校說生講學金與設備，鼓勵學子讀書，支持教育。")
                }
                self.doctor.isHidden = false;
                self.wallBtn.isHidden = false;
                self.introduction.isHidden = false;
                self.titleLabel.isHidden = false;
                self.introductionLabel.isHidden = false;
            
            }
        }
    }
    
    @available(iOS 11.3, *)
    func getPlaneNode(withReferenceImage image: ARReferenceImage) -> SCNNode {
        let plane = SCNPlane(width: image.physicalSize.width,
                             height: image.physicalSize.height)
        let node = SCNNode(geometry: plane)
        return node
    }
    
    func getNode(withImageName name: String) -> SCNNode {
        var node = SCNNode()
        switch name {
        case "Book":
            node = bookNode
        case "Snow Mountain":
            node = mountainNode
        case "Trees In the Dark":
            node = treeNode
        case "true":
            node = trueNode
        default:
            break
        }
        return node
    }
    
    
}
