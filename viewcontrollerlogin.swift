//
//  viewcontrollerlogin.swift
//  treeapp2
//
//  Created by Apple on 2019/5/8.
//  Copyright © 2019 Apple. All rights reserved.
//

import UIKit

class viewcontrollerlogin: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func ldf(){
        if let controller = storyboard?.instantiateViewController(withIdentifier: "treepage") {
                present(controller, animated: true, completion: nil)
            }
    }
    
}
