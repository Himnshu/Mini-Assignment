//
//  DashboardTableCell.swift
//  DemoAssignments
//
//  Created by Himanshu on 20/07/2021.
//

import UIKit

//MARK: Protocol for cell button action in View controller
protocol DashboardCellDelegate {
    func priceBtnAction(_ index: Int, cell: DashboardTableCell)
}

class DashboardTableCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var mImage: UIImageView!
    @IBOutlet weak var mTitleLbl: UILabel!
    @IBOutlet weak var mDescriptionLbl: UILabel!
    @IBOutlet weak var mSizeLbl: UILabel!
    @IBOutlet weak var mPriceBtn: UIButton!
    
    var mPizzaModel : PizzaModel?
    var delegate : DashboardCellDelegate?
    var index : Int = 0
    
    //MARK: LifeCycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.backgroundColor = .white
        cardView.layer.cornerRadius = 10.0
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        cardView.layer.shadowRadius = 6.0
        cardView.layer.shadowOpacity = 0.7
        
        mImage.swipeRectShape(swipeView: mImage, size : 10)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: Show Data to UI
    func viewData(pizzaModel: PizzaModel) {
        self.mPizzaModel = pizzaModel
        mImage.image = UIImage.init(named: pizzaModel.image!)
        mTitleLbl.text = pizzaModel.title
        mDescriptionLbl.text = pizzaModel.description!
        mSizeLbl.text = pizzaModel.size
        mPriceBtn.backgroundColor = UIColor.black
        mPriceBtn.setTitle("\(pizzaModel.price!) usd", for: .normal)
    }
    
    @IBAction func PriceBtnAction(_ sender: Any) {
        delegate?.priceBtnAction(index, cell: self)
    }
}
