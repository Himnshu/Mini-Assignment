//
//  Data+Extension.swift
//  DemoAssignments
//
//  Created by Himanshu on 25/07/2021.
//

import Foundation

extension Data {
    var stringEncoded: String {
        return String(decoding: self, as: UTF8.self)
    }
}
