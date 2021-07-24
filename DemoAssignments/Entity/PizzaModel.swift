//
//  PizzaModel.swift
//  DemoAssignments
//
//  Created by Himanshu on 20/07/2021.
//

import Foundation
import ObjectMapper

// MARK: Object Mapper
class ArrayTransformType: TransformType {
    public typealias Object = [PizzaModel]

    func transformToJSON(_ value: [PizzaModel]?) -> [[String : Any]]? {
        guard let pizza = value else { return nil }
        return pizza.map { $0.toJSON() }
    }

    func transformFromJSON(_ value: Any?) -> [PizzaModel]? {
        guard let pizza = value as? [[String: Any]] else { return nil }
        return pizza.compactMap { dictionary -> PizzaModel? in
            if let cat = PizzaModel(JSON: dictionary) { return cat }
            return nil
        }
    }
}

class BaseModel: Mappable, CustomStringConvertible {
    private(set) var Pizza: [PizzaModel] = []
    private(set) var Sushi: [PizzaModel] = []
    private(set) var Drinks: [PizzaModel] = []
    required init?(map: Map) { }

    func mapping(map: Map) {
        Pizza <- (map[kPizza], ArrayTransformType())
        Sushi <- (map[kSushi], ArrayTransformType())
        Drinks <- (map[kDrinks], ArrayTransformType())
    }
}

class PizzaModel: Mappable, CustomStringConvertible {
    private(set) var image: String?
    private(set) var title: String?
    private(set) var description: String?
    private(set) var size: String?
    private(set) var type: String?
    private(set) var price: Int?

    required init?(map: Map) { mapping(map: map) }

    func mapping(map: Map) {
        image <- map["Image"]
        title <- map["Title"]
        description <- map["Description"]
        size <- map["Size"]
        type <- map["Type"]
        price <- map["Price"]
    }
}
