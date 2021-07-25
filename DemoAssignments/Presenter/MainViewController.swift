//
//  ViewController.swift
//  DemoAssignments
//
//  Created by Himanshu on 19/07/2021.
//

import UIKit
import SwipeMenuViewController

class MainViewController: BaseVC, UICollectionViewDataSource,
                          UICollectionViewDataSourcePrefetching,
                          UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var carouselView: UICollectionView!
    @IBOutlet weak var carouselPageControl: UIPageControl!
    
    
    var animator: UIViewPropertyAnimator?
    var modelList = CarouselElement.createListOfObjects()
    var carouselTimer : Timer?
    
    //MARK: LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.isTranslucent = true
//        self.navigationController?.view.backgroundColor = .clear
        createBottomView()
        configureCarousel()
        configureCarouselPageControl()
        let name = NSNotification.Name(rawValue: "DashboardViewMoved")
        NotificationCenter.default.addObserver(forName: name, object: nil, queue: nil, using: receiveNotification(_:))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func configureCarousel() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0

        carouselView.collectionViewLayout = flowLayout
        carouselView.showsHorizontalScrollIndicator = false
        carouselView.showsVerticalScrollIndicator = false
        carouselView.isPagingEnabled = true
        carouselView.allowsMultipleSelection = false
        
        carouselView.delegate = self
        carouselView.dataSource = self
        carouselView.prefetchDataSource = self
        carouselView.isPrefetchingEnabled = true
        
        carouselTimer = Timer.scheduledTimer(timeInterval: 3.0,
                                             target: self,
                                             selector: #selector(carouselTimerNextImage),
                                             userInfo: nil,
                                             repeats: true)
    }
    
    func configureCarouselPageControl() {
        carouselPageControl.numberOfPages = modelList.count
        carouselPageControl.currentPage = 0
    }
    
     //MARK: Timer Functions
     @objc fileprivate func carouselTimerNextImage() {
        var newIndex = carouselPageControl.currentPage + 1
        if(newIndex >= modelList.count) {
            newIndex = 0
        }
        self.carouselView.scrollToItem(at: IndexPath(item: newIndex, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    //MARK: Animate View
    func subViewGotPanned(_ percentage: Int) {
        guard let propAnimator = animator else {
            animator = UIViewPropertyAnimator(duration: 3, curve: .linear, animations: {
                self.blackView.alpha = 1
//                self.blackView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: 0, y: -20))
                self.carouselView.alpha = 1
                self.carouselPageControl.alpha = 1
                self.carouselView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: 0, y: -20))
                self.carouselPageControl.transform = CGAffineTransform(scaleX: 0.8, y: 0.8).concatenating(CGAffineTransform(translationX: 0, y: -20))
            })
            animator?.startAnimation()
            animator?.pauseAnimation()
            return
        }
        propAnimator.fractionComplete = CGFloat(percentage) / 100
    }

    //MARK: Observer Method
    func receiveNotification(_ notification: Notification) {
        guard let percentage = notification.userInfo?["percentage"] as? Int else { return }
        subViewGotPanned(percentage)
    }

    //MARK: Create Dashboard View
    func createBottomView() {
        guard let sub = storyboard!.instantiateViewController(withIdentifier: ViewIdentifiers.dashboardTabsVC) as? DashboardTabsVC else { return }
        self.addChild(sub)
        sub.view.swipeRectShape(swipeView: sub.view, size: 30)
        self.view.addSubview(sub.view)
        sub.didMove(toParent: self)
        sub.view.frame = CGRect(x: 0, y: view.frame.maxY, width: view.frame.width, height: view.frame.height)
        sub.minimize(completion: nil)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Carousel", for: indexPath) as! CarouselCell
        cell.viewsWithModel(model: modelList[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        for currenCell : UICollectionViewCell in carouselView.visibleCells {
            let currentCellIndexPath = carouselView.indexPath(for: currenCell)
            if(currentCellIndexPath != indexPath) {
                carouselPageControl.currentPage = currentCellIndexPath?.row ?? 0
            }
        }
    }
    
    // MARK: UICollectionViewDataSourcePrefetching
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
