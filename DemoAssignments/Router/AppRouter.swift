//
//  AppRouter.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit

protocol AppRouter {
    associatedtype routerController: UIViewController
    var storyBoard: String { get set }
    var viewIdentifier: String { get set }
    var window: UIWindow?? { get }

    func getInstance() -> routerController
    func getTransition() -> CATransition
}


extension AppRouter {
    func getInstance() -> routerController {
        return UIStoryboard(name: storyBoard, bundle: nil).instantiateViewController(withIdentifier: viewIdentifier) as! routerController
    }
    
    func getTransition() -> CATransition {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.fade
        return transition
    }
    
    var window: UIWindow??{
        get {
            return UIApplication.shared.delegate?.window
        }
    }
}
