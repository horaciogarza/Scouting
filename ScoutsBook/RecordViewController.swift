//
//  RecordViewController.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/13/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FCAlertView

class RecordViewController: UIViewController{
    
    @IBOutlet var collectionView: UICollectionView!
    
    var RecordItems : [Recents] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let ref = FIRDatabase.database().reference(withPath: "Record")
        
        ref.observe(.value, with: { snapshot in
            
            var records : [Recents] = []
            
            for record in snapshot.children {
                let registro = Recents(snapshot: record as! FIRDataSnapshot )
                /*if registro.UserPin == User.sharedInstance.UserPin {
                 (record).append(registro)
                 }*/
                records.append(registro)
            }
            
            self.RecordItems = records
            self.collectionView.reloadData()
            
        })
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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


extension RecordViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.RecordItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecordCell", for: indexPath) as! RecordCell
        
        let registro = RecordItems[indexPath.row]
        let url : URL = URL(string: registro.Image)!
        do{
            let imageData = try Data(contentsOf: url)
            let imagen = UIImage(data: imageData)
            cell.imageView.image = imagen
        } catch{
            print(error.localizedDescription)
        }
        
        let blue = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1).cgColor
        if cell.gestureRecognizers == nil {
         
         let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.imageLongPressed))
         recognizer.minimumPressDuration = 0.2
         cell.addGestureRecognizer(recognizer)
         
         cell.layer.borderColor = blue
         cell.layer.borderWidth = 2
         //cell.layer.cornerRadius = 0
         }
        
        return cell
    }
    
    
    func imageLongPressed(sender: UILongPressGestureRecognizer){
        if sender.state == .began{
            let cell = sender.view as! RecordCell
            
            if let index = self.collectionView?.indexPath(for: cell) {
                let recuerdo = self.RecordItems[index.row]
                let alert = FCAlertView()
                alert.hideAllButtons = true
                alert.showAlert(inView: self,
                                withTitle: "Memory",
                                withSubtitle: "Best match: \(recuerdo.Decripcion) \n\nDate: \(recuerdo.Fecha)",
                                withCustomImage: #imageLiteral(resourceName: "alertLogo"),
                                withDoneButtonTitle: nil,
                                andButtons: nil)
            }
        }
        
        if sender.state == .ended{
            
        }
    }
    
    /*func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SearchHeader", for: indexPath)
     return header
     }*/
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     let memory = self.filteredMemories[indexPath.row]
     
     let fileManager = FileManager.default
     
     do {
     
     let audioName = audioURL(for: memory)
     let transcriptionName = transcriptionURL(for: memory)
     
     if fileManager.fileExists(atPath: audioName.path) {
     self.audioPlayer = try AVAudioPlayer(contentsOf: audioName)
     self.audioPlayer?.play()
     }
     
     if fileManager.fileExists(atPath: transcriptionName.path){
     let contents = try String(contentsOf: transcriptionName)
     print(contents)
     }
     
     }catch {
     print("Error al cargar el audio para reproducir")
     }
     
     }*/
    
}
