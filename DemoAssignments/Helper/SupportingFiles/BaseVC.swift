//
//  BaseVC.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import UIKit

class BaseVC: UIViewController {

    var hub : BadgeHub?
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setBackButton()
        hub = BadgeHub(view: UIView())
        // Do any additional setup after loading the view.
    }
    
    
    func setBackButton() {
        let backButton = UIBarButtonItem()
        backButton.title = kBackTitle
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController!.navigationBar.tintColor = UIColor.black
    }
    
    func setFloatingButton(mFloatingBtn: UIButton, IsCart: Bool) {
        if (IsCart) {
            mFloatingBtn.setImage(UIImage.init(named: kCartImage), for: .normal)
        }
        else {
            mFloatingBtn.setImage(UIImage.init(named: kCardImage), for: .normal)
        }
        
        mFloatingBtn.backgroundColor = .white
        mFloatingBtn.layer.shadowColor = UIColor.gray.cgColor
        mFloatingBtn.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        mFloatingBtn.layer.shadowRadius = 6.0
        mFloatingBtn.layer.shadowOpacity = 0.3
    }
    
    func setupBadgeButton(hub: BadgeHub, mFloatingBtn: UIButton) {
        hub.moveCircleBy(x: -10, y: 8)
    }
    
    func setupFilterView(mBtn : UIButton, IsSelected: Bool) {
        mBtn.isSelected = IsSelected
        if (!IsSelected) {
            mBtn.addViewBorder(borderColor: UIColor.lightGray.cgColor, borderWith: 0.7, borderCornerRadius: 14)
        }
        else {
            mBtn.addViewBorder(borderColor: UIColor.green.cgColor, borderWith: 0.7, borderCornerRadius: 14)
        }
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
