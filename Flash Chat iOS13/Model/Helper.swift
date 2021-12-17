//
//  Helper.swift
//  Flash Chat iOS13
//
//  Created by Sebastian Buquet on 14/12/2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import Foundation
import UIKit

struct Helper {
    static func showAlert(message: String, controller : UIViewController) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        // Create OK button
        let OKAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
            print("Ok button tapped");
        }
        alertController.addAction(OKAction)
        // Create Cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) {
            (action: UIAlertAction!) in print("Cancel button tapped");
        }
        alertController.addAction(cancelAction)
        // Present Dialog message
        controller.present(alertController, animated: true, completion: nil)
    }
}
