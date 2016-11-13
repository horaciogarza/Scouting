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

class CamaraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        takePhoto()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        if let imagen = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            UIImageWriteToSavedPhotosAlbum(imagen, self, #selector(self.getImageUrl(_:didFinishSavingWithError:contextInfo:)), nil)
            
            //dismiss(animated: true, completion: nil)
        }
    }
    
    func getImageUrl(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            // we got back an error!
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchOptions.fetchLimit = 1
            
            let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            if (fetchResult.firstObject != nil)
            {
                let lastImageAsset = fetchResult.firstObject! as PHAsset
                lastImageAsset.requestContentEditingInput(with: PHContentEditingInputRequestOptions()) { (input, _) in
                    let url = input?.fullSizeImageURL
                    self.sendWatsonRequest(url : url!)
                }
            }
        }
    }
    

    func sendWatsonRequest(url : URL){
        
        let apiKey = "e9b2d83b02a794c8c61219fd956725815d55110a"
        let version = "2016-11-05" // use today's date for the most recent version
        let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)
        
        var results : String = "Resultados de la imagen\n\n"
        visualRecognition.classify(image: url.description) { [unowned self] (classifiedImages) in
            
            
            for classification in classifiedImages.images[0].classifiers[0].classes{
                results = results + "Clasificacion: \(classification.classification) \n Probabilidad: \(classification.score) \n\n"
            }
            
            print(results)
            //dismiss(animated: true, completion: nil)
            //lo cambias al main para que se pueda mostrar, si no truena.
            DispatchQueue.main.async {
                //self.textView.text = results
            }
            
        }
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
