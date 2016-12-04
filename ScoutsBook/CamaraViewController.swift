//
//  CamaraViewController.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//
import UIKit
import Photos
//import VisualRecognitionV3

import Alamofire
import FirebaseStorage
import FirebaseDatabase
import FCAlertView



class CamaraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FCAlertViewDelegate {
    
    @IBOutlet var tapImage: UIImageView!
    var selectedImageUrl: String?
    var bestResultString : String = "Unkown"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTapPhoto()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addTapPhoto(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(takePhoto))
        tap.numberOfTapsRequired = 1
        self.tapImage.addGestureRecognizer(tap)
    }
    
    func takePhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = false
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func resizeImage (imagen: UIImage, to width: CGFloat) -> UIImage? {
        let scaleFactor = width/imagen.size.width
        
        let height = imagen.size.height * scaleFactor
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        
        imagen.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let imagen = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let newImage = resizeImage(imagen: imagen, to: 300)
            uploadToFirebase(image: newImage!)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func uploadToFirebase(image: UIImage){
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://imageupload-a4be2.appspot.com")
        
        let imageData : Data = UIImageJPEGRepresentation(image, 0.7)!
        
        let nombreImagen = "\(Date().timeIntervalSince1970).png"
        
        let imageRef = storageRef.child("images/\(nombreImagen)")
        // Upload the file to the path "images/rivers.jpg"
        let metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"
        
        
        let uploadTask = imageRef.put(imageData, metadata: metadata, completion: { (metadata, error) in
            if error != nil {
                // Uh-oh, an error occurred!
                print(error!.localizedDescription)
            }else{
                print(metadata ?? "there's nothing")
                let downloadURL = metadata!.downloadURL()!.absoluteString
                print(downloadURL)
                self.selectedImageUrl = downloadURL
                self.analyzeFromURLDidPush(image)
            }
            
        })
        
        
    }
    
    func analyzeFromURLDidPush(_ image: UIImage) {
        
        let analyzeImage = CognitiveServices.sharedInstance.analyzeImage
        let visualFeatures: [AnalyzeImage.AnalyzeImageVisualFeatures] = [.Categories, .Description, .Faces]
        let requestObject: AnalyzeImageRequestObject = (image, visualFeatures)
        
        try! analyzeImage.analyzeImageWithRequestObject(requestObject, completion: { (response) in
            DispatchQueue.main.async(execute: {
                print(response?.descriptionText ?? "no hay default")
            })
        })
        
        
    }
    
    
        
    }
    
    func fcAlertView(_ alertView: FCAlertView!, clickedButtonIndex index: Int, buttonTitle title: String!) {
        if title == "Save" {
            print("Se Guardo")
            
            let ref = FIRDatabase.database().reference(withPath: "Record")
            let imageName = "\(Int(Date().timeIntervalSince1970))"
            let recetaItemRef = ref.child(imageName)
            
//            let imagen : Recents = Recents(UserPin: 123, Image: selectedImageUrl!, Fecha: Date().description, Decripcion: self.bestResultString)
            
            //recetaItemRef.setValue(imagen.toAnyObject())
            
            
        }else if title == "Don't Save"{
            print("No se guardo")
            
        }
    }
    

    

    //MARK: Alamofire
    
    



