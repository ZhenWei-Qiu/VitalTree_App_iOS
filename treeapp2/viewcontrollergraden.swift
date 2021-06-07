//
//  viewcontrollergraden.swift
//  treeapp2
//
//  Created by １２３ on 2019/8/7.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit
import ARKit
class viewcontrollergraden: UIViewController {
    
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    var hastree = [0,0,0,0,0];
    @IBOutlet weak var a: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       if(uid != -1){
            treeSelect()
            Thread.sleep(forTimeInterval:0.8)
        }
        
        addPlane();
        addchapel();
        if(hastree[0] == 1){
            addSamaritan(); //seed1
        }
        if(hastree[1] == 1){
            addChild(); //seed2
        }
        if(hastree[2] == 1){
            addBlind(); //seed3
        }
        if(hastree[3] == 1){
            addWater(); //seed4
        }
        if(hastree[4] == 1){
            addYukai(); //seed5
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        let configuration = ARWorldTrackingConfiguration()
        a.session.run(configuration)
        
    }
        
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        a.session.pause()
        
    }
    func addPlane() {
        
        let plane = SCNPlane(width: 200,height : 150);
        
        let grid = UIImage(named: "grass")
        let material = SCNMaterial()
        material.diffuse.contents = grid
        plane.materials = [material]
        
        
        let planeNode = SCNNode()
        planeNode.geometry = plane
        planeNode.position = SCNVector3(0, -50, -150)
        planeNode.eulerAngles.x = -.pi / 2
        
        
        let scene = SCNScene()
        scene.rootNode.addChildNode(planeNode)
        a.scene = scene
        
    }
    func addchapel(x: Float = 30
        , y: Float = -20, z: Float = -50) {
        let queue = DispatchQueue(label: "-2.3.treeapp2")
        
        queue.async {
            guard let treeScene = SCNScene(named: "chapel.dae") else { return }
            let treeNode = SCNNode()
            let treeSceneChildNodes = treeScene.rootNode.childNodes
            for childNode in treeSceneChildNodes {
                treeNode.addChildNode(childNode)
            }
            treeNode.position = SCNVector3(x, y, z)
            treeNode.scale = SCNVector3(5, 5, 5)
            self.a.scene.rootNode.addChildNode(treeNode)
        }
    }
    
    func addBlind(x: Float = -20
        , y: Float = -20, z: Float = -50) {
        let queue = DispatchQueue(label: "-2.3.treeapp2")
        
        queue.async {
            guard let treeScene = SCNScene(named: "tree1.dae") else { return }
            let treeNode = SCNNode()
            let treeSceneChildNodes = treeScene.rootNode.childNodes
            for childNode in treeSceneChildNodes {
                treeNode.addChildNode(childNode)
            }
            treeNode.position = SCNVector3(x, y, z)
            treeNode.scale = SCNVector3(7, 7, 7)
            self.a.scene.rootNode.addChildNode(treeNode)
        }
    }
    
    func addSamaritan(x: Float = -15
        , y: Float = -20, z: Float = -75) {
        let queue = DispatchQueue(label: "-2.3.treeapp2")
        
        queue.async {
            guard let treeScene = SCNScene(named: "tree2.dae") else { return }
            
            let treeNode = SCNNode()
            let treeSceneChildNodes = treeScene.rootNode.childNodes
            for childNode in treeSceneChildNodes {
                treeNode.addChildNode(childNode)
            }
            treeNode.position = SCNVector3(x, y, z)
            treeNode.scale = SCNVector3(4, 4, 4)
            self.a.scene.rootNode.addChildNode(treeNode)
        }
    }
    func addChild(x: Float = 0
        , y: Float = -20, z: Float = -50) {
        let queue = DispatchQueue(label: "-2.3.treeapp2")
        
        queue.async {
            guard let treeScene = SCNScene(named: "treechild.dae") else { return }
            
            let treeNode = SCNNode()
            let treeSceneChildNodes = treeScene.rootNode.childNodes
            for childNode in treeSceneChildNodes {
                treeNode.addChildNode(childNode)
            }
            treeNode.position = SCNVector3(x, y, z)
            treeNode.scale = SCNVector3(0.7, 0.7, 0.7)
            self.a.scene.rootNode.addChildNode(treeNode)
        }
    }
    
    func addYukai(x: Float = 5
        , y: Float = -20 ,z: Float = -40) {
        let queue = DispatchQueue(label: "-2.3.treeapp2")
        
        queue.async {
            guard let treeScene = SCNScene(named: "treeYukai.dae") else { return }
            
            let treeNode = SCNNode()
            let treeSceneChildNodes = treeScene.rootNode.childNodes
            for childNode in treeSceneChildNodes {
                treeNode.addChildNode(childNode)
            }
            treeNode.position = SCNVector3(x, y, z)
            treeNode.scale = SCNVector3(0.8, 0.8, 0.8)
            self.a.scene.rootNode.addChildNode(treeNode)
        }
    }
    
    func addWater(x: Float = 20
        , y: Float = -20, z: Float = -70) {
        let queue = DispatchQueue(label: "-2.3.treeapp2")
        
        queue.async {
            guard let treeScene = SCNScene(named: "treewater.dae") else { return }
            
            let treeNode = SCNNode()
            let treeSceneChildNodes = treeScene.rootNode.childNodes
            for childNode in treeSceneChildNodes {
                treeNode.addChildNode(childNode)
            }
            treeNode.position = SCNVector3(x, y, z)
            treeNode.scale = SCNVector3(3, 3, 3)
            self.a.scene.rootNode.addChildNode(treeNode)
        }
    }
    func configureLighting() {
        a.autoenablesDefaultLighting = true
        a.automaticallyUpdatesLighting = true
    }
    @IBAction func showbefore() {
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "gamepage") {
            present(controller, animated: true, completion: nil)
        }
        
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
}
