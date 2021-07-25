//
//  DashboardViewController.swift
//  DemoAssignments
//
//  Created by Himanshu on 20/07/2021.
//

import UIKit

protocol DashboadVCDelegate {
    func checkCountBadge(index: Int)
}

class DashboardViewController: BaseVC {
    @IBOutlet weak var mTableView: UITableView!
    @IBOutlet weak var mFloatingBtn: UIButton!
    @IBOutlet weak var mFilterView: UIView!
    @IBOutlet weak var mSpicyBtn: UIButton!
    @IBOutlet weak var mVeganBtn: UIButton!
    @IBOutlet var dashboardInteractorServices: DashBoardInteractor!
    
    var IsItemAddedInCart = false
    var addedCartItems = [PizzaModel]()
    var parentMockDatas = [PizzaModel]()
    var mockDatas = [PizzaModel]()
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hub = BadgeHub(view: mFloatingBtn)
        setupBadgeButton(hub: self.hub!, mFloatingBtn: mFloatingBtn)
        setFloatingButton(mFloatingBtn: mFloatingBtn, IsCart: true)
        setupFilterView(mBtn: mSpicyBtn, IsSelected: false)
        setupFilterView(mBtn: mVeganBtn, IsSelected: false)
        getPizzaList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hub?.setCount(self.addedCartItems.count)
    }
    
    //MARK: Network Call Service
    func getPizzaList() {
        dashboardInteractorServices.getPizzaJsonList() { (data) in
            switch (data) {
                case .success(let responses):
                    self.mFilterView.isHidden = false
                    if (self.parentMockDatas.count > 0) {
                        self.parentMockDatas.removeAll()
                    }
                    if (self.mockDatas.count > 0) {
                        self.mockDatas.removeAll()
                    }
                    self.parentMockDatas = responses
                    self.mockDatas = responses
                    self.mTableView.reloadData()
                    break
                case .fail(let error):
                    AppHelper.showAlert(error)
                    break
            }
        }
    }
    
    func getSushiList() {
        dashboardInteractorServices.getSushiJsonList() { (data) in
            switch (data) {
                case .success(let responses):
                    self.mFilterView.isHidden = false
                    if (self.parentMockDatas.count > 0) {
                        self.parentMockDatas.removeAll()
                    }
                    if (self.mockDatas.count > 0) {
                        self.mockDatas.removeAll()
                    }
                    self.parentMockDatas = responses
                    self.mockDatas = responses
                    self.mTableView.reloadData()
                    break
                case .fail(let error):
                    AppHelper.showAlert(error)
                    break
            }
        }
    }
    
    func getDrinksList() {
        dashboardInteractorServices.getDrinksJsonList() { (data) in
            switch (data) {
                case .success(let responses):
                    self.mFilterView.isHidden = true
                    if (self.parentMockDatas.count > 0) {
                        self.parentMockDatas.removeAll()
                    }
                    if (self.mockDatas.count > 0) {
                        self.mockDatas.removeAll()
                    }
                    self.parentMockDatas = responses
                    self.mockDatas = responses
                    self.mTableView.reloadData()
                    break
                case .fail(let error):
                    AppHelper.showAlert(error)
                    break
            }
        }
    }
    
    @IBAction func floatingBtnAction(_ sender: Any) {
        self.navigationController?.navigationBar.backItem?.backButtonTitle = kBackTitle
        CartTabsVCRouter.shared.pushController(fromViewController: self, data: addedCartItems, previousViewController: self)
    }
    
    @IBAction func spicyBtnAction(_ sender: Any) {        
        if (mSpicyBtn.isSelected) {
            setupFilterView(mBtn: mSpicyBtn, IsSelected: false)
            mockDatas = parentMockDatas
            mTableView.reloadData()
        }
        else {
            setupFilterView(mBtn: mSpicyBtn, IsSelected: true)
            let filtered = parentMockDatas.filter { item in
                return (item.type?.contains(kSpicy))!
            }
            
            mockDatas = filtered
            mTableView.reloadData()
        }

        setupFilterView(mBtn: mVeganBtn, IsSelected: false)
    }
    
    @IBAction func veganBtnAction(_ sender: Any) {
        if (mVeganBtn.isSelected) {
            setupFilterView(mBtn: mVeganBtn, IsSelected: false)
            mockDatas = parentMockDatas
            mTableView.reloadData()
        }
        else {
            setupFilterView(mBtn: mVeganBtn, IsSelected: true)
            let filtered = parentMockDatas.filter { item in
                return (item.type?.contains(kVegan))!
            }
            
            mockDatas = filtered
            mTableView.reloadData()
        }

        setupFilterView(mBtn: mSpicyBtn, IsSelected: false)
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
extension DashboardViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.dashBoardTableViewCell) as! DashboardTableCell
        let pizzaModel = mockDatas[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
        cell.viewData(pizzaModel: pizzaModel)
        return cell
    }
}

// MARK: Dashboard Cell Delegate
extension DashboardViewController : DashboardCellDelegate {
    func priceBtnAction(_ index: Int, cell: DashboardTableCell) {
        let pizzaModel = mockDatas[index]
        if (!self.IsItemAddedInCart) {
            self.IsItemAddedInCart = true
            cell.mPriceBtn.backgroundColor = UIColor.green
            cell.mPriceBtn.setTitle(kAddedItem, for: .normal)
            addedCartItems.append(pizzaModel)
            self.hub?.increment()
            self.hub?.pop()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
                // change label here
                self.IsItemAddedInCart = false
                cell.mPriceBtn.backgroundColor = UIColor.black
                cell.mPriceBtn.setTitle("\(pizzaModel.price!) \(kPriceCurrency)", for: .normal)
            }
        }
    }
}

// MARK: Dashboard Pop Delegate
extension DashboardViewController : DashboadVCDelegate {
    func checkCountBadge(index : Int) {
        addedCartItems.remove(at: index)
        hub?.setCount(index)
    }
}
