//
//  PersonParser.swift
//  People
//
//  Created by Charles Kang on 3/25/17.
//  Copyright © 2017 Charles Kang. All rights reserved.
//

import Foundation
import SwiftyJSON

class PersonParser {
    
    func parsePeopleJSON(json: JSON) -> [Person] {
        let allPeople = json
        
        return allPeople.flatMap { (_, result)  in
            let name = result["name"].stringValue
            let favoriteCity = result["favoriteCity"].stringValue
            let id = result["id"].intValue
            
            return Person(name: name, favoriteCity: favoriteCity, id: id)
        }
    }
//    func parsePersonJSON(json: JSON) -> Person {
//        let person = json
//        
//        
//    }
    
}
