//
//  CamaraViewController.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//
import UIKit
import Photos
import VisualRecognitionV3
//import AWSCore
//import AWSS3
import AlamofireImage
import Alamofire
import FirebaseStorage
import FCAlertView


class CamaraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FCAlertViewDelegate {
    
    var selectedImageUrl: URL?
    var selectedimage : UIImage?
    
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
        self.view.addGestureRecognizer(tap)
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        selectedImageUrl = info[UIImagePickerControllerReferenceURL] as? URL
        selectedimage = info[UIImagePickerControllerOriginalImage] as?  UIImage
        
        
        if let imagen = info[UIImagePickerControllerOriginalImage] as? UIImage {
            uploadToFirebase(image: imagen)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func uploadToFirebase(image: UIImage){
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://imageupload-a4be2.appspot.com")
        
        let imageData : Data = UIImageJPEGRepresentation(image, 0.4)!
        
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
                print(metadata)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                print(downloadURL)
                self.sendWatsonRequest(downloadURL)
            }
            
        })
        
        
    }
    
    func sendWatsonRequest(_ url: String){
        
        let apiKey = "e9b2d83b02a794c8c61219fd956725815d55110a"
        let version = "2016-11-05" // use today's date for the most recent version
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        var sucess : Bool = false
        //var results : String = "Resultados de la imagen\n\n"
        var results : String = ""
        visualRecognition.classify(image: url) { [unowned self] (classifiedImages) in
            
            /*for classification in classifiedImages.images{
             print(classification.classifiers)
             }*/
            
            for classification in classifiedImages.images[0].classifiers[0].classes{
                results = results + "This image could be: \(classification.classification) \n probability: \(classification.score*100)% \n\n"
                sucess = true
            }

            print(results)
            //lo cambias al main para que se pueda mostrar, si no truena.
            DispatchQueue.main.async {
                if sucess {
                    let alert = FCAlertView()
                    
                    alert.colorScheme = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    alert.makeAlertTypeSuccess()
                    alert.showAlert(inView: self,
                                    withTitle: "Image Results",
                                    withSubtitle: results,
                                    withCustomImage: nil,
                                    withDoneButtonTitle: nil,
                                    andButtons: nil)
                }else{
                
                    let alert = FCAlertView()
                    
                    alert.colorScheme = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    alert.makeAlertTypeSuccess()
                    alert.showAlert(inView: self,
                                    withTitle: "Unable to identify",
                                    withSubtitle: "It looks that the image didn't enter any of the categories",
                                    withCustomImage: nil,
                                    withDoneButtonTitle: nil,
                                    andButtons: nil)
                }
            }
            
        }
        //
        
    }

    //MARK: Alamofire
    
    
}


