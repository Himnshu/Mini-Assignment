//
//  AppHelper.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit

class AppHelper{
    static func showAlert(title: String, subtitle: String = ""){
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: title, message: subtitle, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window!.rootViewController?.present(alert, animated: true, completion: nil)
        })
    }
    static func showAlert(_ saError: SAError){
        guard let description = saError.description else {
            self.showAlert(title: kError, subtitle: saError.error.localizedDescription)
            return
        }
        self.showAlert(title: kError, subtitle: description)
    }
}
