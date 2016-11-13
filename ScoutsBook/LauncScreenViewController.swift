//
//  LauncScreenViewController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/13/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit

class LauncScreenViewController: UIViewController {

    @IBOutlet var myFirstLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UIView.animate(withDuration: 1.5, animations: {
            self.myFirstLabel.alpha = 1.0
        })
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
