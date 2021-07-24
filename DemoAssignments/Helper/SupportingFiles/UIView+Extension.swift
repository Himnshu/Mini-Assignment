//
//  UIView+Extension.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit

extension UIView {
    public func addViewBorder(borderColor:CGColor,borderWith:CGFloat,borderCornerRadius:CGFloat){
        self.layer.borderWidth = borderWith
        self.layer.borderColor = borderColor
        self.layer.cornerRadius = borderCornerRadius
    }
    
    public func swipeRectShape(swipeView : UIView, size: Int) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = swipeView.frame
        rectShape.position = swipeView.center
        rectShape.path = UIBezierPath(roundedRect: swipeView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: size, height: size)).cgPath
        swipeView.layer.mask = rectShape
    }
}
