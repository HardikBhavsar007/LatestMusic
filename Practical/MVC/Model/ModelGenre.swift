//
//  ModelGenre.swift
//  Practical
//
//  Created by Hardik Bhavsar on 06/10/18.
//  Copyright © 2018 Developer. All rights reserved.
//

import Foundation

class ModelGenre : NSObject, Codable {
    
    var strName : String?
 
    enum CodingKeys: String, CodingKey {
        case strName      = "name"
    }
    
    init(objGenre : Genre) {
        self.strName = objGenre.name
    }

}
