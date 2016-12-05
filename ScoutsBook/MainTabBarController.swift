//
//  MainTabBarController.swift
//  ScoutsBook
//
//  Created by Horacio Garza on 11/12/16.
//  Copyright © 2016 Appdromeda. All rights reserved.
//

import UIKit
import VisualRecognitionV3
import Alamofire
import FirebaseStorage
import FCAlertView

class MainTabBarController: UITabBarController, FCAlertViewDelegate {

    
    //TODO: Fix Alert
    override func viewDidLoad() {
        super.viewDidLoad()

        
        User.sharedInstance.Name = "Mark Zucaritas"
        
        //Creates an alert
        let alert = FCAlertView();
        alert.delegate = self
        alert.colorScheme = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        alert.makeAlertTypeSuccess()
        alert.firstButtonTitleColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        alert.secondButtonTitleColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        alert.secondButtonBackgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        alert.hideDoneButton = true
        alert.dismissOnOutsideTouch = false
        alert.showAlert(inView: self,
                        withTitle: "Welcome back \(User.sharedInstance.Name)",
                        withSubtitle: "Time to explore the world! 🌎",
                        withCustomImage: nil,
                        withDoneButtonTitle: nil,
                        andButtons: ["Let's discover!"])
        
    }


}
