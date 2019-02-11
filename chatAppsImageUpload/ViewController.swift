//
//  ViewController.swift
//  chatAppsImageUpload
//
//  Created by Md. Abdur Rahman Jyoti on 10/2/19.
//  Copyright © 2019 Md. Abdur Rahman Jyoti. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    var ref = DatabaseReference.init() //এই রেফেরেঞ্চের সাহায্যে ডাটা রেড / রায়েত করতে পারব
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference() //ডাটাবেসকে রেফেরাঞ্চে আসসাইন করে দিলাম
        self.saveFIRData()
    }

    @IBAction func buttonSubmitClick(_ sender: UIButton) {
    }
    
    
    func saveFIRData(){
        self.ref.child("chatApps").childByAutoId().setValue("JYOTI")
    }
}

