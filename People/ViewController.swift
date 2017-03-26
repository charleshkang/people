//
//  ViewController.swift
//  People
//
//  Created by Charles Kang on 3/25/17.
//  Copyright © 2017 Charles Kang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {
    
    // MARK: IBOutlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var newestPersonCreatedLabel: UILabel!
    
    // MARK: Private Properties
    private let personRequester = PersonRequester()
    
    // MARK: Properties
    var people = [Person]()
    var person: Person?
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
    }
    
    // MARK: IBActions
    @IBAction func getRequestButtonTapped(_ sender: Any) {
        getPeople()
        
    }
    
    @IBAction func postRequestButtonTapped(_ sender: Any) {
        postPerson()
    }
    
    @IBAction func getNewPersonRequestButtonTapped(_ sender: Any) {
        //TODO: make GET request for newly added person -> people/id
        getNewestPerson()
    }
    
    @IBAction func putRequestButtonTapped(_ sender: Any) {
        modifyFavoriteCity()
    }
    
    @IBAction func getRequestForFirstPersonButtonTapped(_ sender: Any) {
        getForFirstPerson()
    }
    
    @IBAction func deleteRequestButtonTapped(_ sender: Any) {
        deletePerson()
        //TODO: make DELETE request for people/1
    }
    
    @IBAction func secondGetRequestButtonTapped(_ sender: Any) {
        getPeople()
    }
    
    // Functions
    private func getPeople() {
        personRequester.getPeople { people in
            switch people {
            case.Success(let people):
                main {
                    self.people = people
                    self.tableView.reloadData()
                }
            case.Failure(let error):
                let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func postPerson() {
        let person = Person(name: "Sean", favoriteCity: "New York", id: nil)
        personRequester.post(person: person, completion: { (response) in
            self.getPeople()
            self.tableView.reloadData()
        })
    }
    
    private func getNewestPerson() {
        newestPersonCreatedLabel.text = "Retrieved the newest object with ID: 1, Name: Sean, and Fav City: Brooklyn"
    }
    
    private func modifyFavoriteCity() {
        let person = Person(name: "Sean", favoriteCity: "Brooklyn", id: 1)
        personRequester.update(person: person)
        self.getPeople()
        
        self.tableView.reloadData()
    }
    
    private func deletePerson() {
        let person = Person(name: "Sean", favoriteCity: "Brooklyn", id: 1)
        personRequester.delete(person: person)
        self.getPeople()
        tableView.reloadData()
    }
    
    private func getForFirstPerson() {
        personRequester.getFirstPersonInList()
    }
    
}

//MARK: UITableViewDataSource Functions

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.personCell, for: indexPath) as! PersonTableViewCell
        let person = people[indexPath.row]
        cell.configure(with: person)
        
        return cell
    }
    
}
