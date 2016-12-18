//
//  SettingsViewController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 12/17/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet var navBar: UINavigationBar!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     navBar.tintColor = #colorLiteral(red: 0.9176470588, green: 0.1490196078, blue: 0.09019607843, alpha: 1)
     navBar.backgroundColor = UIColor.white
        //UINavigationBar.appearance().
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
