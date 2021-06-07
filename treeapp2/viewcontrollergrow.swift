//
//  viewcontrollergrow.swift
//  treeapp2
//
//  Created by Apple on 2019/3/26.
//  Copyright © 2019 Apple. All rights reserved.
//
import UIKit

var timimg = 900 //剩餘時間
var waterTime = 210
var flag = 0 //肥料順序先表示0
var treeType = -1
var beplanted = 0//是否被種植
var date = Date()//種子種下去時間
var timer = Timer()
var stime = timimg

class viecontrollergrow: UIViewController {
    
    
    @IBAction func beforeBT(_ sender: Any) {
    }
    @IBOutlet weak var lightBtn: UIButton!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var tips: UIImageView!
    @IBOutlet weak var table: UIImageView!
    @IBOutlet weak var seedBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stage1Label: UILabel!
    @IBOutlet weak var stage2Label: UILabel!
    @IBOutlet weak var seedLabel: UILabel!
    @IBOutlet weak var harvestBtn: UIButton!
    @IBOutlet weak var imgTips: UIImageView!
    @IBOutlet weak var labTips: UILabel!
    @IBOutlet weak var btnTips: UIButton!
    @IBOutlet weak var treenameLabel: UILabel!
    @IBOutlet var views: UIView!
    @IBOutlet var viewnot: UIView!
    @IBOutlet var viewnot2: UIView!
    @IBOutlet var viewnot3: UIView!
    @IBOutlet var viewnot4: UIView!
    @IBOutlet var stage_picture: UIImageView!
    @IBOutlet var finger_picture: UIImageView!
    @IBOutlet var text_picture: UIImageView!
    @IBOutlet var speak_picture: UIImageView!
    @IBOutlet var arrow2: UIImageView!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var skipButton: UIButton!
    let URL_EXECSQLUPDATE = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlUpdate.php"
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    
    let seed1 = UIImageView(image:UIImage(named:"seed-1"))
    let seed2 = UIImageView(image:UIImage(named:"seed-2"))
    let seed3 = UIImageView(image:UIImage(named:"seed-3"))
    let seed4 = UIImageView(image:UIImage(named:"seed-4"))
    let seed5 = UIImageView(image:UIImage(named:"seed-5"))
    let fertilizer = UIImageView(image:UIImage(named:"fertilizer"))
    let water = UIImageView(image:UIImage(named:"water2"))
    
    let tree1_0 =  UIImageView(image:UIImage(named:"KindTree1"))
    let tree1_1 =  UIImageView(image:UIImage(named:"KindTree2"))
    let tree1_2 =  UIImageView(image:UIImage(named:"KindTree3"))
    let tree2_0 =  UIImageView(image:UIImage(named:"ChildTree1"))
    let tree2_1 =  UIImageView(image:UIImage(named:"ChildTree2"))
    let tree2_2 =  UIImageView(image:UIImage(named:"ChildTree3"))
    let tree3_0 =  UIImageView(image:UIImage(named:"BlindTree1"))
    let tree3_1 =  UIImageView(image:UIImage(named:"BlindTree2"))
    let tree3_2 =  UIImageView(image:UIImage(named:"BlindTree3"))
    let tree4_0 =  UIImageView(image:UIImage(named:"WaterTree1"))
    let tree4_1 =  UIImageView(image:UIImage(named:"WaterTree2"))
    let tree4_2 =  UIImageView(image:UIImage(named:"WaterTree3"))
    let tree5_0 =  UIImageView(image:UIImage(named:"MulberryTree1"))
    let tree5_1 =  UIImageView(image:UIImage(named:"MulberryTree2"))
    let tree5_2 =  UIImageView(image:UIImage(named:"MulberryTree3"))
    
    var fertilizernumber = 0;
    var completed = 0
    var waternumber = 0;
    var seednumber = 0;
    var seedarray = [Int]()
    var seedimage = [UIImageView]()
    var stageProperty = [UIImageView]()
    var treeimage = [UIImageView]()//*存放樹目前種植狀況圖片顯示
    var stagePropertyArray = [Int]() //數量
    var steps = 0
    var hasfinpic = 0
    var hastexpic = 0
    var tarrow = 0
   
    
    var modeingrow = 999
    var x = 45
    var y = 150
    var seedheight = 100
    var seedwidth = 90
    var teafiltime = 0
    var teacpicturestep = 0
    var picstep = 999
    var treeimgis = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("mode")
        print(modes)
        
        
        harvestBtn.isHidden = true
        table.isHidden = true
        imgTips.isHidden = false
        labTips.isHidden = false
        btnTips.isHidden = false
        okBtn.isHidden = true
        message.isHidden = true
        tips.isHidden = true
        
        seedLabel.text = String(format: "x %d", seednumber)
        
        seedimage.append(seed1)
        seedimage.append(seed2)
        seedimage.append(seed3)
        seedimage.append(seed4)
        seedimage.append(seed5)
        
        stage1Label.text = String(format: "x %d", fertilizernumber)
        stage2Label.text = String(format: "x %d", waternumber)
        
        stagePropertyArray.append(fertilizernumber)
        stagePropertyArray.append(waternumber)
        stageProperty.append(fertilizer)
        stageProperty.append(water)
        
        treeimage.append(tree1_0)//*
        treeimage.append(tree1_1)
        treeimage.append(tree1_2)
        treeimage.append(tree2_0)
        treeimage.append(tree2_1)
        treeimage.append(tree2_2)
        treeimage.append(tree3_0)
        treeimage.append(tree3_1)
        treeimage.append(tree3_2)
        treeimage.append(tree4_0)
        treeimage.append(tree4_1)
        treeimage.append(tree4_2)
        treeimage.append(tree5_0)
        treeimage.append(tree5_1)
        treeimage.append(tree5_2)
        for i in 0...14 {
            treeimage[i].isHidden = true
            treeimgis += 1
        }
        
        stagePropertyAppend()
//        let Queue = DispatchQueue(label : "Queue")
//        Queue.sync{
        //Action
        print(uid)
        if(uid != -1){
            getTool()
            plantSelect()
            Thread.sleep(forTimeInterval:0.8)
            print("treeType : " + String(treeType))
            if(treeType != -1){
                dateBetween()
                print(stime)
                showTreeName()
            }
            else{
                timimg = 900
                beplanted = 0//是否被種植
                date = Date()//種子種下去時間
                timer = Timer()
                stime = timimg
            }
        }
//        }
        if(completed == 3 ){
            Thread.sleep(forTimeInterval:1.0)
            modeingrow = 0
            nottouch()
            teachstep()
        }
        if(completed == 9 ){
            Thread.sleep(forTimeInterval:1.0)
            modeingrow = 1
            nottouch()
            teachstep2()
        }
       /* if(completed != 999){
            completed += 1;
        }*/
        if seednumber == 0{
            seedBtn.isEnabled = false
        }
        if treeType != -1{
            seedBtn.isEnabled = false
        }
       
    }

    
    @IBAction func teachnext(){
           steps += 1;
        if(modeingrow == 0){
            teachstep();}
        else{
            teachstep2();
        }
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
        let teacimgs=[["timg30","timg31","timg12","timg13","timg32","timg33"],["timg90","timg91","timg91","timg92","timg92","timg92-1","timg92-1","timg93","timg93","timg94","timg94"]]
        let x = UIImage(named: teacimgs[modeingrow][steps] )
        text_picture = UIImageView(image: x,highlightedImage:x)
        text_picture.frame = CGRect.init(x: 180, y: 300, width: 470, height: 120)
        self.view.addSubview(text_picture)
        hastexpic = 1
    }
    func conbtn(btnen:Bool){

    }
    func resetteac(){
        self.text_picture.removeFromSuperview()
        self.views.removeFromSuperview()
        self.speak_picture.removeFromSuperview()
        self.playButton.removeFromSuperview()
        self.skipButton.removeFromSuperview()
        teasetthing()
        teachidden(thidden:true)
        
    }
    func teacarr() {    //teach content text
        if(tarrow >= 1){
            self.arrow2.removeFromSuperview()
            //self.arrow2.removeFromSuperview()
        }
        let arrx = [[300,600,550],[600]];
        let arry = [[85,85,80],[300]];
        arrow2 = UIImageView(image: UIImage(named:"arrow2" ),highlightedImage:UIImage(named:"arrow2" ))
        arrow2.transform = CGAffineTransform(rotationAngle: CGFloat(90));
        arrow2.frame = CGRect.init(x:arrx[modeingrow][tarrow], y: arry[modeingrow][tarrow], width: 100, height: 50)
        self.view.addSubview(arrow2)
        tarrow += 1
    }
    func teacfin() {    //teach content text
        if(hasfinpic == 1){
            self.finger_picture.removeFromSuperview()
            hasfinpic = 0
        }
        let fingx = [[100,100],[280,390,280,650]];
        let fingy = [[950,250,700],[950,950,950,800]];
        let finger = UIImage(named:"finger" )
        finger_picture = UIImageView(image: finger,highlightedImage:finger)
        finger_picture.frame = CGRect.init(x:fingx[modeingrow][teacpicturestep], y: fingy[modeingrow][teacpicturestep], width: 80, height: 80)
        self.view.addSubview(finger_picture)
        hasfinpic = 1
        teacpicturestep += 1
    }
    func nottouch(){
        var frame = CGRect(x: 0, y: 0, width: 130, height: 100)
        viewnot = UIView(frame: frame)
        viewnot.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(viewnot)
        
        frame = CGRect(x: 170, y:850, width: 280, height: 180)
        viewnot2 = UIView(frame: frame)
        viewnot2.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        self.view.addSubview(viewnot2)
        
        frame = CGRect(x: 170, y:850, width: 140, height: 180)
        viewnot3 = UIView(frame: frame)
        viewnot3.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        //self.view.addSubview(viewnot3)
        
        frame = CGRect(x: 300, y:850, width: 140, height: 180)
        viewnot4 = UIView(frame: frame)
        viewnot4.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        //self.view.addSubview(viewnot4)
    }
    func releassetouch(){
        self.viewnot.removeFromSuperview()
        self.viewnot2.removeFromSuperview()
    }
    func teachstep(){
        
        if(modeingrow == 1){
            teachstep2()
            
        }
        else{
            if steps == 0{
                if(seednumber < 1){
                    teachsdataerror()
                }
                else{
                //conbtn(btnen: false)
                teasetthing()
                    teacimg()
                    
                }
            }
            else if steps == 1{
                //teacarr()
                teacimg()
                
            }
            else if steps == 2{
                teacfin()
                teachidden(thidden : true)
                //conbtn(btnen: true)
            }
            else if steps == 3{
                teacfin()
                //conbtn(btnen: true)
            }
            else if steps == 4{
                self.text_picture.removeFromSuperview()
                //
                hasfinpic = 0
                //conbtn(btnen: true)
                teachidden(thidden:false)
                teacimg()
            }
            else if steps == 5{ //391
                //teachidden(thidden : true)
                teacimg()
                
                //conbtn(btnen: false)
            }
            else if steps == 6{
                teachidden(thidden : true)
                self.viewnot.removeFromSuperview()
                self.finger_picture.removeFromSuperview()
                let finger = UIImage(named:"finger" )
                finger_picture = UIImageView(image: finger,highlightedImage:finger)
                finger_picture.frame = CGRect.init(x:100, y: 80, width: 80, height: 80)
                self.view.addSubview(finger_picture)
                self.text_picture.removeFromSuperview()
                hastexpic = 0
                 completed += 1;
                //releassetouch()
                teachidden(thidden : true)
            }
        }
        

    }
    func teachstep2(){
        
        
        if steps == 0{
            //conbtn(btnen: false)
        if(waternumber < 1 || fertilizernumber < 2){
            teachsdataerror()
            
            }
        else{
            teasetthing()
            teacimg()
            
            }
        }
        else if steps == 1{
            //teacarr()
            teacimg()
        }
        else if steps == 2{
            teacfin()
            self.viewnot2.removeFromSuperview()
            self.view.addSubview(viewnot4)
            teachidden(thidden : true)
        }
        else if steps == 3{
            self.finger_picture.removeFromSuperview()
            hasfinpic = 0
            teachidden(thidden:false)
            teacimg()
        }
        else if steps == 4{
            self.view.addSubview(viewnot3)
            self.view.bringSubviewToFront(viewnot3)
            self.viewnot4.removeFromSuperview()
            teacfin()
            teachidden(thidden:true)
        }
        
        else if steps == 5{
            if stime == 0{
                steps += 2
                self.finger_picture.removeFromSuperview()
                self.view.addSubview(viewnot2)
                self.viewnot3.removeFromSuperview()
                hasfinpic = 0
                teacpicturestep += 1
                teachidden(thidden:false)
                teacimg()
            }
            else{
                self.finger_picture.removeFromSuperview()
                hasfinpic = 0
                teachidden(thidden:false)
                teacimg()
            }
        }
        else if steps == 6{
            self.view.addSubview(viewnot4)
            self.viewnot3.removeFromSuperview()
            teacfin()
            teachidden(thidden:true)
        }
        else if steps == 7{
            self.view.addSubview(viewnot2)
            self.viewnot4.removeFromSuperview()
            self.finger_picture.removeFromSuperview()
            hasfinpic = 0
            teachidden(thidden:false)
            teacimg()
        }
        
        else if steps == 8{
            views.isHidden = false
            arrow2 = UIImageView(image: UIImage(named:"arrow2" ),highlightedImage:UIImage(named:"arrow2" ))
            arrow2.transform = CGAffineTransform(rotationAngle: CGFloat(-90));
            arrow2.frame = CGRect.init(x:660, y: 190, width: 100, height: 50)
            self.view.addSubview(arrow2)
            teachidden(thidden:true)
            if(stime == 0){
                steps+=1
                teachstep2()
            }
        }
        else if steps == 9{
            views.isHidden = true
            arrow2.isHidden = true
            teacfin()
        }
        else if steps == 10{
            self.finger_picture.removeFromSuperview()
            hasfinpic = 0
            teachidden(thidden:false)
            teacimg()
            self.view.bringSubviewToFront(speak_picture)
            self.view.bringSubviewToFront(text_picture)
            self.view.bringSubviewToFront(playButton)
        }
        else if steps == 11{
            teachidden(thidden : true)
            self.viewnot.removeFromSuperview()
            //self.finger_picture.removeFromSuperview()
            let finger = UIImage(named:"finger" )
            finger_picture = UIImageView(image: finger,highlightedImage:finger)
            finger_picture.frame = CGRect.init(x:100, y: 80, width: 80, height: 80)
            self.view.addSubview(finger_picture)
            self.text_picture.removeFromSuperview()
            hastexpic = 0
            completed += 1;
            releassetouch()
            teachidden(thidden : true)
        }

    }
    func teachsdataerror(){
        
        self.viewnot.removeFromSuperview()
        //self.finger_picture.removeFromSuperview()
        let finger = UIImage(named:"finger" )
        finger_picture = UIImageView(image: finger,highlightedImage:finger)
        finger_picture.frame = CGRect.init(x:100, y: 80, width: 80, height: 80)
        steps = 999
    }
    @IBAction func teacend(){   //skipbtn event
        completed = 999;
        self.views.isHidden = true
        self.playButton.isHidden = true
        self.skipButton.isHidden = true
        self.text_picture.isHidden = true
        self.speak_picture.isHidden = true
        modes = 1
        print(seednumber)
        Thread.sleep(forTimeInterval:0.8)
        print(seednumber)
        releassetouch()
        //enbtn()
    }
    
    @IBAction func teachidden(thidden:Bool){   //skipbtn event
        self.views.isHidden = thidden
        self.text_picture.isHidden = thidden
        self.speak_picture.isHidden = thidden
        self.playButton.isHidden = thidden
        self.skipButton.isHidden = thidden
        self.finger_picture.isHidden = !thidden
    }
    @IBAction func tipsShow(_ sender: Any) {
        tips.isHidden = false;
        okBtn.isHidden = false;
        message.isHidden = false;
        self.view.bringSubviewToFront(tips)
        self.view.bringSubviewToFront(message)
        self.view.bringSubviewToFront(okBtn)
    }

    @IBAction func showbefore() {
        if let controller = storyboard?.instantiateViewController(withIdentifier: "gamepage")as? viewcontroller_game {
            controller.fertilizernumber = self.fertilizernumber
            controller.waternumber = self.waternumber
            controller.seedarray = self.seedarray
            controller.completed = self.completed
            controller.steps = self.steps
            present(controller, animated: true, completion: nil)
            timer.invalidate()
        }
    }
   
    @IBAction func clickseed(_ sender: Any) {
        table.isHidden = false
        seedappend()
        beplanted = 1
        print(uid)
        lightBtn.isEnabled = false
        self.view.sendSubviewToBack(lightBtn)

    }
    @objc func clickWater() {
        
        if  beplanted == 0{
            showMessage()
        }else if(stime == 0){
            showFaildMessage()
        }else{
            if(waternumber > 0){
                waternumUpdate()
                waternumber -= 1
                stime -= waterTime
                plantSelect()
                Thread.sleep(forTimeInterval:0.8)
                date = date - TimeInterval(waterTime)
                //dateBetween()
                plantUpdate(date: date)
                if flag == 0{
                    stage2Label.text = String(format: "x %d", waternumber)
                }else{
                    stage1Label.text = String(format: "x %d", waternumber)
                }
                if waternumber == 0{
                    flag = 0
                    stageProperty[0].isHidden = true
                    stageProperty[1].isHidden = true
                    stage1Label.isHidden = true
                    stage2Label.isHidden = true
                    stagePropertyAppend()
                }
                if(modeingrow == 1 && steps == 4){
                    steps += 1
                    teachstep2()
                    self.view.bringSubviewToFront(viewnot3)
                }
           }
        }
            
    }
    @objc func clickFertilizer() {
        
        if beplanted == 0{
            showMessage()
        }else if(stime == 0){
            showFaildMessage()
        }else{
            if(fertilizernumber > 0){
                fertilizernumUpdate()
                fertilizernumber -= 1
                stime = stime - timimg/3
                plantSelect()
                Thread.sleep(forTimeInterval:0.8)
                date = date - TimeInterval(timimg/3)
                plantUpdate(date: date)
                if flag == 1{
                    stage2Label.text = String(format: "x %d", fertilizernumber)
                }else{
                    stage1Label.text = String(format: "x %d", fertilizernumber)
                }
                if fertilizernumber == 0{
                    flag = 1
                    stageProperty[0].isHidden = true
                    stageProperty[1].isHidden = true
                    stage1Label.isHidden = true
                    stage2Label.isHidden = true
                    stagePropertyAppend()
                }
                if(modeingrow == 1 && steps == 2){
                    steps += 1
                    teachstep2()
                }
                if(modeingrow == 1 && steps == 6){
                    steps += 1
                    teachstep2()
                }
            }
        }
    }
    
    @objc func UpdateTimer() {
        stime = stime - 1
        
        if stime <= 0{
            stime = 0
            timer.invalidate()
            harvestBtn.isHidden = false
            harvestBtn.isEnabled = true
           
            if harvestBtn.isEnabled == true{
                treeimage[3 * treeType + 2].frame = CGRect(x:260, y:320, width:260, height:300)//*
                self.view.addSubview(treeimage[3 * treeType + 2])
                treeimage[3 * treeType + 2].isHidden = false
                treeimage[3 * treeType + 0].isHidden = true
                treeimage[3 * treeType + 1].isHidden = true
                if(modeingrow == 1 && steps == 8){
                    steps += 1
                    teachstep2()
                }
                if(modeingrow != 999){
                    self.view.bringSubviewToFront(speak_picture)
                    self.view.bringSubviewToFront(text_picture)
                    self.view.bringSubviewToFront(playButton)
                }
            }
        
        }
        
        if stime >= timimg-(timimg/3) {
            //tree1_0.isHidden = true
            //tree1_1.isHidden = true
            //tree1_2.isHidden = true
            
        }else if stime <= timimg-timimg/3 && stime > timimg-timimg/3*2{
            treeimage[3 * treeType].frame = CGRect(x:260, y:320, width:260, height:300)//*
            self.view.addSubview(treeimage[3 * treeType])
            treeimage[3 * treeType].isHidden = false
            treeimage[3 * treeType + 1].isHidden = true
            treeimage[3 * treeType + 2].isHidden = true
            if(modeingrow != 999){
                self.view.bringSubviewToFront(speak_picture)
                self.view.bringSubviewToFront(text_picture)
                self.view.bringSubviewToFront(playButton)
            }
            //tree1_0.isHidden = false
            //tree1_1.isHidden = true
            //tree1_2.isHidden = true
        }else if stime <= timimg-timimg/3*2 && stime > 0{
            treeimage[3 * treeType + 1].frame = CGRect(x:260, y:320, width:260, height:300)//*
            self.view.addSubview(treeimage[3 * treeType + 1])
            treeimage[3 * treeType + 1].isHidden = false
            treeimage[3 * treeType + 0].isHidden = true
            treeimage[3 * treeType + 2].isHidden = true
            if(modeingrow != 999){
                self.view.bringSubviewToFront(speak_picture)
                self.view.bringSubviewToFront(text_picture)
                self.view.bringSubviewToFront(playButton)
            }
            //tree1_1.isHidden = false
            //tree1_0.isHidden = true
            //tree1_2.isHidden = true
        }
        
        self.view.bringSubviewToFront(imgTips)
        self.view.bringSubviewToFront(tips)
        self.view.bringSubviewToFront(message)
        self.view.bringSubviewToFront(okBtn)
        timeLabel.text = String(format: "%02d:%02d", stime/60,stime%60)
        
        
    }
    
    @IBAction func harvest(_ sender: Any) {
        harvestBtn.isEnabled = false
        treeimage[3 * treeType + 2].isHidden = true
        //tree1_2.isHidden = true
        harvestBtn.isHidden = true
        if seednumber > 0{
            seedBtn.isEnabled = true
        }
        print(treeType)
        treeInsert(tree:treeType) //樹園增加一棵樹
        plantDelete()
        treeType = -1
        beplanted = 0
        showTreeName()
        
        print(steps)
        print("6763987019842039-28978")
        if(modeingrow == 1 && steps == 9){
            steps += 1
            teachstep2()
        }

    }
    func stagePropertyAppend(){
        var cnt = 0 //stageProperty 數量
        stagePropertyArray[0] = fertilizernumber
        stagePropertyArray[1] = waternumber
       
        
        for i in 0...1 {
            
            if stagePropertyArray[i] != 0{
                stageProperty[i].frame = CGRect(x:190+cnt*140, y:890, width:90, height:90)
                self.view.addSubview(stageProperty[i])//種子添加到原本的view上
                stageProperty[i].isHidden = false
                if cnt == 0 && i == 1{
                    flag = 1
                }
                if flag == 0{
                    stage1Label.text = String(format: "x %d", fertilizernumber)
                    stage2Label.text = String(format: "x %d", waternumber)
                }else{
                    stage1Label.text = String(format: "x %d", waternumber)
                    stage2Label.text = String(format: "x %d", fertilizernumber)
                }
                if cnt == 0{
                    stage1Label.isHidden = false
                }else{
                    stage2Label.isHidden = false
                }
                
                cnt += 1
            }
        }
        
        let watertap = UITapGestureRecognizer(target: self, action: #selector(clickWater))
        water.isUserInteractionEnabled = true
        water.addGestureRecognizer(watertap)
        
        let fertilizertap = UITapGestureRecognizer(target: self, action: #selector(clickFertilizer))
        fertilizer.isUserInteractionEnabled = true
        fertilizer.addGestureRecognizer(fertilizertap)
        
    }
    func seedappend(){

        var cnt = 0 //tree count
    
        for i in 0...4 {
           
            if seedarray[i] == 1{
                seedimage[i].frame = CGRect(x:x, y:y+cnt*145, width:seedwidth, height:seedheight)//種子型態
                self.view.addSubview(seedimage[i])//種子添加到原本的view上
                seedimage[i].isHidden = false
                
                cnt += 1
            }
        }

        let seedtap1 = UITapGestureRecognizer(target: self, action: #selector(seed1click))//播種下去
        seed1.isUserInteractionEnabled = true
        seed1.addGestureRecognizer(seedtap1)
        
        let seedtap2 = UITapGestureRecognizer(target: self, action: #selector(seed2click))
        seed2.isUserInteractionEnabled = true
        seed2.addGestureRecognizer(seedtap2)
        
        let seedtap3 = UITapGestureRecognizer(target: self, action: #selector(seed3click))
        seed3.isUserInteractionEnabled = true
        seed3.addGestureRecognizer(seedtap3)
        
        let seedtap4 = UITapGestureRecognizer(target: self, action: #selector(seed4click))
        seed4.isUserInteractionEnabled = true
        seed4.addGestureRecognizer(seedtap4)
        
        let seedtap5 = UITapGestureRecognizer(target: self, action: #selector(seed5click))
        seed5.isUserInteractionEnabled = true
        seed5.addGestureRecognizer(seedtap5)
        if(steps == 2){
            steps += 1
            teachstep()
        }
        
    }
    
    @objc func seed1click() {
        stime = timimg
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        seedarray[0] = 0
        treeType = 0
        date = Date()
        lightBtn.isEnabled = true
        plantInsert(seed: treeType, date: date)
        Thread.sleep(forTimeInterval:0.8)
        seedUpdate()
        Thread.sleep(forTimeInterval:0.8)
        update()
        
    }
    @objc func seed2click() {
        stime = timimg
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        seedarray[1] = 0
        treeType = 1
        date = Date()
        lightBtn.isEnabled = true
        plantInsert(seed: treeType, date: date)
        Thread.sleep(forTimeInterval:0.8)
        seedUpdate()
        Thread.sleep(forTimeInterval:0.8)
        
        update()
        
    }
    
    @objc func seed3click() {
        stime = timimg
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        seedarray[2] = 0
        treeType = 2
        date = Date()
        lightBtn.isEnabled = true
        plantInsert(seed: treeType, date: date)
        Thread.sleep(forTimeInterval:0.8)
        seedUpdate()
        Thread.sleep(forTimeInterval:0.8)
        update()
        
    }
    @objc func seed4click() {
        stime = timimg
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        seedarray[3] = 0
        treeType = 3
        date = Date()
        lightBtn.isEnabled = true
        plantInsert(seed: treeType, date: date)
        Thread.sleep(forTimeInterval:0.8)
        seedUpdate()
        update()
        
    }
    
    @objc func seed5click() {
        stime = timimg
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        seedarray[4] = 0
        treeType = 4
        date = Date()
        lightBtn.isEnabled = true
        plantInsert(seed: treeType, date: date)
        Thread.sleep(forTimeInterval:0.8)
        seedUpdate()
        Thread.sleep(forTimeInterval:0.8)
        update()
        
    }
    func update(){
        self.view.bringSubviewToFront(lightBtn)
        table.isHidden = true
        seedBtn.isEnabled = false
        seednumber -= 1
        for i in 0...4 {
            seedimage[i].isHidden = true
        }
        showTreeName()
        seedLabel.text = String(format: "x %d", seednumber)
        if seednumber == 0{
            seedBtn.isEnabled = false
        }
        if(steps == 3){
            steps += 1
            teachstep()
            print(steps)
        }
    }

    func showMessage() {
        let alertController = UIAlertController(title: "提醒", message: "請先種下種子", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
    }
    func showFaildMessage(){
        let alertController = UIAlertController(title: "提醒", message: "已經成樹道具失效，您可以選擇點擊農夫採收樹", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func closeTips(_ sender: UIButton) {
        //seedBtn.isEnabled = true
        imgTips.isHidden = true
        labTips.isHidden = true
        btnTips.isHidden = true
    }
    
    func showTreeName(){
        if(treeType == 0){
            treenameLabel.text = String(format: "仁慈的撒馬利亞人")
        }else if(treeType == 1){
            treenameLabel.text = String(format: "耶穌祝福兒童")
        }else if(treeType == 2){
            treenameLabel.text = String(format: "耶穌治癒瞎子")
        }else if(treeType == 3){
            treenameLabel.text = String(format: "生命的活水")
        }else if(treeType == 4){
            treenameLabel.text = String(format: "耶穌與匝凱")
        }else{
            treenameLabel.text = String(format: "目前無種植")
        }
    }
    
    func waternumUpdate() {
        
        let uidStr = String(uid)
        let waternumberStr = String(waternumber - 1)
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
        let fertilizernumberStr = String(fertilizernumber - 1)
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
    
    
    func getTool() {
        
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
    func plantSelect()  {
        
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
        let value = "select * from plant where uid = '" + uidStr + "'"
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
                if(jsonString.contains("tid")){
                    let tidi = jsonString.range(of: "tid\" : \"")
                    let tidj = jsonString.range(of: "\",")
                    let tidStr = String(jsonString[(tidi?.upperBound)!..<(tidj?.lowerBound)!])
                    var newi = jsonString.range(of: "uid\" : \"")
                    var newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let uidi = newstr.range(of: "uid\" : \"")
                    let uidj = newstr.range(of: "\",")
                    let uidStr = String(newstr[(uidi?.upperBound)!..<(uidj?.lowerBound)!])
                    newi = jsonString.range(of: "state\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let statei = newstr.range(of: "state\" : \"")
                    let statej = newstr.range(of: "\",")
                    let stateStr = String(newstr[(statei?.upperBound)!..<(statej?.lowerBound)!])
                    newi = jsonString.range(of: "plantedseed\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let plantedseedi = newstr.range(of: "plantedseed\" : \"")
                    let plantedseedj = newstr.range(of: "\"\n")
                    let plantedseedStr = String(newstr[(plantedseedi?.upperBound)!..<(plantedseedj?.lowerBound)!])
                    
                    print("======")
                    print("uid:" + uidStr)
                    print("tid:" + tidStr)
                    print("stste:" + stateStr)
                    print("plantedseed:" + plantedseedStr)
                    treeType = Int(plantedseedStr)!
                    date = self.stringConvertDate(dateStr:stateStr)
                    
                    
                    
                }
                else{
                    treeType = -1

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
    func plantInsert(seed: Int, date: Date) {
        
        let uidStr = String(uid)
        let seedStr = String(seed)
        let dateStr = dateConvertString(date: date)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "insert into plant (uid, state, plantedseed) values ('" + uidStr + "','" + dateStr + "','" + seedStr + "')"
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
    func plantUpdate(date: Date) {
        
        let uidStr = String(uid)
        
        let dateStr = dateConvertString(date: date)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value =  "update plant set state = '" + dateStr + "' where uid = '" + uidStr +  "'"
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
    func plantDelete() {
        
        let uidStr = String(uid)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "delete from plant where uid = '" + uidStr + "'"
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
    
    func treeInsert(tree: Int) {
        
        let uidStr = String(uid)
        let treeStr = String(tree)
      
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "insert into tree (uid, tree) values ('" + uidStr + "','" + treeStr + "')"
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
    func seedUpdate() {
       
        let uidStr = String(uid)
        let treeTypeStr = String(treeType)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "update story set seed = '-1' where uid = '" + uidStr + "' and haveread = '" + treeTypeStr + "'"
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
    func dateConvertString(date:Date) -> String {
        let timeZone = NSTimeZone.local
        let formatter = DateFormatter()
        formatter.timeZone = timeZone
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = formatter.string(from: date)
        return date
        
    }
    
    func stringConvertDate(dateStr:String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateStr)
        return date!
    }
    
    func dateBetween(){
        let now = Date()
        print(date)
        print(now)
        var timeDiff = Calendar.current.dateComponents( [.year, .month, .day , .hour, .minute, .second], from: date, to: now )
        print( timeDiff.minute!, "分" )
        print( timeDiff.second!, "秒" )
        let betweentime = timeDiff.minute! * 60 + timeDiff.second!
        print("相差")
        print(betweentime)
        if(betweentime >= timimg){
            stime = 0
            UpdateTimer()
            //timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
            //update()
            
        }else{
            stime = timimg - betweentime
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
            //update()
            
        }
    }
    
}

