//
//  CartCell.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import UIKit

//MARK: Protocol for cell button action in View controller
protocol CartCellDelegate {
    func cancelBtnAction(_ index: Int)
}

class CartCell: UITableViewCell {

    @IBOutlet weak var mCardView: UIView!
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mTitleLbl: UILabel!
    @IBOutlet weak var mPriceLbl: UILabel!
    @IBOutlet weak var mCancelBtn: UIButton!
    
    var delegate : CartCellDelegate?
    var index : Int = 0
    
    //MARK: LifeCycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let origImage = UIImage(named: "cancel")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        mCancelBtn.setImage(tintedImage, for: .normal)
        mCancelBtn.tintColor = .lightGray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: Show Data to UI
    func viewData(pizzaModel: PizzaModel) {
        mImage.image = UIImage.init(named: pizzaModel.image!)
        mTitleLbl.text = pizzaModel.title
        mPriceLbl.text = "\(pizzaModel.price!) \(kPriceCurrency)"
    }
    
    func updateTotal(pizzaModels: [PizzaModel]) -> Int {
        let total = pizzaModels.map { $0.price! }.reduce(0, +)
        return Int(total)
    }
    
    @IBAction func cancelBtnAction(_ sender: Any) {
        delegate?.cancelBtnAction(index)
    }
}
