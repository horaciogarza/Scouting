//
//  userProfileViewController.swift
//  ScoutsBook
//
//  Created by Abraham Barcenas M on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet var profilePicture: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userLevel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
        self.profilePicture.clipsToBounds = true//YES;
        // Do any additional setup after loading the view.
        
        
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().backgroundColor = #colorLiteral(red: 0.3079536855, green: 0.4243280292, blue: 0.7189489007, alpha: 1)
        
        User.sharedInstance.Name = "Mark Zucaritas"
        userName.text = User.sharedInstance.Name
        
        userLevel.text = String(User.sharedInstance.Level)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    

}
