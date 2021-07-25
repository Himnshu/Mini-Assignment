//
//  DashboardTabsVC.swift
//  DemoAssignments
//
//  Created by Himanshu on 22/07/2021.
//

import UIKit

import SwipeMenuViewController

class DashboardTabsVC: SwipeMenuViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var navBarView: UIView!
    
    let closeThresholdHeight: CGFloat = 200 //300
    let openThreshold: CGFloat = UIScreen.main.bounds.height - 400 // 400
    let closeThreshold = UIScreen.main.bounds.height - 200 // 300 // same value as closeThresholdHeight
    var panGestureRecognizer: UIPanGestureRecognizer?
    var animator: UIViewPropertyAnimator?
    
    private var datas: [String] = [kPizza, kSushi, kDrinks]
    var options = SwipeMenuViewOptions()
    //var dataCount: Int = 5
    
    var delegate: DashboadVCDelegate?
    var cartItems: [PizzaModel] = []
    
    private var lockPan = false
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        datas.forEach { data in
            let vc = UIStoryboard(name: Storyboard.Main.rawValue, bundle: nil).instantiateViewController(withIdentifier: ViewIdentifiers.dashBoardVC) as! DashboardViewController
            vc.title = data
            self.addChild(vc)
        }
        
        super.viewDidLoad()
        gotPanned(0)
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(respondToPanGesture))
        view.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.delegate = self
        panGestureRecognizer = gestureRecognizer
    }
    
    //MARK: Animate View
    func gotPanned(_ percentage: Int) {
        if animator == nil {
            animator = UIViewPropertyAnimator(duration: 1, curve: .linear, animations: {
                let scaleTransform = CGAffineTransform(scaleX: 1, y: 5).concatenating(CGAffineTransform(translationX: 0, y: 240))
                self.navBarView.transform = scaleTransform
                self.navBarView.alpha = 0
            })
            animator?.isReversed = true
            animator?.startAnimation()
            animator?.pauseAnimation()
        }
        animator?.fractionComplete = CGFloat(percentage) / 100
    }
    
    //MARK: Observer Method
    @objc func respondToPanGesture(recognizer: UIPanGestureRecognizer) {
        guard !lockPan else { return }
        if recognizer.state == .ended {
            let maxY = UIScreen.main.bounds.height - CGFloat(openThreshold)
            lockPan = true
            if maxY > self.view.frame.minY {
                maximize { self.lockPan = false }
            } else {
                minimize { self.lockPan = false }
            }
            return
        }
        let translation = recognizer.translation(in: self.view)
        moveToY(self.view.frame.minY + translation.y)
        recognizer.setTranslation(.zero, in: self.view)
    }

    //MARK: Animate Maximum View
    func maximize(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, animations: {
            self.moveToY(0)
        }) { _ in
            if let completion = completion {
                completion()
            }
        }
    }

    //MARK: Animate Minimum View
    func minimize(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, animations: {
            self.moveToY(self.closeThreshold)
        }) { _ in
            if let completion = completion {
                completion()
            }
        }
    }

    //MARK: Animate Y-direction
    private func moveToY(_ position: CGFloat) {
        view.frame = CGRect(x: 0, y: position, width: view.frame.width, height: view.frame.height)

        let maxHeight = view.frame.height - closeThresholdHeight
        let percentage = Int(100 - ((position * 100) / maxHeight))

        gotPanned(percentage)

        let name = NSNotification.Name(rawValue: kNotificationName)
        NotificationCenter.default.post(name: name, object: nil, userInfo: [kPercentage: percentage])
    }
    
    // MARK: - SwipeMenuViewDelegate
    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, willChangeIndexFrom fromIndex: Int, to toIndex: Int) {
        super.swipeMenuView(swipeMenuView, willChangeIndexFrom: fromIndex, to: toIndex)
        let previousController = children[fromIndex] as? DashboardViewController
        let controller = children[toIndex] as? DashboardViewController
        if (toIndex == 0) {
            controller?.getPizzaList(indicator: false)
        }
        else if (toIndex == 1) {
            controller?.getSushiList()
        }
        else if (toIndex == 2) {
            controller?.getDrinksList()
        }
        controller?.addedCartItems = previousController!.addedCartItems
        controller?.hub?.setCount((controller?.addedCartItems.count)!)
    }

//    override func swipeMenuView(_ swipeMenuView: SwipeMenuView, didChangeIndexFrom fromIndex: Int, to toIndex: Int) {
//        super.swipeMenuView(swipeMenuView, didChangeIndexFrom: fromIndex, to: toIndex)
//        print("did change from section\(fromIndex + 1)  to section\(toIndex + 1)")
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
