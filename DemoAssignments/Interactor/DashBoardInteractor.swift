//
//  DashBoardInteractor.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit

class DashBoardInteractor: NSObject {
    //MARK: Object Mapper
    func getCommonJsonList(completion: @escaping (_ result: Result<[String: Any], SAError>) -> ()) {
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let text = try String(contentsOfFile: path, encoding: .utf8)
                if let dict = try JSONSerialization.jsonObject(with: text.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    completion(.success(dict))
                }
              } catch {
                completion(.fail(SAError.init(error)))
            }
        }
    }
    
    //MARK: GET PIZZAS
    func getPizzaJsonList(completion: @escaping (_ result: Result<[PizzaModel], SAError>) -> ()) {
        self.getCommonJsonList() { (data) in
            switch (data) {
                case .success(let responses):
                    if let data = BaseModel(JSON: responses) {
                        print("===============\n\(data.Pizza)")
                        completion(.success(data.Pizza)!)
                    }
                    break
                case .fail(let error):
                    completion(.fail(error))
                    break
            }
        }
    }
    
    //MARK: GET SUSHIS
    func getSushiJsonList(completion: @escaping (_ result: Result<[PizzaModel], SAError>) -> ()) {
        self.getCommonJsonList() { (data) in
            switch (data) {
                case .success(let responses):
                    if let data = BaseModel(JSON: responses) {
                        print("===============\n\(data.Sushi)")
                        completion(.success(data.Sushi)!)
                    }
                    break
                case .fail(let error):
                    completion(.fail(error))
                    break
            }
        }
    }
    
    //MARK: GET DRINKS
    func getDrinksJsonList(completion: @escaping (_ result: Result<[PizzaModel], SAError>) -> ()) {
        self.getCommonJsonList() { (data) in
            switch (data) {
                case .success(let responses):
                    if let data = BaseModel(JSON: responses) {
                        print("===============\n\(data.Drinks)")
                        completion(.success(data.Drinks)!)
                    }
                    break
                case .fail(let error):
                    completion(.fail(error))
                    break
            }
        }
    }
}
