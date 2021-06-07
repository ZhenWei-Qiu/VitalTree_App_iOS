//
//  viewcontrollersignup.swift
//  treeapp2
//
//  Created by Apple on 2019/5/8.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class viewcontrollersignup: UIViewController {
    
    //URL to our web service
    let URL_EXECSQLSELECT = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlSelect.php"
    let URL_EXECSQLUPDATE = "http://ec2-18-191-28-176.us-east-2.compute.amazonaws.com/meditree/api/execSqlUpdate.php"
    var signuid = -1
    @IBOutlet weak var accText: UITextField!
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var surepassText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func showlogin(){
        if(passText.text == surepassText.text){
            identityInsert(acc: accText.text!, pass: passText.text!)
            Thread.sleep(forTimeInterval:0.8)
            getIdentityUid(acc: accText.text!, pass: passText.text!)
            Thread.sleep(forTimeInterval:0.8)
            print(self.signuid)
            toolInsert()
            if let controller = storyboard?.instantiateViewController(withIdentifier: "login") {
                present(controller, animated: true, completion: nil)
                }
        }else{
            let alertController = UIAlertController(title: "提醒", message: "密碼不一致", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    func getIdentityUid(acc:String, pass:String)  {
        
        
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLSELECT)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlSelect"
        let value = "select * from member where account = '" + acc + "' and password = '" + pass + "'"
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
                    newi = jsonString.range(of: "uid\" : \"")
                    newstr = String(jsonString[(newi?.lowerBound)!... ])
                    let uidi = newstr.range(of: "uid\" : \"")
                    let uidj = newstr.range(of: "\"\n")
                    let uidStr = String(newstr[(uidi?.upperBound)!..<(uidj?.lowerBound)!])
                    
                    
                    
                    self.signuid = Int(uidStr) ?? 0
                    print(self.signuid)
                    print(accStr)
                    print(passStr)
                
                }
                //switch to main thread
                
                
            } catch {
                print(error)
            }
        }
        
        print("uid")
        print(self.signuid)
        //executing the task
        task.resume()
        
    }
    
    func identityInsert(acc:String, pass:String) {
        
   
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "insert into member (account, password, modes) values ('" + acc + "', '" + pass + "', '0')"
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
    
    func toolInsert() {
        
        let uidStr = String(signuid)
        //created NSURL
        let requestURL = NSURL(string: URL_EXECSQLUPDATE)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest(url: requestURL! as URL)
        
        //setting the method to post
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //getting values from text fields
        let key = "sqlUpdate"
        let value = "insert into collection (uid, water, fertilizer) values ('" + uidStr + "','1','1')"
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
                print("toolsuccess")
                
            } catch {
                print(error)
            }
        }
        //executing the task
        task.resume()
    }
    
}
