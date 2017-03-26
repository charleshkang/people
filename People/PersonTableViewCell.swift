//
//  PersonTableViewCell.swift
//  People
//
//  Created by Charles Kang on 3/25/17.
//  Copyright © 2017 Charles Kang. All rights reserved.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    
    @IBOutlet var personIDLabel: UILabel!
    @IBOutlet var personFavCityLabel: UILabel!
    @IBOutlet var personNameLabel: UILabel!
    
    // MARK: Actions
    func configure(with person: Person) {
        personIDLabel.text = "ID: \(String(describing: person.id!))"
        personNameLabel.text = "Name: \(person.name)"
        personFavCityLabel.text = "Fav City: \(person.favoriteCity)"
    }

}
