//
//  DashBoardVCRouter.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit

struct DashBoardTabsVCRouter: AppRouter {
    static let shared = DashBoardTabsVCRouter()
    typealias routerController = DashboardTabsVC
    var storyBoard: String = Storyboard.Main.rawValue
    var viewIdentifier: String = ViewIdentifiers.dashboardTabsVC
    
    // Common method to set Instruction Controller.
    func pushController(fromViewController vc: UIViewController, data:PizzaModel) {
        let controller = self.getInstance()
        vc.navigationController?.pushViewController(controller, animated: true)
    }
}
