//
//  LevelViewController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit




class LevelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let arrayLevels:[Level] = [Level(levelImage: UIImageView(),isEnabled: true),
                               Level(levelImage: UIImageView(),isEnabled: false),
                                Level(levelImage: UIImageView(),isEnabled: false)]
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "LevelTableViewCell", bundle: nil), forCellReuseIdentifier: "LevelCell")
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLevels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelTableViewCell
        cell.levelImage = arrayLevels[indexPath.row].levelImage
        
        if(arrayLevels[indexPath.row].isEnabled){
            cell.progress = .Mid
        }else{
            cell.progress = .Low
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
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
