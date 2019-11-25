//
//  Model.swift
//  FirebaseTest
//
//  Created by hale on 2.11.2019.
//  Copyright © 2019 hale. All rights reserved.
//

import Foundation

struct Model: Codable{
    
    enum MyEnum: Int, Codable {
        case one, two, three
    }
    
    let stringExample: String
    let booleanExample: Bool
    let numberExample: Double
    let dateExample: Date
    let arrayExample: [String]
    let optionalExample: Int?
    let objectExample: [String: String]
    let myEnumExample: MyEnum
    
    
}
