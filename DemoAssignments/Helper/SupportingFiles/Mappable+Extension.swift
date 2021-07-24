//
//  Mappable+Extension.swift
//  DemoAssignments
//
//  Created by Himanshu on 23/07/2021.
//

import Foundation
import ObjectMapper

extension Mappable {
    var description: String {
        return toJSONString(prettyPrint: true) ?? "\(self)"
    }
}
