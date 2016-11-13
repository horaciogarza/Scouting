//
//  LevelViewController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit




class LevelViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    let arrayLevels:[Level] = [Level(levelImage: #imageLiteral(resourceName: "NIVEL 2") ,isEnabled: true, numberLevelProgress: 0.5),
                               Level(levelImage: #imageLiteral(resourceName: "NIVEL 1"),isEnabled: false, numberLevelProgress: 0.0),
                               Level(levelImage: #imageLiteral(resourceName: "NIVEL 3"), isEnabled: false, numberLevelProgress: 0.0)]
    
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let imgBackground = UIImageView(image: #imageLiteral(resourceName: "TAREAS - BACKGROUD"))
        self.tableView.backgroundView = imgBackground
        

        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "LevelTableViewCell", bundle: nil), forCellReuseIdentifier: "LevelCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = "Level"
        
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
        
        //let cell = Bundle.main.loadNibNamed("LevelTableViewCell", owner: self, options: nil)?.first as! LevelTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "LevelCell", for: indexPath) as! LevelTableViewCell
        cell.levelImage.image = arrayLevels[indexPath.row].levelImage
        
        if(arrayLevels[indexPath.row].isEnabled){
            cell.numberLevelProgress = arrayLevels[indexPath.row].numberLevelProgress
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
