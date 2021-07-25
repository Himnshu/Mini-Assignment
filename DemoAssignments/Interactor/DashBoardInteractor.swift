//
//  DashBoardInteractor.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation
import UIKit
import Moya
import Alamofire
import RxSwift

class DashBoardInteractor: NSObject {
    
    let disposeBag = DisposeBag.init()
    
    //MARK: Moya Network Layer
    fileprivate let simpleStubProvider = MoyaProvider<NetworkAPI>(stubClosure: MoyaProvider.delayedStub(0.5), plugins: [NetworkLoggerPlugin(verbose: true)])
    
    
    
    //MARK: GET PIZZAS
    func getPizzaJsonList(indicator: Bool, completion: @escaping (_ result: Result<[PizzaModel], SAError>) -> ()) {
        if (indicator) {
            Indicator.sharedInstance.showIndicator()
        }
        simpleStubProvider.rx.request(.getCommonJsonList).asObservable().filterSuccessfulStatusCodes().subscribeOn(MainScheduler.instance).subscribe(onNext: { response in
            do {
                if let dict = try JSONSerialization.jsonObject(with: response.data.stringEncoded.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    if let data = BaseModel(JSON: dict) {
                        print("===============\n\(data.Pizza)")
                        completion(.success(data.Pizza)!)
                    }
                }
            }
            catch {
                completion(.fail(SAError.init(error)))
            }
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    
    
    //MARK: GET SUSHIS
    func getSushiJsonList(completion: @escaping (_ result: Result<[PizzaModel], SAError>) -> ()) {
        simpleStubProvider.rx.request(.getCommonJsonList).asObservable().filterSuccessfulStatusCodes().subscribeOn(MainScheduler.instance).subscribe(onNext: { response in
            do {
                if let dict = try JSONSerialization.jsonObject(with: response.data.stringEncoded.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    if let data = BaseModel(JSON: dict) {
                        print("===============\n\(data.Sushi)")
                        completion(.success(data.Sushi)!)
                    }
                }
            }
            catch {
                completion(.fail(SAError.init(error)))
            }
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
    
    
    
    //MARK: GET DRINKS
    func getDrinksJsonList(completion: @escaping (_ result: Result<[PizzaModel], SAError>) -> ()) {
        simpleStubProvider.rx.request(.getCommonJsonList).asObservable().filterSuccessfulStatusCodes().subscribeOn(MainScheduler.instance).subscribe(onNext: { response in
            do {
                if let dict = try JSONSerialization.jsonObject(with: response.data.stringEncoded.data(using: .utf8)!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    if let data = BaseModel(JSON: dict) {
                        print("===============\n\(data.Drinks)")
                        completion(.success(data.Drinks)!)
                    }
                }
            }
            catch {
                completion(.fail(SAError.init(error)))
            }
        }, onError: { error in
            print(error)
        }).disposed(by: disposeBag)
    }
}


// MARK: Network API Extensions
enum NetworkAPI {
    case getCommonJsonList
}

extension NetworkAPI: TargetType {
    var baseURL: URL {
        let url = "https://Yoururlhere/api/v1"
        return URL.init(string: url)!
    }
    
    var path: String {
        switch self {
        case .getCommonJsonList:
            return ""
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var sampleData: Data {
        switch self {
        case .getCommonJsonList:
            if let path = Bundle.main.path(forResource: "data", ofType: "json") {
                do {
                    let text = try String(contentsOfFile: path, encoding: .utf8)
                    return text.dataEncoded
                  } catch {
                }
            }
            
            return "".dataEncoded
        }
    }
}
