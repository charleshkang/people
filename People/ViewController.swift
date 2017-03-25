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
    
    // MARK: Private Properties
    private let personRequester = PersonRequester()
    
    // MARK: Properties
    var allPeople = [Person]()

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
        //TODO: make POST request
    }
    
    @IBAction func getNewPersonRequestButtonTapped(_ sender: Any) {
        //TODO: make GET request for newly added person -> people/id
    }
    
    @IBAction func putRequestButtonTapped(_ sender: Any) {
        //TODO: make PUT request
    }
    
    @IBAction func getRequestForFirstPersonButtonTapped(_ sender: Any) {
        //TODO: make GET request for people/1
    }
    
    @IBAction func deleteRequestButtonTapped(_ sender: Any) {
        //TODO: make DELETE request for people/1
    }
    
    @IBAction func secondGetRequestButtonTapped(_ sender: Any) {
        getPeople()
    }
    
    // Functions
    private func getPeople() {
        personRequester.getPeople { people in
            //            self.activityIndicator.isHidden = false
            switch people {
            case.Success(let people):
                main {
                    self.allPeople = people
                    self.tableView.reloadData()
                }
            case.Failure(let error):
                let alertController = UIAlertController(title: "Error", message: "\(error)", preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    private func postPerson() {
    
    }
    
    
    
}

//MARK: UITableViewDataSource Functions

extension ViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allPeople.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constant.personCell, for: indexPath) as! PersonTableViewCell
        let person = allPeople[indexPath.row]
        cell.configure(with: person)
        return cell
    }
    
}
