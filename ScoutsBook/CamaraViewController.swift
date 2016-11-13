//
//  CamaraViewController.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//
import UIKit
import Photos

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
                    print(url)
                }
                print(lastImageAsset)
            }
            dismiss(animated: true, completion: nil)
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
