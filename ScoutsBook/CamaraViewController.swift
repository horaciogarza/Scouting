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
    
    /*func sendWatsonRequest(_ url: String){
        
        let apiKey = "e9b2d83b02a794c8c61219fd956725815d55110a"
        let version = "2016-11-05" // use today's date for the most recent version
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        var sucess : Bool = false
        var bestResult : Double = 0.0
        //var results : String = "Resultados de la imagen\n\n"
        var results : String = ""
        //visualRecognition.classify(image: url) { [unowned self] (classifiedImages) in
            
            
//            for classification in classifiedImages.images[0].classifiers[0].classes{
//                results = results + "This image could be: \(classification.classification) \n probability: \(classification.score*100)% \n\n"
//                sucess = true
//                if classification.score*100 > bestResult {
//                    bestResult = classification.score*100
//                    self.bestResultString = classification.classification
//                }
//            }

            print(results)
            //lo cambias al main para que se pueda mostrar, si no truena.
            DispatchQueue.main.async {
                if sucess {
                    let alert = FCAlertView()
                    alert.delegate = self
                    alert.colorScheme = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    alert.makeAlertTypeSuccess()
                    alert.firstButtonTitleColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    alert.secondButtonTitleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    alert.secondButtonBackgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    alert.hideDoneButton = true
                    alert.dismissOnOutsideTouch = false
                    alert.showAlert(inView: self,
                                    withTitle: "Image Results",
                                    withSubtitle: results,
                                    withCustomImage: nil,
                                    withDoneButtonTitle: nil,
                                    andButtons: ["Save", "Don't Save"])
                }else{
                
                    let alert = FCAlertView()
                    alert.delegate = self
                    alert.colorScheme = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    alert.firstButtonTitleColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    alert.secondButtonTitleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    alert.secondButtonBackgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
                    alert.hideDoneButton = true
                    alert.dismissOnOutsideTouch = false
                    alert.showAlert(inView: self,
                                    withTitle: "Unable to identify",
                                    withSubtitle: "It looks that the image didn't enter any of the categories",
                                    withCustomImage: #imageLiteral(resourceName: "question-icon-29-2"),
                                    withDoneButtonTitle: nil,
                                    andButtons: ["Save", "Don't Save"])
                }
            }
            
        }*/
        //
        
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
    
    



