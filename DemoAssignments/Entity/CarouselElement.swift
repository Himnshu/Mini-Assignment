//
//  CarouselElement.swift
//  DemoAssignments
//
//  Created by Himanshu on 23/07/2021.
//

import Foundation

struct CarouselElement {
    var imageUrl    : String
    
    init(imageUrl : String) {
        self.imageUrl   = imageUrl
    }
    
    // MARK: Static methods
    static func createListOfObjects() -> Array<CarouselElement> {
        return  [
            CarouselElement(imageUrl: "carousel_image1"),
            CarouselElement(imageUrl: "carousel_image2"),
            CarouselElement(imageUrl: "carousel_image3"),
            CarouselElement(imageUrl: "carousel_image3"),
        ]
    }
}
