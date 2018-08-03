//
//  ProfileModel.swift
//  TravelBoard
//
//  Created by Vineet Baid on 5/12/18.
//  Copyright © 2018 Vineet Baid. All rights reserved.
//

import Foundation
struct Profile {
    var name: String 
    var imageString : String
    var nationality : String
    var currentCity : String
    var uID : String
    
    func turnToDictionary() -> [String:String]{
        return ["User ID" : uID, "Full Name" : name, "Image URL" : imageString, "Current City" : currentCity, "Nationality" : nationality]
        
    }
    
    //Ideally both nationality and current city would be enums that could be dropdowns or long lists -> Will be done in 2.0 version of this app.
    

    
}


