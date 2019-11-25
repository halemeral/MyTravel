//
//  City.swift
//  FirebaseTest
//
//  Created by hale on 1.11.2019.
//  Copyright © 2019 hale. All rights reserved.
//

import Foundation
import GoogleMaps

struct City:Codable {
    
    var id: Int
    var countryId : Int
    var name: String
    var date : Date
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
    var dateSnippet: String
    
    /* let Id : Int?
     let CountryId : Int?
     let Name: String?
     let Year : Date?
     let Latitude: Float?
     let Longitude: Float?
    */
    
    /*CountryId = 9;
    
    Id = 52;
    
    Latitude = "38.7350900000";
    
    Longitude = "-9.1590900000";
    
    Name = Lisbon;
    
    Year = "2015-01-01 00:00:00.0000000";*/
    
    init(){
        
        self.countryId = 0
        self.id = 0
        self.name =  "no name"
        self.date = Date.init()
        self.latitude = CLLocationDegrees.init()
        self.longitude = CLLocationDegrees.init()
        self.dateSnippet = "no date"
    }

}

