//
//  LevelViewController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelTableViewCell
        cell.levelImage = UIImageView(image: #imageLiteral(resourceName: "Image"))
        //cell.levelProgressBar.progress = CGFloat(Double(0.7))
        
        
        
        
        return cell
    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("CustomCellOne", forIndexPath: indexPath) as! CustomOneCell
//        
//        cell.middleLabel.text = items[indexPath.row]
//        cell.leftLabel.text = items[indexPath.row]
//        cell.rightLabel.text = items[indexPath.row]
//        
//        return cell
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
