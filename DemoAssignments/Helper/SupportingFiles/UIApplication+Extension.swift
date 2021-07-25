//
//  UIApplication.swift
//  DemoAssignments
//
//  Created by Himanshu on 25/07/2021.
//

import Foundation
import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
}
