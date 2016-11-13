//
//  userProfileViewController.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit

class userProfileViewController: UIViewController {

    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var progress: UILabel!
    @IBOutlet var userLevel: UILabel!
    @IBOutlet var userToLevel: UILabel!
    @IBOutlet var totalFind: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
        self.profilePicture.clipsToBounds = true//YES;
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "User Profile"
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
