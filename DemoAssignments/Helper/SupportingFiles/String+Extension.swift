//
//  String+Extension.swift
//  DemoAssignments
//
//  Created by Himanshu on 25/07/2021.
//

import Foundation

extension String {
    var dataEncoded: Data{
        return self.data(using: String.Encoding.utf8)!
    }
}
