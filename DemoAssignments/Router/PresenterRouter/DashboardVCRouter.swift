//
//  DashboardVCRouter.swift
//  DemoAssignments
//
//  Created by Himanshu on 24/07/2021.
//

import Foundation
import UIKit

struct DashboardVCRouter: AppRouter {
    static let shared = DashboardVCRouter()
    typealias routerController = DashboardViewController
    var storyBoard: String = Storyboard.Main.rawValue
    var viewIdentifier: String = ViewIdentifiers.dashBoardVC
    
    // Common method to set Instruction Controller.
    func pushController(fromViewController vc: UIViewController, data:PizzaModel) {
        let controller = self.getInstance()
        vc.navigationController?.pushViewController(controller, animated: true)
    }
    
//    func openController() {
//        let dashVC = self.getInstance()
//        let navigationController = UINavigationController.init(rootViewController: dashVC)
//        window??.set(rootViewController: navigationController)
//    }
}
