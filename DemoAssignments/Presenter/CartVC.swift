//
//  CartVC.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import UIKit
import SwipeMenuViewController

class CartVC: BaseVC {
    
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mFloatingBtn: UIButton!
    @IBOutlet weak var mTotalLbl: UILabel!
    
    var delegate: DashboadVCDelegate?
    var cartItems: [PizzaModel] = []
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        //setFloatingButton(mFloatingBtn: mFloatingBtn, IsCart: false)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setFloatingButton(mFloatingBtn: mFloatingBtn!, IsCart: false)
        self.mTableView.reloadData()
    }
    
    
    @IBAction func floatingBtnAction(_ sender: Any) {
        self.navigationController!.popViewController(animated: true)
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

// MARK: Tableview DataSource
extension CartVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.cartTableViewCell) as! CartCell
        let pizzaModel = cartItems[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
        cell.viewData(pizzaModel: pizzaModel)
        self.mTotalLbl.text = "\(cell.updateTotal(pizzaModels: cartItems)) \(kPriceCurrency)"
        return cell
    }
}

// MARK: Cart Cell Delegate
extension CartVC : CartCellDelegate {
    func cancelBtnAction(_ index: Int) {
        cartItems.remove(at: index)
        self.delegate?.checkCountBadge(index: cartItems.count)
        mTableView.reloadData()
        if (cartItems.count == 0) {
            self.navigationController!.popViewController(animated: true)
        }
    }
}
