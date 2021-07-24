//
//  CarouselCell.swift
//  DemoAssignments
//
//  Created by Himanshu on 23/07/2021.
//

import Foundation
import UIKit

class CarouselCell: UICollectionViewCell {
    
    @IBOutlet weak var mImageView: UIImageView!
    
    //MARK: LifeCycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    //MARK: Show Data to UI
    func viewsWithModel(model : CarouselElement) {
        mImageView.image = UIImage.init(named: model.imageUrl)
    }
}
