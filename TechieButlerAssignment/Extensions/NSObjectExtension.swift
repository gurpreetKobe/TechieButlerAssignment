//
//  NSObjectExtension.swift
//  TechieButlerAssignment
//
//  Created by Gurpreet Gulati on 01/05/24.
//

import Foundation


extension NSObject {
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}
