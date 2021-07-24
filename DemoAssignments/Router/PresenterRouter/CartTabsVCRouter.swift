//
//  CartVCRouter.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit

struct CartTabsVCRouter: AppRouter {
    static let shared = CartTabsVCRouter()
    typealias routerController = CartTabsVC
    var storyBoard: String = Storyboard.Main.rawValue
    var viewIdentifier: String = ViewIdentifiers.cartTabsVC
    
    // Common method to set Instruction Controller.
    func pushController(fromViewController vc: UIViewController, data: [PizzaModel], previousViewController : UIViewController) {
        let controller = self.getInstance()
        controller.cartItems = data
        controller.delegate = (previousViewController as! DashboadVCDelegate)
        vc.navigationController?.pushViewController(controller, animated: true)
    }
}
