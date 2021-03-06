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

    @IBOutlet weak var uploadImg: UIImageView!
    @IBOutlet weak var txtField: UITextField!
    var ref = DatabaseReference.init() //এই রেফেরেঞ্চের সাহায্যে ডাটা রেড / রায়েত করতে পারব
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference() //ডাটাবেসকে রেফেরাঞ্চে আসসাইন করে দিলাম
       // self.saveFIRData()
        
        //Create tap gesture in UIImage view
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget (self, action: #selector(ViewController.openGallary(tapGesture:)))
        uploadImg.isUserInteractionEnabled = true
        uploadImg.addGestureRecognizer(tapGesture)
        
    }

    //Image Action ready
    @objc func openGallary (tapGesture:UITapGestureRecognizer){
        print("Clicked")
        self.setupImagePicker()
    }
    
    
    @IBAction func buttonSubmitClick(_ sender: UIButton) {
        self.saveFIRData()
    }
    
    
    func saveFIRData(){
        self.UPLOADimg(_image: self.uploadImg.image!){ url in
            
            self.saveImage(name: self.txtField.text!, profileURL: url!){ success in
                if success != nil {
                    print("Yes")
                }
                
            }
            
        }
        
    }
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    //for open gallary
    func setupImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    // delegate mathod for pick image from gallary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        uploadImg.image = image
        self.dismiss(animated: true, completion: nil)
    }
}

extension ViewController{
    // For Upload image
    func UPLOADimg (_image:UIImage, completion:@escaping ((_ url:URL? ) -> ())){
    let storageRef = Storage.storage().reference().child("my_Image.png")
        let imgData = uploadImg.image?.pngData()
        let metaData = StorageMetadata()
        //metaData.contentType = "image/png"
        storageRef.putData(imgData!, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("SUCCESS")
                
                storageRef.downloadURL(completion: { (url, error) in
                    completion (url)
                })
            }else{
                print("Error in save image")
                completion(nil)
            }
        }
    }
    
    
            /*let  dict = ["name" : "Jyoti", "text": txtField.text!]
            self.ref.child("chatApps").childByAutoId().setValue(dict)*/
    
    //For save image
    func saveImage(name: String, profileURL:URL, completion:@escaping((_ url:URL? ) -> ())){
        let  dict = ["name" : "Jyoti", "text": txtField.text!, "profileUrl":profileURL.absoluteString] as [String: Any]
        self.ref.child("chatApps").childByAutoId().setValue(dict)
        
    }
    
}
