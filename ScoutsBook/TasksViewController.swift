//
//  TasksViewController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/13/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LevelCell{
    var imageTask:UIImage!
    var status:String!
    var name:String!
    var discoveredDate:String!
    
    init(){
        imageTask = UIImage()
        status = ""
        name = ""
        discoveredDate = ""
    }
}

class TasksViewController: UIViewController, UITableViewDataSource {

    let cellToFill:[LevelCell]! = nil
    
    @IBOutlet var Image: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var discoveredDateLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let ref = FIRDatabase.database().reference(withPath: "firstLevel")
        
        
        ref.observe(.value, with: { snapshot in
            
            print(snapshot.children)
            //var records : [Recents] = []
            
//            for record in snapshot.children {
//                let registro = Recents(snapshot: record as! FIRDataSnapshot )
//                /*if registro.UserPin == User.sharedInstance.UserPin {
//                 (record).append(registro)
//                 }*/
//                records.append(registro)
//            }
//            
//            self.RecordItems = records
           //self.tableView.reloadData()
            
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 1
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
