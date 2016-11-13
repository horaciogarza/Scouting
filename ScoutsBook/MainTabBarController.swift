//
//  MainTabBarController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import Alamofire
import FirebaseStorage

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        //self.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        
//        let tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "more")
//            tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -9, right: 0)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func uploadToFirebase(image: UIImage){
        let storage = FIRStorage.storage()
        let storageRef = storage.reference(forURL: "gs://imageupload-a4be2.appspot.com")
        
        
        /*let nombreImagen = "image-\(Date().timeIntervalSince1970)"
         
         let imageRef = storageRef.child("images/\(nombreImagen)")
         
         // Upload the file to the path "images/rivers.jpg"
         
         let uploadTask = imageRef.putFile(self.imageUrl!, metadata: nil, completion: { (metadata, error) in
         if error != nil {
         print(error!.localizedDescription)
         }else{
         let downloadURL = metadata!.downloadURL()!.absoluteString
         print(downloadURL)
         }
         })*/
        
        
        
        
        let imageData : Data = UIImageJPEGRepresentation(image, 0.4)!
        
        let nombreImagen = "myImage.png"
        
        let imageRef = storageRef.child("images/\(nombreImagen)")
        // Upload the file to the path "images/rivers.jpg"
        var metadata = FIRStorageMetadata()
        metadata.contentType = "image/jpeg"

        
        let uploadTask = imageRef.put(imageData, metadata: metadata, completion: { (metadata, error) in
            if error != nil {
                // Uh-oh, an error occurred!
                print(error!.localizedDescription)
            }else{
                print(metadata)
                let downloadURL = metadata!.downloadURL()!.absoluteString
                //print(downloadURL)
            }
            
        })
        

    }
    
    func sendWatsonRequest(){
        
        let apiKey = "e9b2d83b02a794c8c61219fd956725815d55110a"
        let version = "2016-11-05" // use today's date for the most recent version
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        
        
        let params = ["api_key": "e9b2d83b02a794c8c61219fd956725815d55110a",
                      "url": "https://firebasestorage.googleapis.com/v0/b/imageupload-a4be2.appspot.com/o/12208495_10102454385528521_4749095086285673716_n.jpg?alt=media&token=7689cafb-7dea-4e27-adcc-d66513969f07",
                      "version": "2016-05-20"]
        
        
        var results : String = "Resultados de la imagen\n\n"
        visualRecognition.classify(image: "https://firebasestorage.googleapis.com/v0/b/imageupload-a4be2.appspot.com/o/12208495_10102454385528521_4749095086285673716_n.jpg?alt=media&token=7689cafb-7dea-4e27-adcc-d66513969f07") { [unowned self] (classifiedImages) in
            
            /*for classification in classifiedImages.images{
             print(classification.classifiers)
             }*/
            
            for classification in classifiedImages.images[0].classifiers[0].classes{
                results = results + "Clasificacion: \(classification.classification) \n Probabilidad: \(classification.score) \n\n"
            }
            
            //lo cambias al main para que se pueda mostrar, si no truena.
            DispatchQueue.main.async {
                print( results)
            }
            
        }
//
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
