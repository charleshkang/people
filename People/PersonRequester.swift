//
//  PersonRequester.swift
//  People
//
//  Created by Charles Kang on 3/25/17.
//  Copyright © 2017 Charles Kang. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

func main(function: @escaping () -> Void) {
    
    DispatchQueue.main.async( execute: {
        function()
    })
}

func background(function: @escaping () -> Void) {
    
    DispatchQueue.global(qos: .background).async {
        function()
    }
}

class PersonRequester {
    
    let personParser = PersonParser()
    
    func getPeople(`for` completion: ((Result<[Person]>) -> Void)?) {
        background {
            Alamofire.request(Constant.baseURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: { (response) in
                guard let statusCode = response.response?.statusCode else {
                    main { completion?(.Failure(.UnexpectedError)) }
                    return
                }
                guard statusCode == SuccessStatusCode.OK.rawValue else {
                    print(statusCode)
                    main { completion?(.Failure(RequestError(code: statusCode))) }
                    return
                }
                guard let jsonData = response.data else {
                    main { completion?(.Failure(.UnexpectedError)) }
                    return
                }
                let json = JSON(data: jsonData)
                let people = self.personParser.parsePersonJSON(json: json)
                main { completion?(.Success(people)) }
            })
        }
        
    }
    func post(person: Person, completion: @escaping (DataResponse<Any>) -> Void) {
        let newPersonParams: [String: AnyObject] = [
            "name": person.name as AnyObject,
            "favoriteCity": person.favoriteCity as AnyObject
        ]
        Alamofire.request(Constant.baseURL, method: .post, parameters: newPersonParams, encoding: JSONEncoding.default, headers: nil).responseJSON(completionHandler: completion)
    }
    
    func update(with person: Person) {
        let params: [String: AnyObject] = [
            "name": person.name as AnyObject,
            "favoriteCity": person.favoriteCity as AnyObject
        ]
        if let id = person.id {
            Alamofire.request("\(Constant.baseURL)\(id)", method: .put, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                if let error = response.result.error {
                    Alert.error(message: "\(error)", title: "Error")
                }
            }
        }
    }
    
    func delete(person: Person) {
        if let id = person.id {
            Alamofire.request("\(Constant.baseURL)\(id)", method: .delete, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
                if let error = response.result.error {
                    Alert.error(message: "\(error)", title: "Error")
                }
            }
        }
    }
    
}
