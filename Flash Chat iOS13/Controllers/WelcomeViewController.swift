//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    //let initialText = "⚡️FlashChat"
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.blue)
        //titleLabel.text = K.appName// "⚡️FlashChat"
        
//        DispatchQueue.global(qos: .userInteractive).async {
//            for letter in self.initialText {
//               DispatchQueue.main.async { [weak self] in
//                   self?.titleLabel.text?.append(letter)
//                }
//                usleep(70000)
//            }
//        }
    }
    

}
