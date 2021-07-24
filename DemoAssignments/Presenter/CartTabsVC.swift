//
//  DemoVC.swift
//  DemoAssignments
//
//  Created by Himanshu on 22/07/2021.
//

import UIKit

import SwipeMenuViewController

class CartTabsVC: SwipeMenuViewController {
    private var swipeCartDatas: [String] = [kCart, kOrders, kInformation] // datas
    var options = SwipeMenuViewOptions()
    var delegate: DashboadVCDelegate?
    var cartItems: [PizzaModel] = []
    //var dataCount: Int = 5
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeCartDatas.forEach { data in
            let vc = CartVCRouter.shared.getInstance()
            vc.title = data
            vc.cartItems = cartItems
            vc.delegate = delegate
            self.addChild(vc)
        }
        super.viewDidLoad()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
