//
//  viewcontrollerlog.swift
//  treeapp2
//
//  Created by Apple on 2019/5/8.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

var uid = -1
var modes = -1
class viewcontrollerlog: UIViewController,UITextViewDelegate {
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    let URL_EXECSQLUPDATE = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlUpdate.php"
    @IBOutlet weak var accounttext: UITextField!
    @IBOutlet weak var passwordtext: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        uid = -1
        modes = -1
        //waitSign.isHidden = true
    }
    
    @IBAction func check_click(_ sender: Any) {

        checkIdentity()

        Thread.sleep(forTimeInterval:0.8)
        
        print("/////")
        print(flag)

        if(uid > 0){
            if let controller = storyboard?.instantiateViewController(withIdentifier: "gamepage") as? viewcontroller_game {
                //controller.uid = self.uid
                present(controller, animated: true, completion: nil)
                
            }
        }else{
            let alertController = UIAlertController(title: "提醒", message: "登入失敗", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
  
    @IBAction func showgameno(){
        
        //clear pre-visitor
        visitorPlantDelete()
        visitorReadDelete()
        visitorCollectionDelete()
        visitorTreeDelete()
        visitorStoryDelete()
        modesUpdate()
        
        //insert visitor
        visitorToolInsert()
        
        uid = 1
        modes = 0
        Thread.sleep(forTimeInterval:0.8)
        if let controller = storyboard?.instantiateViewController(withIdentifier: "gamepage") {
            present(controller, animated: true, completion: nil)
        }
    }
    @IBAction func signup(){
        if let controller = storyboard?.instantiateViewController(withIdentifier: "signup") {
            present(controller, animated: true, completion: nil)
        }
    }
    func checkIdentity(){
        let requestURL = NSURL(string: URL_EXECSQLSELECT)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlSelect"
        let value = "select * from member where account = '" + accounttext.text! + "' and password = '" + passwordtext.text! + "'"
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
                
                    let passi = jsonString.range(of: "password\" : \"")
                    let passj = jsonString.range(of: "\",")
                    let passStr = String(jsonString[(passi?.upperBound)!..<(passj?.lowerBound)!])
                    var newi = jsonString.range(of: "account\" : \"")
                    var newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let acci = newstr.range(of: "account\" : \"")
                    let accj = newstr.range(of: "\",")
                    let accStr = String(newstr[(acci?.upperBound)!..<(accj?.lowerBound)!])
                    newi = jsonString.range(of: "modes\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let modesi = newstr.range(of: "modes\" : \"")
                    let modesj = newstr.range(of: "\",")
                    let modesStr = String(newstr[(modesi?.upperBound)!..<(modesj?.lowerBound)!])
                    newi = jsonString.range(of: "uid\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let uidi = newstr.range(of: "uid\" : \"")
                    let uidj = newstr.range(of: "\"\n")
                    let uidStr = String(newstr[(uidi?.upperBound)!..<(uidj?.lowerBound)!])
                    
                    
                    uid = Int(uidStr) ?? 0
                    print(uid)
                    print(accStr)
                    print(passStr)
                    modes = Int(modesStr) ?? 0
                    print(modes)
                    
                    
                 
  
                }
 
                //switch to main thread
                
                
            } catch {
                print(error)
            }
        }
        task.resume()
       // return flag
    }
    
    //visitor
    func visitorToolInsert() {
        
     
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "insert into collection (uid, water, fertilizer) values ('1','1','1')"
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
                print("visitortoolsuccess")
                
            } catch {
                print(error)
            }
        }
        //executing the task
        task.resume()
    }

    //clear pre_visitor
    func visitorPlantDelete() {
        
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "delete from plant where uid = '1'"
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
    
    func visitorCollectionDelete() {
        
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "delete from collection where uid = '1'"
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
    
    func visitorReadDelete() {
        
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "delete from read where uid = '1'"
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
    
    func visitorTreeDelete() {
        
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "delete from tree where uid = '1'"
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
    
    func visitorStoryDelete() {
        
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "delete from story where uid = '1'"
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
    
    func modesUpdate() {
        
       
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "update member set modes = '0' where uid = '1'"
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

