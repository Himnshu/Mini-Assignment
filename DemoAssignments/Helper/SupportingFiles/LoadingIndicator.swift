//
//  LoadingIndicator.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit
import MBProgressHUD


public class Indicator {
    
    public static let sharedInstance = Indicator()
  
    static var isEnabledIndicator = true
    
    func showIndicator(){
        DispatchQueue.main.async( execute: {
            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
            MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        })
    }
 
    func hideIndicator(){
        DispatchQueue.main.async( execute: {
            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
        })
    }
    
}
