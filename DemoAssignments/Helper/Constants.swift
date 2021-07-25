//
//  Constants.swift
//  DemoAssignments
//
//  Created by Himanshu on 21/07/2021.
//

import Foundation

//Error messages
let kError                   = "Error"
let kNoMessage               = "No Message"
let kNoInternetConnection    = "Please check your internet connection"
let kErrorCreatingEndPoint   = "Error in creating endpoint"

// Currency Constant
let kPriceCurrency           = "usd"

let kCart                    = "Cart"
let kOrders                  = "Orders"
let kInformation             = "Information"

let kPizza                   = "Pizza"
let kSushi                   = "Sushi"
let kDrinks                  = "Drinks"

let AppName = "Demo Assignment"


struct APIEndpoint {
    static let kDataFile                = "data.json"
}


struct CellIdentifier {
    static let dashBoardTableViewCell       = "DashboardCell"
    static let cartTableViewCell            = "CartCell"
}

struct ViewIdentifiers {
    static let dashBoardVC               = "DashboardVC"
    static let cartVC                    = "CartVC"
    static let cartTabsVC                = "CartTabsVC"
    static let dashboardTabsVC           = "DashboardTabsVC"
}
