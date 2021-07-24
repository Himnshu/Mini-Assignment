//
//  CartVCRouter.swift
//  DemoAssignments
//
//  Created by Himanshu on 24/07/2021.
//

import Foundation
import UIKit

struct CartVCRouter: AppRouter {
    static let shared = CartVCRouter()
    typealias routerController = CartVC
    var storyBoard: String = Storyboard.Main.rawValue
    var viewIdentifier: String = ViewIdentifiers.cartVC
    
    // Common method to set Instruction Controller.
    func pushController(fromViewController vc: UIViewController, data: [PizzaModel], previousViewController : UIViewController) {
        let controller = self.getInstance()
        controller.cartItems = data
        controller.delegate = (previousViewController as! DashboadVCDelegate)
        vc.navigationController?.pushViewController(controller, animated: true)
    }
}
