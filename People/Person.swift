//
//  Person.swift
//  People
//
//  Created by Charles Kang on 3/25/17.
//  Copyright © 2017 Charles Kang. All rights reserved.
//

import Foundation

struct Person {
    let name: String
    let favoriteCity: String
    let id: Int?
    
    // MARK: Lifecycle
    init(name: String,
         favoriteCity: String,
         id: Int?) {
        self.name = name
        self.favoriteCity = favoriteCity
        self.id = id
    }
}
